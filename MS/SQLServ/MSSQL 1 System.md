## System

These parts are crucial:  
- SQL Server Database Engine  
- SQL Server Agent  
- SQL Server Browser

SQL Server Report Services

## Server
 
[SERVERPROPERTY (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/t-sql/functions/serverproperty-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  

## SQL Server instance
  
[Server Configuration Options (SQL Server) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?redirectedfrom=MSDN&view=sql-server-ver15)  
  
[How to Document and Configure SQL Server Instance Settings - Simple Talk (red-gate.com)](https://www.red-gate.com/simple-talk/databases/sql-server/database-administration-sql-server/how-to-document-and-configure-sql-server-instance-settings/?utm_source=simpletalk&utm_medium=weblink&utm_content=Eightsteps_tdavis&utm_campaign=sqlmonitor)  

## Database
  
[sys.database_files (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  
[sys.databases (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  
[sys.sysfiles (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysfiles-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  
  
[Database Properties Health Check - Simple Talk (red-gate.com)](https://www.red-gate.com/simple-talk/databases/sql-server/database-administration-sql-server/database-properties-health-check/?utm_source=simpletalk&utm_medium=weblink&utm_content=Eightsteps_tdavis&utm_campaign=sqlmonitor)  
  
## Security

[Security Catalog Views (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/security-catalog-views-transact-sql?view=sql-server-ver15)  
selected  
[sys.database_principals (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-principals-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  
[sys.database_role_members (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-role-members-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)  
[sys.database_permissions (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-permissions-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15)

### Constraints
Constraint can be used to specify the limit on the data type of table. Constraint can be specified while creating or altering the table statement. 

```sql
NOT NULL
CHECK
DEFAULT
UNIQUE
PRIMARY KEY
FOREIGN KEY
```

### Functions

- Aggregate Functions ([docs](https://learn.microsoft.com/en-us/sql/t-sql/functions/aggregate-functions-transact-sql)), use as expressions only in following situations:
	1. The select list of a SELECT statement (either a subquery or an outer query).
	2. A HAVING clause.
- Analytic Functions
- Collation Functions
- Configuration Functions
- Conversion Functions
- Cryptographic Functions
- Cursor Functions
- Data Type Functions
- Date and Time Data Types and Functions
	- [Get week day name from a given month, day and year individually in SQL Server - Stack Overflow](https://stackoverflow.com/questions/20106871/get-week-day-name-from-a-given-month-day-and-year-individually-in-sql-server#20106955)
	- [SQL Stuff: T-SQL: Get Last Day of Month](https://richbrownesq-sqlserver.blogspot.com/2012/02/t-sql-get-last-day-of-month.html)
- JSON Functions
- Logical Functions
- Mathematical Functions
- Metadata Functions
- ODBC Scalar Functions
- Ranking Functions
- Replication Functions
- Rowset Functions
- Security Functions
- String Functions ([docs](https://learn.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN))
	- [T-SQL: RIGHT, LEFT, SUBSTRING and CHARINDEX Functions | Microsoft Learn](https://learn.microsoft.com/en-us/archive/technet-wiki/17948.t-sql-right-left-substring-and-charindex-functions)
- System Functions
- System Statistical Functions
- Text and Image Functions ()
- Trigger Functions