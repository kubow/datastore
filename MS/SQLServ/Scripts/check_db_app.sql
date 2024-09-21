--get information on blocking
SELECT *
FROM
    sys.dm_exec_requests
CROSS APPLY
    sys.dm_exec_sql_text(sql_handle)

--statistics updated?
EXEC sp_updatestats
GO

DBCC FREEPROCCACHE()
GO

-- performance counters
select *
from sys.dm_os_performance_counters
where
    counter_name in ('Batch Requests/sec', 'SQL Compilations/sec' , 'SQL Re-Compilations/sec')

--collect samples win 10 sec delay
DECLARE @BatchRequests BIGINT;

SELECT
    @BatchRequests = cntr_value
FROM
    sys.dm_os_performance_counters
WHERE
    counter_name = 'Batch Requests/sec';

WAITFOR DELAY '00:00:10';

SELECT
    (cntr_value - @BatchRequests) / 10 AS 'Batch Requests/sec'
    FROM sys.dm_os_performance_counters
WHERE
    counter_name = 'Batch Requests/sec';
