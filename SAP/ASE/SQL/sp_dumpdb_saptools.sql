--script to set up stored procedure sp_dumpdb in database saptools
--version 1.0.2
--date 04 Oct 2012 
--changes: 
--1.0.1 fix issue that cause sp to not run in jobscheduler 
--1.0.2 no change

use saptools
go
if not exists (select name from sysobjects where name = 'dump_history' and type = 'U')
begin
  exec('create table dump_history (DBName VARCHAR(30), Type VARCHAR(10), Command VARCHAR(512), StartTime DATETIME, EndTime DATETIME, RC INTEGER, Status CHAR(1))')
end
go
if exists (select name from sysobjects where name = 'sp_dumpdb' and type = 'P')
begin
  drop procedure sp_dumpdb
end
go
create procedure sp_dumpdb (@sapdb_name varchar (256))
as
begin
  declare @sqlstatus smallint
  declare @sqlerror int
  declare @curr_logdev varchar(1024)
  declare @current_ts char(19)
  declare @starttime datetime
  declare @dumpcmd varchar(1024)
  declare @sjobid int
  declare @sec_past int
  declare @backup_active int
  declare @dbid smallint

  commit
  set chained on
  set quoted_identifier on
  
  set @sqlerror = 0 
  set @sqlstatus = 0 
  
  -- is it a valid DB name?
  select @dbid = db_id(@sapdb_name)
  if @dbid IS NULL
  begin
    print '%1! is not a valid database name', @sapdb_name
    select @sqlerror=-100
    commit
    goto exit_sp
  end
  
  -- work-around JS timing issue
  -- 1. determine own sched_job_id
  SELECT @sjobid = jsh_sjobid FROM sybmgmtdb..js_history WHERE jsh_spid = @@spid AND jsh_jobend IS NULL AND jsh_state='R2' AND jsh_exit_code = 0 
  -- 2. get seconds since last execution
  SELECT @sec_past = datediff(ss,MAX(jsh_jobstart),current_bigdatetime()) FROM sybmgmtdb..js_history WHERE jsh_sjobid = @sjobid AND jsh_jobend IS NOT NULL
  -- 3. skip dump trans if last execution time is within the past 120sec
  if @sjobid IS NULL or @sjobid < 1 or @sec_past > 120 or @sec_past IS NULL
  begin
    -- ensure no dump database is running
    select @backup_active = BackupInProgress from master..monOpenDatabases where DBName = @sapdb_name
    if @backup_active = 0
    begin
    -- execute dump db
      select @starttime = getdate()
      select @current_ts = CONVERT(varchar,@starttime,23)
      select @current_ts = str_replace(@current_ts,':','_') 
      select @curr_logdev = '/sybase/'+ @@servername + '/backups/'+@sapdb_name+'_'+@current_ts+'.dmp'
      select @dumpcmd = 'dump database ' || @sapdb_name || ' to "' || @curr_logdev || '" with compression = 101'
      insert into saptools..dump_history(DBName,Type,Command,StartTime,EndTime,RC,Status) VALUES (@sapdb_name,'DB',@dumpcmd,@starttime,NULL,NULL,'R')
      commit
      exec(@dumpcmd)
      select @sqlstatus = @@sqlstatus, @sqlerror = @@error 
      if @sqlerror <> 0 
      begin 
        update saptools..dump_history set EndTime = getdate(), Status = 'E', RC = @sqlerror where StartTime = @starttime
      end
      else
      begin
        update saptools..dump_history set EndTime = getdate(), Status = 'F', RC = 0 where StartTime = @starttime
      end
      commit
    end
    else
    begin
      insert into saptools..dump_history(DBName,Type,Command,StartTime,EndTime,RC,Status) VALUES (@sapdb_name,'DB','',getdate(),getdate(),0,'S')
      print 'skipping database dump due to an active database backup'
      select @sqlerror=-100
      commit
    end
  end
  
  exit_sp:
  if (@sqlerror<>0) 
  return @sqlerror
  else
  return 0
end

go
