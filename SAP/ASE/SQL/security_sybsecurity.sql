--install the sybsecurity database:
-- prequisity add physical devices
-- mklv -y  'devicename' -t ...
-- change owner of devices
-- chown devicename (chmod 770)

disk init
name = "sybsecurity_data",
physname = "/opt/sybase/data/sybsecurity_data.dat",
size = '500M'
go

disk init
name = "sybsecurity_data2",
physname = "/opt/sybase/data/sybsecurity_data2.dat",
size = '500M'
go

disk init
name = "sybsecurity_log",
physname = "/opt/sybase/data/sybsecurity_log.dat",
size = '500M'
go

--create sybsecurity database

use master
go
create database sybsecurity on sybsecurity_data=500 log on sybsecurity_log=500
go

alter database sybsecurity on sybsecurity_data2=500
go

--exec installsecurity script
sp_configure "auditing", 1
go
--& restart

use sebsecurity
go
sp_addaudittable sybsecurity_data2
go


--Enable trunc log on check point option
use master 
go 
sp_dboption sybsecurity , "trunc log on chkpt", true
go
use sybsecurity
go
checkpoint
go
sp_dboption sybsecurity, "select into/bulkcopy/pllsort", true
go
use sybsecurity
go
checkpoint
go


-- Drop system & default segments from devices, note that to delete only from the extra devices not the main one
sp_dropsegment 'system', sybsecurity, sybsecurity_data2
go
sp_dropsegment 'default', sybsecurity, sybsecurity_data2
go

-- Check thresholds

use sybsecurity
go
sp_helpthreshold 
go
sp_helpdb sybsecurity

use master
go


--In case you want to archive the audit information, you need to send the information from the audit tables to the archive_db database, then truncate the audit tables to start register auditing infromation again
--Steps to create archive database:

disk init
name = "arch_audit_data01",
physname = "D:\sybase\data\arch_audit_data01",
size = '5G'
go
disk init
name = "arch_audit_log01",
physname = "D:\sybase\data\arch_audit_log01",
size = '1G'
go

create database archive_db on arch_audit_data01 = '5G'
log on arch_audit_log01 = '1G'
go
use archive_db
go

create table audit_archive
( event smallint not null,
eventmod smallint not null,
spid smallint not null,
eventtime datetime not null,
sequence smallint not null,
suid int not null,
dbid smallint null,
objid int null,
xactid binary(6) null,
loginname varchar(30) null,
dbname varchar(30) null,
objname varchar(255) null,
objowner varchar(30) null,
extrainfo varchar(255) null,
nodeid tinyint null)
go


--Create the procedure to send the data from the audit tables to the archive_db database:

use sybsecurity
go
create procedure audit_thresh as
declare @audit_table_number int
/*
** This procedure assumes that 2 tables are configured for auditing
** Select the value of the current audit table
*/
select @audit_table_number = scc.value
from master..syscurconfigs scc, master..sysconfigures sc
where sc.config=scc.config and sc.name = "current audit table"
/*
** Set the next audit table to be current.
** When the next audit table is specified as 0, the value is automatically set to the next one.
*/
/*
0 mean use the second audit table, for example if you on audit table 1, so the next will be audit table 2
with truncate: specifies that Adaptive Server should truncate the new table if it is not already empty. sp_configure fails if this option is not specified and the table is not empty.*/

exec sp_configure "current audit table", 0, "with truncate"
/*
** Copy the audit records from the audit table
** that became full into another table.
*/
if @audit_table_number = 1
begin
insert archive_db..audit_archive
select * from sysaudits_01
truncate table sysaudits_01
end
else if @audit_table_number = 2
begin
insert archive_db..audit_archive
select * from sysaudits_02
truncate table sysaudits_02
end
return(0)
go

exec sp_addthreshold sybsecurity, aud_seg_01, 1024, audit_thresh
exec sp_addthreshold sybsecurity, aud_seg_02, 1024, audit_thresh
go


--If you do not want archive database, just truncate the audit tables, do not create the archive_db, follow the following:

use sybsecurity
go

create proc thresh_seg2 as
declare @current_audit_table int
print "This is to inform you that the sysaudits_02 was filled.
The current audit table is sysaudits_01. You should tell the
auditors to archive sysaudits_02 as soon as possible."
select @current_audit_table = value from master.dbo.sysconfigures
where name = "current audit table"
if @current_audit_table=2
truncate table sysaudits_01
exec sp_configure "current audit table",1
return(0)



create proc thresh_seg1 as
declare @current_audit_table int
print "This is to inform you that the sysaudits_01 was filled.
The current audit table is sysaudits_02 You should tell the
auditors to archive sysaudits_01 as soon as possible."
select @current_audit_table = value from master.dbo.sysconfigures
where name = "current audit table"
if @current_audit_table=1
truncate table sysaudits_02
exec sp_configure "current audit table",2
return(0)


sp_addthreshold sybsecurity,aud_seg_01,1024,thresh_seg1
sp_addthreshold sybsecurity,aud_seg_02,1024,thresh_seg2
go


--So as a conclusion, if you do not archive the audit information, we have 2 thresholds:

sp_addthreshold sybsecurity, aud_seg_01, 1024, thresh_seg1
go
sp_addthreshold sybsecurity, aud_seg_02, 1024, thresh_seg2
go

--If we have archive database we have one threshold:

sp_addthreshold sybsecurity, aud_seg_02, 1024, audit_thresh
go

/* Enable for each login to be audited for table access */
sp_audit table_access, "userlogins", "all", "on"  
go

--sp_audit determines what will be audited when auditing is enabled. No actual auditing takes place until you use sp_configure to set the auditing parameter to on. Then, all auditing options that have been configured with sp_audit take effect. For more information, see sp_configure.


/* Configure auditing at the database level for all users for drop, grant, revoke, dbaccess and truncate
*/
use sybsecurity
go
sp_audit "drop", "all", "kplus", "on"  --kplus is the name of the database
go
sp_audit "grant", "all", "kplus", "on"
go
sp_audit "revoke", "all", "kplus", "on"
go
sp_audit "dbaccess", "all", "kplus", "on"
go
sp_audit "truncate", "all", "kplus", "on"
go

/* Configure auditing at the server level for sa, sso and oper roles, and login, logouts,
** errors and rpcs
*/
sp_audit "all", sa_role, "all", "on"  
go
sp_audit "all", sso_role, "all", "on"  
go
sp_audit "all", oper_role, "all", "on" 
go 
sp_audit "login", "all", "all", "on"
go
sp_audit "logout", "all", "all", "on"
go
sp_audit "errors", "all", "all", "on"
go
sp_audit "rpc", "all", "all", "on"
go

--to display the auditing setting:
use sybsecurity
go
sp_displayaudit
go
