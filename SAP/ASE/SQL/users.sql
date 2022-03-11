select * from master..syslogins
select * from master..syssrvroles
-- users are database specific
select * from sysusers

-- select users with sa_role
select sr.name 'role', sl.name 'username'
from master..syssrvroles sr, master..syslogins sl, master..sysloginroles slr
where sl.suid = slr.suid and sr.srid = slr.srid and sr.name like "sa_role"

-- select users and their roles
select sl.name, sr.name
from syslogins sl, master..sysloginroles slr, master..syssrvroles sr
where slr.suid = sl.suid and
sr.srid = slr.srid
order by 1,2

-- select roles that are being used
sp_displayroles
------------------------------------------------

-- add new login
sp_addlogin user_name, password, default_db
-- add new role
create role role_name
-- grant role to login
sp_role "grant", role_name, user_name
-- display statistics about login
sp_displaylogin user_name

-- list restrictions over login
sp_helprotect user_name

------------ revoking password policy
sp_configure "minimum password length", 4
create login joe with password abcd1234 min password length 8
sp_displaylogin joe
sp_password NULL, aaa, joe  -- spadne chce 8
alter login joe drop min password length
sp_password NULL, aaa, joe  -- spadne chce 4
sp_configure "minimum password length", 0
sp_password NULL, aaa, joe  -- nespadne

