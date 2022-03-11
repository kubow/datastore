/* Procedure copyright(c) 1995 by Edward M Barlow */

/******************************************************************************
**
** Name        : sp__indexspace
**
** Created By  : Ed Barlow
**
******************************************************************************/
:r database
go
:r dumpdb
go

IF EXISTS (SELECT * FROM sysobjects
           WHERE  name = "sp__indexspace"
           AND    type = "P")
   DROP PROC sp__indexspace
go

CREATE PROC sp__indexspace(
                @objname        varchar(92) = NULL ,
                                        @dont_format char(1) = null
                                                 )
AS
--------------------------------------------------------------------------------------------------
-- Vers|   Date   |      Who           | DA | Description
-------+----------+--------------------+----+-----------------------------------------------------
-- 1.1 |11/18/2013|  Jason Froebe      |    | Fix Arithmetic overflow error by using a bigint
--     |          |                    |    | instead of integers.  Fix formatting to show entire
--     |          |                    |    | table name + index name
-- 1.0 |          |  Edward M Barlow   |    | Stored procedure giving index usage
-------+----------+--------------------+----+-----------------------------------------------------
BEGIN

declare @pagesize int                   /* Bytes Per Page */
declare @max_name_size varchar(3)
declare @exec_str varchar(2000)

set nocount on

select  @pagesize = low
from    master..spt_values
where   number = 1
and     type = "E"

select name = o.name,
       idxname = i.name,
       owner_id = o.uid,
       row_cnt  = row_count(db_id(), i.id),
       reserved = reserved_pages(db_id(), i.id, i.indid),
       data     = data_pages(db_id(), i.id, i.indid),
       index_size = data_pages(db_id(), i.id, i.indid),
       segname = s.name,
       indid
into   #indexspace
from   sysobjects o, sysindexes i, syssegments s
where  i.id = o.id
and    (o.type = "U" or o.name = "syslogs")
and    s.segment = i.segment
and    isnull(@objname,o.name)=o.name

update #indexspace
set    name=user_name(owner_id)+'.'+name
where  owner_id>1

update #indexspace
set    name=name+'.'+idxname
where  indid!=0

update #indexspace
set    row_cnt=-1
where  row_cnt>99999999

select @max_name_size = convert(varchar(3), max(char_length(name))) from #indexspace
select @max_name_size

print "Data Level (Index Type 0 or 1)"
select @exec_str =
    'select
        convert(char(' + @max_name_size + '),name) "Name",
        convert(char(20),row_cnt) "Rows",
        convert(char(30),rtrim(convert(char(30),(reserved*@pagesize)/1024))+"/"+
        rtrim(convert(char(30),(data*@pagesize)/1024))+"/"+
        rtrim(convert(char(30),(index_size*@pagesize)/1024))) "Used/Data/Idx KB",
        str((row_cnt*1024)/(convert(float,data+index_size)*@pagesize),6,2) "Rows/KB",
        convert(char(12),segname) "Segment"
    from #indexspace
    where indid< =1
    order by name'
exec (@exec_str)

print ""
print "Non Clustered Indexes"
select @exec_str =
    'select
        convert(char(' + @max_name_size + '),name) "Name",
        convert(char(20),row_cnt) "Rows",
        convert(char(30),rtrim(convert(char(30),(reserved*@pagesize)/1024))+"/"+
        rtrim(convert(char(30),(data*@pagesize)/1024))+"/"+
        rtrim(convert(char(30),(index_size*@pagesize)/1024))) "Used/Data/Idx KB",
        str((row_cnt*1024)/(convert(float,data+index_size)*@pagesize),6,2) "Rows/KB",
        convert(char(12),segname) "Segment"
    from #indexspace
    where indid>1
    order by name'
exec (@exec_str)

drop table #indexspace

return(0)

END

go

GRANT EXECUTE ON sp__indexspace TO public
go