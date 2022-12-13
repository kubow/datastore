## Maintenance

Performance troubleshooting [https://www.sqlshack.com/dba-guide-sql-server-performance-troubleshooting-part-2-monitoring-utilities/](https://www.sqlshack.com/dba-guide-sql-server-performance-troubleshooting-part-2-monitoring-utilities/)
[Tips and tricks for SQL Server database maintenance optimization (sqlshack.com)](https://www.sqlshack.com/tips-and-tricks-for-sql-server-database-maintenance-optimization/)

• Index reorganization  
• Index rebuilding  
• Updating statistics  
• Integrity and consistency checks  
• Repair and cleanup tasks  

[SQL Server and Azure SQL index architecture and design guide - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver15)

### Index Reorganization

It’s important to keep your indexes defragmented. You can run an index reorganize operation, which enables you to defragment your indexes with minimal system resources. Index reorganization is best for indexes with fragmentation below 20 to 30% or if you plan on doing an index statistics update in the future—because index reorganization only reorganizes the leaf-level index pages, it’s not efficient when you have a large fragmentation. Index statistics are also not updated during index reorganization.  
This operation is always online, uses minimal system resources, honors the fill factor that has been used during the creation of the index (common misconception is that reorganize operation does not take into account fill factor at all) and if you kill it due to any reason, the work that has been done would still persist.  
  
• Index statistics are not being updated  
• Not efficient when you have a large fragmentation as it is only reorganizing the leaf-level pages  
• Cannot change the initial fill factor used during index

```SQL
USE database_name  
SELECT a.index_id, name, avg_fragmentation_in_percent,   
  a.page_count, a.record_count, a.index_type_desc, a.avg_page_space_used_in_percent,  
  STATS_DATE(b.object_id,b.index_id) as stats_updated   
FROM sys.dm_db_index_physical_stats   
  (DB_ID(N'database_name'), OBJECT_ID(N'dbo.IndexTable'), 1, NULL, 'DETAILED') AS a  
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id  
-- index reorganize operation  
USE database_name  
ALTER INDEX IndexTable_CL ON dbo.IndexTable REORGANIZE
```

### Index Rebuilding
  
When fragmentation is high, you should use the index rebuild approach. Index rebuilding can happen online or offline. The online index rebuild process consists of a preparation phase, build phase, and final declaration phase. When rebuilding an index offline, clustered and nonclustered indexes alike can’t be accessed.    

```SQL
-- statististics not updated yet  
USE IndexMaintenance  
ALTER INDEX IndexTable_CL ON dbo.IndexTable REBUILD
```


### Updating Statistics

Gathering statistics is important and can help you develop strong query execution plans. There are two key kinds of statistics: index statistics, which are always generated with the creation of a new index, and column statistics. Column statistics are built by SQL Server and can give you insight into data distribution so you can determine the best way to execute a specific query. It’s critical to include a task in your database maintenance plan making sure the most up-to-date SQL database statistics are in use.  
  
### Integrity and Consistency Checks

It’s important to ensure the integrity and consistency of your SQL Server. Usually, checks are scheduled by default without any additional tweaks. To make the most of consistency and database integrity checks, however, you should customize them to fit your organization’s individual needs and characteristics.  
  
### Repair and Cleanup
  
The maintenance process also includes other repair and cleanup tasks, like backing up database and transaction logs. You could even shrink log files and other data by removing empty pages, which can help you save space. It’s important to set up a plan to ensure all these tasks are performed completely and accurately.  
  
SQL Server has a built-in tool known as the Maintenance Plan Wizard, which enables you to create and execute scheduled maintenance tasks. However, the Maintenance Plan Wizard is limited—it merely lets you schedule jobs, not enforce their success or optimize them. To continuously improve SQL Server database maintenance and ensure operations are run in the most efficient way, turn to an automated tool.
