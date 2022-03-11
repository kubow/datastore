sp_configure "enable monitoring", 1
sp_configure "wait event timing", 1
sp_configure "max SQL text monitored", 2048
sp_configure "SQL batch capture", 1

sp_sysmon "00:05:00"
--analyze sysmon outputs

sp_help

select * into #sqltext from master..monProcessSQLText
select * into #sqltext from master..monSysSQLText
select * into #sqltext from master..monSysStatement

select * from #sqltext
drop table #sqltext
--not having monitor role assigned, cannot proceed

select * from sysquerymetrics
select * from sysqueryplans
select * from sysusers

sp_configure "enable metrics capture", 1

set metrics_capture on

sp_metrics 'flush'
--proceed with sp_metrics
--sp_metrics 'backup', '6'
select * from sysquerymetrics

select moddate from sysstatistics order by moddate

--if more records, need to proceed with bcp

set metrics_capture off

sp_configure "enable metrics capture", 0, 'default'
sp_configure "wait event timing", 0, 'default'
sp_configure "enable monitoring", 0, 'default'

--truncating querymetrics with batches
declare @i int
select @i = 0
set rowcount 5000
while (@i < 100)
  begin
    delete from sysqueryplans
    while (@@rowcount = 5000)
      begin
        checkpoint
        delete from sysqueryplans
      end
    select @i = @i + 1
    waitfor delay "00:00:35"
  end
set rowcount 0


  ----
use tempdb
go

create proc p1 as 
select * from master..monProcessSQLText where SPID=@@spid order by LineNumber
go
create proc p2 as
exec p1
go


drop proc p2
go
drop proc p1
go
