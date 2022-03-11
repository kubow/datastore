SELECT @@version

-- database name
use sybmgmtdb
go

-- syslogins + sysalternates
select L.name login_name, L.dbname, U.name user_name, O.type object_type, O.name object_name
from master..syslogins L, sysusers U, sysobjects O 
where L.suid = U.suid and U.uid = O.uid and O.type = 'P' and O.name like '%threshold%'
union
select L.name login_name, L.dbname, U.name user_name, O.type object_type, O.name object_name
from master..syslogins L, sysusers U, sysalternates A, sysobjects O
where L.suid = A.suid and A.altsuid = U.suid and U.uid = O.uid and O.type = 'P' and O.name like '%threshold%'
go

--select * from sysprocedures

--3rd sybsystemprocs + sybmgmtdb
use sybsystemprocs
go
exec sp_stored_procedures '%threshold%'
go

sp_helpdb sybmgmtdb

use sybmgmtdb
go
exec sybmgmtdb..sp_stored_procedures '%threshold%'
go
sp_help sp_thresholdaction
go
sp_helptext sp_thresholdaction

