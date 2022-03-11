create procedure sp__tspaceused
as

declare @dbid  smallint,
        @psize int,
        @slog_res_pgs numeric(20,9),
        @slog_dpgs    numeric(20,9),
        @slog_unused  numeric(20,9)

select @dbid = db_id()
select @psize = low / 1024
   from master..spt_values
   where number = 1 and type = 'E'

select database_name = db_name(), "db size (MB)" = sum(size) * @psize / 1024
   from master..sysusages
   where dbid = @dbid

select distinct name,
       res_pgs = convert(numeric(20,9), reserved_pages(db_id(),id, indid)),
       dpgs    = convert(numeric(20,9), data_pages(db_id(), id, indid)),
       ipgs    = convert(numeric(20,9), data_pages(db_id(), id, indid)),
       unused  = convert(numeric(20,9), reserved_pages(db_id(),id, indid)-data_pages(db_id(), id, indid))
   into #pgcounts
   from sysindexes
   where id != 8

select distinct
       "reserved KB" = convert(numeric(11,0), (sum(res_pgs) + @slog_res_pgs) * @psize),
       "data KB"     = convert(numeric(11,0), (sum(dpgs)    + @slog_dpgs)    *
 @psize),
       "ind KB"      = convert(numeric(11,0),  sum(ipgs)                     * @psize),
       "unused KB"   = convert(numeric(11,0), (sum(unused)  + @slog_unused)  * @psize)
   from #pgcounts

select distinct substring(o.name,1,30),
       rowtot = convert(numeric(11,0), row_count(db_id(), o.id)),
       totKb  = convert(numeric(11,0), sum(reserved_pages(db_id(),i.id))),
       o.crdate
   from sysobjects o, sysindexes i
   where i.id = o.id and o.type in ('U')
   group by o.name
   order by 4


 return 0
