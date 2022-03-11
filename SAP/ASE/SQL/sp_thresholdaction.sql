drop procedure sp_thresholdaction
create procedure sp_thresholdaction
  @dbname varchar(30),
  @segmentname varchar(30),
  @space_left int,
  @status int
as
declare
 @logname varchar(30),
 @stdate varchar(30),
 @procinf varchar(255),
 @spidnum int,
 @eolc char(1)
 select @eolc = char(10)
 select @logname = l.name, @spidnum = h.spid, @stdate = convert( char(28), starttime, 109 )
   from master..syslogshold h, master..syslogins l, master..sysprocesses p
   where h.spid = p.spid AND h.dbid = db_id( @dbname ) AND p.suid = l.suid

 print "Transaction log filling up : database '%1!', threshold '%2!' login '%3!' starting '%4!'",
         @dbname, @space_left, @logname, @stdate
 print "hostname:program_name:hostprocess:cmd:tran_name:clientname:clienthostname:clientapplname:ipaddr"

 select @procinf=hostname+":"+program_name+":"+hostprocess+":"+cmd+":"+tran_name+":"+
                     clientname+":"+clienthostname+":"+clientapplname+":"+ipaddr
   from master..sysprocesses where spid = @spidnum
 print "'%1!'", @procinf
 print "Transaction log filling up, end of report '%1!'", @eolc

drop procedure sp_thresholdreport
create procedure sp_thresholdreport
  @dbname varchar(30),
  @segmentname varchar(30),
  @space_left int,
  @status int
as
declare
 @logname varchar(30),
 @stdate varchar(30),
 @procinf varchar(255),
 @spidnum int,
 @eolc char(1)
 select @eolc = char(10)
 select @logname = l.name, @spidnum = h.spid, @stdate = convert( char(28), starttime, 109 )
   from master..syslogshold h, master..syslogins l, master..sysprocesses p
   where h.spid = p.spid AND h.dbid = db_id( @dbname ) AND p.suid = l.suid

 print "Transaction report : database '%1!', threshold '%2!' login '%3!' starting '%4!'",
         @dbname, @space_left, @logname, @stdate



create procedure sp_thresholdaction
  @dbname varchar(30),
  @segmentname varchar(30),
  @space_left int,
  @status int
as
declare
 @devname varchar(100),
 @before_size int,
 @after_size int,
 @error int,
 @onec char(1)
begin
 select @onec=substring( "DEVICENAMETODUMP", 1, 1 )
 if ( @onec = "/" )
  begin
   select @devname="DEVICENAMETODUMP"+@@servername+"_"+@dbname+
       convert( varchar(10), getdate(), 112 )+
       substring( convert( varchar(10), getdate(), 108 ), 1, 2 )+
       substring( convert( varchar(10), getdate(), 108 ), 4, 2 )+
       substring( convert( varchar(10), getdate(), 108 ), 7, 2 )+
       substring( convert( varchar(30), getdate(), 109 ), 22, 3 )+".dmp"
  end
  else
  begin
   select @devname="DEVICENAMETODUMP"
  end
 select ">>>"+@devname+"<<<"
 if @segmentname = (select name from syssegments where segment = 2)
  begin
   if ( @status < 2 )
    begin
     print "LOG DUMP:database '%1!', threshold '%2!'", @dbname, @space_left
    end
   if ( @dbname in ( select name from master..sysdatabases
                       where dbid not between 4 and 31510 OR
                             status & 8 > 0 ) )
    begin
     dump transaction @dbname with truncate_only
     select @error = @@error
    end
    else
    begin
     dump transaction @dbname to @devname
     -- dump  transaction @dbname to "sybackup::-SCHED transaction_dump"
     select @error = @@error
    end
   if @error != 0
    begin
     if ( @status < 2 )
      begin
       print "WARNING LOG DUMP ON EMERGENCY:database '%1!' on '%2!'",
                                           @dbname, @devname
      end
     -- dump transaction @dbname to "sybackup::-SCHED transaction_dump"
     dump transaction @dbname to @devname
     select @error = @@error
     if @error != 0
      begin
       print "LOG DUMP ERROR: %1!", @error
       return 1
     end
    end
   if ( @status < 2 )
    begin
     select @after_size = reserved_pgs(id, doampg)
      from sysindexes
      where sysindexes.name = "syslogs"
      print "LOG DUMPED TO: device '%1!", @devname
      print "LOG DUMP PAGES: Before: '%1!', After '%2!'", @before_size,
        @after_size
    end
  end
  else
  begin
   print "THRESHOLD WARNING: database '%1!', segment '%2!' at '%3!' pages",
    @dbname, @segmentname, @space_left
  end
 end
