--script to set a very basic sp_thresholdaction in <DBISD> database 
--version 1.0.2
--date 04 Oct 2012 
--changes: 
--1.0.1 no changes
--1.0.2 switch to <DBSID> database automatically 

--------------------------------------------------------------------------------
-- determine SAP database
--------------------------------------------------------------------------------
declare SAPDB_CURSOR cursor FOR SELECT name FROM master..sysdatabases WHERE name NOT LIKE 'syb%' AND name NOT IN ('master','model','saptools') AND durability = 1 AT ISOLATION 0
go
declare @sap_dbname varchar(30)
declare @svers_full varchar(128)
declare @objid      integer
open SAPDB_CURSOR
fetch SAPDB_CURSOR into @sap_dbname
while @@sqlstatus = 0
begin
  set @svers_full = @sap_dbname || '.SAPSR3.SVERS'
  SELECT @objid = object_id(@svers_full)
  if @objid > 0
  begin
    -- got it
        break
  end
  else
  begin
    -- next database
    fetch SAPDB_CURSOR into @sap_dbname
  end
end
close SAPDB_CURSOR
deallocate SAPDB_CURSOR

IF @sap_dbname <> ''
begin
  print "SAP database name is %1!", @sap_dbname
end
else
begin
  print "Unable to identify SAP database."
  select syb_quit()
end

use @sap_dbname
go

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'sp_thresholdaction' AND u.name = 'dbo' AND o.type = 'P')
BEGIN
	setuser 'dbo'
	drop procedure sp_thresholdaction
END
go 

setuser 'dbo'
go 

create procedure sp_thresholdaction
  @dbname varchar(30),
  @segmentname varchar(30),
  @free_space int,
  @status int
as
begin
   declare @error int

   print "Database '%1!': Begin LCT Log Dump for '%2!': Only '%3!' kb free space left ", @dbname, @segmentname, @free_space

   exec saptools..sp_dumptrans @dbname

  /* error checking */
   select @error = @@error
   if (@error != 0)
     print "Database '%1!': LCT Log Dump for '%2!' finished with error '%3!'! ", @dbname, @segmentname, @error
   else 
   /* print messages to error log */
   print "Database '%1!': LCT Log Dump finished", @dbname
end

IF (@@error != 0)
BEGIN
        PRINT 'Error %1! CREATING Stored Procedure sp_thresholdaction'
        SELECT syb_quit()
END
go 
