--script to back up pubs2 database
--sp_dumptdb procedure into master database
--5:15 PM Monday, August 15, 2016

use pubs2
go
--check presence of 'dump_history' table
if not exists (SELECT name FROM sysobjects WHERE name = 'dump_history' AND type = 'U')
begin
	exec('CREATE TABLE dump_history (DBName VARCHAR(50), Type VARCHAR(10), Command VARCHAR(500), StartTime DATETIME, EndTime DATETIME, Err INTEGER, Status CHAR(1))')
end
go
--re-create procedure sp_dumptrans
if exists (SELECT name FROM sysobjects WHERE name = 'sp_dumpdb' and type = 'P')
begin
	drop procedure sp_dumpdb
end
go

create procedure sp_dumpdb (@dbname varchar (256))
as
begin
	declare @sqlstatus smallint
	declare @sqlerror int
	declare @curr_logdev varchar(1024)
	declare @starttime datetime
	declare @dumpcmd varchar(1024)
	commit
	
	set @sqlstatus = 0
	set @sqlerror = 0
	
	begin
		select @starttime = getdate()
		select @curr_logdev = '/home/sybase/' + @@servername + '.trn'
		select @dumpcmd = 'dump database' + @dbname + ' to "' + @curr_logdev + '" with compression = 0'
		INSERT INTO master..dump_history(DBName, Type, Command, StartTime, EndTime, Status) VALUES (@dbname, 'DB', @dumpcmd, @starttime, NULL, NULL, 'R')
		commit
		--execute sp_dumptrans
		exec(@dumpcmd)
		select @sqlstatus = @@sqlstatus
		select @sqlerror = @@error
		if @sqlerror <> 0
		begin
			UPDATE master..dump_history SET EndTime = getdate(), Status = 'E', Err = @sqlerror WHERE StartTime = @starttime
		end
		else
		begin
			UPDATE master..dump_history SET EndTime = getdate(), Status = 'F', Err = 0 WHERE StartTime = @starttime
		end
		commit	
	end
	
	exit_err:
	if (@sqlerror <> 0)
		return @sqlerror
	else
		return 0
end
go