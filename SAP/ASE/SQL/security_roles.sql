sp_helprotect
sp_helpgroup

select show_role()

alter login StatistikaRead add auto activated roles Statistika_reader

select * from master..syslogins

-- permissions for groups
select    o.name as "Object name"
,         u.name as "User/group name"
,         case when p.action = 193 then "select"
               when p.action = 195 then "insert"
               when p.action = 196 then "delete"
               when p.action = 197 then "update"
               when p.action = 224 then "execute"
               else "other"
          end as "Permission"
from      sysobjects o
,         sysprotects p
,         sysusers u
where     o.id = p.id
and       p.uid = u.uid
order by  o.name, u.name, p.action

--display roles
select t1.name "user", t3.name "role"
 from syslogins t1, sysloginroles t2, syssrvroles t3
 where t2.suid = t1.suid and 
 t3.srid = t2.srid
 order by 1,2
 go

--display all granted objects
select u.name,v.name
 from sysprotects p, master.dbo.spt_values v, sysusers u
 where p.uid=u.uid
 --and p.actionfiltered=v.number
 and p.protecttype=1
 and v.type = 'T'
 and u.name!= 'dbo'
 go
