/* Procedure copyright(c) 1995 by Edward M Barlow */
/*  Stored Procedure is under GPL v2 */

/******************************************************************************
**
** Name        : sp__helpprotect.sql
**
******************************************************************************/
if exists (select * from sysobjects
           where  name = "sp__helprotect"
           and    type = "P")
begin
   drop proc sp__helprotect
end
go

create procedure sp__helprotect
        @parameter varchar(30) = NULL            /* name of object or user to check     */,
        @do_system_tables char(1) = null, /* if not null will include system tbls */
        @dont_format char(1) = null,
        @groups_only char(1) = null
as
--------------------------------------------------------------------------------------------------
-- Vers|   Date   |      Who           | DA | Description
-------+----------+--------------------+----+-----------------------------------------------------
-- 1.1 |11/18/2013|  Jason Froebe      |    | Updated for ASE v15
-- 1.0 |          |  Edward M Barlow   |    | Stored procedure extracting permissions for objects
-------+----------+--------------------+----+-----------------------------------------------------

        declare @type char(2), @uid int, @msg varchar(255), @objid int

        if @parameter is NULL
                select @objid=null
        else
                select @objid = object_id(@parameter)

        /* define our table */
        select   id,uid,action,protecttype,columns,grantor,
                        column_name             = "                               "
                        ,action_text            = "                               "
                        ,protecttype_text = "                               "
                        ,ending                                 = "                               "
        into    #protects
        from    sysprotects
        where 1=2

        /* Either a passed object or all objects */
        if @objid is not null or @parameter is null
        begin

                select uid,gid into #groups from sysusers

                if @groups_only is not null
                        delete  #groups
                        where    uid != gid

                /* IT IS AN OBJECT */
                insert  #protects
                select  id,p.uid,action,protecttype,columns,grantor,"","","",""
                from    sysprotects p, #groups g
                where   id=isnull(@objid,id)
                and      p.uid = g.uid

                /* REVOKES ON COLUMNS */
                insert  #protects
                select  id,p.uid,action,2,columns,grantor,
                        "("+col_name(p.id,c.number)+")","","",""
                from            sysprotects p, master.dbo.spt_values c, #groups g
                where   p.columns is not null
                and             convert(tinyint,substring(p.columns,c.low,1)) & c.high=0
                and             c.type = "P"
                and             c.number < = 255
                and             c.number>0
                and             c.low>1
                and             col_name(p.id,c.number) is not null
                and             id=isnull(@objid,id)
                and      p.uid=g.uid

                if @do_system_tables is null and @objid is null
                        delete #protects
                        from   #protects p, sysobjects o
                        where  p.id = o.id
                        and    o.type = 'S'
        end
        else
        begin

                /* IS IT A USER */
                select @uid = uid from sysusers where name=@parameter
                if @@rowcount = 0 or @uid is null
                begin
                   print "No User Or Object Found"
                   return (1)
                end

                insert  #protects
                select  distinct id,uid,action,protecttype,columns,grantor,"","","",""
                from    sysprotects p
                where   uid=@uid
                /* and          isnull( p.columns,0x01 ) = 0x01 */

                /* REVOKES ON COLUMNS */
                insert  #protects
                select  id,uid,action,2,columns,grantor,
                        "("+col_name(p.id,c.number)+")", "","",""
                from    sysprotects p, master.dbo.spt_values c
                where isnull( p.columns,0x01 ) != 0x01
                and     convert(tinyint, substring(p.columns, c.low, 1)) & c.high = 0
                and     c.type = "P"
                and     c.number < = 255
                and     c.number>0
                and     c.low>1
                and     col_name(p.id,c.number) is not null
                and     uid=@uid

                if @do_system_tables is null
                        delete #protects
                        from   #protects p, sysobjects o
                        where  p.id = o.id
                        and    o.type = 'S'
        end

/* References etc */
delete  #protects
where   action in(151,207,222,233,236)

update  #protects
set     action_text = name
from    master.dbo.spt_values v
where   v.type='T'
and     v.number = #protects.action

update  #protects
set     protecttype_text = name
from    master.dbo.spt_values v
where   v.type='T'
and     v.number = #protects.protecttype +204

-- protecttype column can contain these values: 0 for grant with grant. 1 for grant. 2 for revoke
update  #protects
set     protecttype_text =
   case
     when protecttype = 0
       then "GRANT"
     when protecttype = 1
       then "GRANT"
     when protecttype = 2
       then "REVOKE"
   end

update  #protects
set     ending = " WITH GRANT OPTION"
where   protecttype = 0

declare @max_len int
select @max_len = max(char_length( rtrim(protecttype_text)+" "+rtrim(action_text)+" on "+rtrim(object_name(id))+column_name+" to "+rtrim(user_name(uid))+ending))
from #protects

if @max_len < 60
        select
         substring(
           rtrim(protecttype_text)
           + " "
           + rtrim(action_text)
           + case when id = 0 then " " else " on " end
           + rtrim(object_name(id))
           + column_name
           + " to "
           + rtrim(user_name(uid))
           + ending
         ,1,59)
        from #protects
        where rtrim(action_text) != ""
        order by object_name(id),protecttype_text
else if @max_len < 80
        select
         substring(
           rtrim(protecttype_text)
           + " "
           + rtrim(action_text)
           + case when id = 0 then " " else " on " end
           + rtrim(object_name(id))
           + column_name
           + " to "
           + rtrim(user_name(uid))
           + ending
         ,1,79)
        from #protects
        where rtrim(action_text) != ""
        order by object_name(id),protecttype_text
else if @max_len < 132
        select
         substring(
           rtrim(protecttype_text)
           + " "
           + rtrim(action_text)
           + case when id = 0 then " " else " on " end
           + rtrim(object_name(id))
           + column_name
           + " to "
           + rtrim(user_name(uid))
           + ending
         ,1,131)
        from #protects
        where rtrim(action_text) != ""
        order by object_name(id),protecttype_text


return (0)
go
grant execute on sp__helprotect to public
go