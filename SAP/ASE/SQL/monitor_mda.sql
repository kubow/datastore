--approximate percentage of CPU Idle / CPU busy
select sum(IdleTicks)*100/sum(TotalTicks) as "%_CPU_IDLE", sum(BusyTicks)*100/sum(TotalTicks) as "%_CPU_BUSY" from monThread
--list of tables with highest number of I/O operations
select DBName, ObjectName, IndexID,LogicalReads, PhysicalReads,PhysicalWrites, RowsInserted, RowsUpdated, RowsDeleted, LockRequests, LockWaits,UsedCount
from monOpenObjectActivity order by LogicalReads desc
--most frequently accessed tables with tablescan
select DBName, ObjectName, IndexID,LogicalReads, PhysicalReads,PhysicalWrites, RowsInserted, RowsUpdated, RowsDeleted, LockRequests, LockWaits,UsedCount
from monOpenObjectActivity
where IndexID=0 order by UsedCount desc
--list of users who consume the most CPU resources
select SPID, suser_name(ServerUserID), CPUTime, LogicalReads, PhysicalReads, PhysicalWrites, MemUsageKB, Transactions
from monProcessActivity order by CPUTime desc
--list of users who consume the most I/O resources
select SPID, suser_name(ServerUserID), CPUTime, LogicalReads, PhysicalReads, PhysicalWrites, MemUsageKB, Transactions
from monProcessActivity order by LogicalReads desc
--list of objects that utilize the most of the cache
select DBName, ObjectName, CacheName, ObjectType, TotalSizeKB
from monCachedObject order by TotalSizeKB desc
--which queries are consuming the most CPU
select s.SPID, s.CpuTime, t.LineNumber, t.SQLText
from master..monProcessStatement s, master..monProcessSQLText t
where s.SPID = t.SPID
order by s.CpuTime DESC
--hottest tables used:
select * into #t
from master..monOpenObjectActivity
go

select top 100 TableName = object_name(ObjectID, DBID), IndexID,
LogicalReads, PhysicalReads, Operations, LockWaits
from #t
order by 3 desc
go
--monitoring table scans
select "Database" = db_name(DBID), "Table" = object_name(ObjectID, DBID),
   IndID = IndexID, UsedCount, LastUsedDate
from mon_db..monOpenObjectActivity
Where IndexID=0 and UsedCount >0
and timestamp between startdate and enddate
go
--identify hot tables
select TableName = object_name(ObjectID, DBID), IndexID, LogicalReads, PhysicalReads, Operations, LockWaits
from mon_db..monOpenObjectActivity
and timestamp between startdate and enddate
order by 1, 2
go

--hit ratios for the data cache for the life of ASE
select "Procedure Cache Hit Ratio" = (Requests-Loads)*100/Requests
from master..monProcedureCache
--detailed hit ratio
select * into #moncache_prev
from master..monDataCache
waitfor delay "00:10:00"
select * into #moncache_cur
from master..monDataCache
select p.CacheName,
"Hit Ratio"=(c.LogicalReads-p.LogicalReads)*100 / (c.CacheSearches -
p.CacheSearches)
from #moncache_prev p, #moncache_cur c
where p.CacheName = c.CacheName
