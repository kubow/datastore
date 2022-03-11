--#1-      Run dbcc on the databases:
dbcc traceon(3604)
go
 
use master
go
-- checkalloc
select "dbcc checkalloc(master)"
go
dbcc checkalloc(master)
go
 
select "dbcc checkalloc(model)"
go
dbcc checkalloc(model)
go
 
select "dbcc checkalloc(sybsystemprocs)"
go
dbcc checkalloc(sybsystemprocs)
go
 
select "dbcc checkalloc(sybsystemdb)"
go
dbcc checkalloc(sybsystemdb)
go

use master
go
-- chceck catalog
select "dbcc checkcatalog(master)"
go
dbcc checkcatalog(master)
go
 
select "dbcc checkcatalog(model)"
go
dbcc checkcatalog(model)
go
 
select "dbcc checkcatalog(sybsystemprocs)"
go
dbcc checkcatalog(sybsystemprocs)
go
 
select "dbcc checkcatalog(sybsystemdb)"
go
dbcc checkcatalog(sybsystemdb)
go
dbcc traceon(3604)
go
 
-- check database
use master
go
select "dbcc checkdb(master)"
go
dbcc checkdb(master)
go
 
select "dbcc checkdb(model)"
go
dbcc checkdb(model)
go
--#2 - run install product
-- watchout for replication server, needs to be shut down
--#3- after ASE server start
dbcc traceon(3604)
go
DBCC REBUILD_TEXT(45)
go
DBCC UPGRADE_OBJECT(sybsystemprocs, sp_do_poolconfig)
go
DBCC UPGRADE_OBJECT(sybsystemprocs, sp_aux_getsize)
go
--do it for all databases:
dbcc traceon(3604)
go
dbcc upgrade_object(master)
go
dbcc upgrade_object(sybsystemprocs)
go
dbcc upgrade_object(sybsystemdb)
go
dbcc upgrade_object(model)
go