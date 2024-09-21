
[Exploring your database schema with SQL - Simple Talk](https://www.red-gate.com/simple-talk/databases/sql-server/t-sql-programming-sql-server/exploring-your-database-schema-with-sql/)

```sql
--find the actual code for a particular stored procedure, view, function etc.
SELECT OBJECT_NAME(object_ID), definition
  FROM sys.SQL_Modules
  WHERE OBJECT_NAME(object_ID) = 'MyObjectName';


```


## Constraints
Constraint can be used to specify the limit on the data type of table. Constraint can be specified while creating or altering the table statement. 

```sql
NOT NULL
CHECK
DEFAULT
UNIQUE
PRIMARY KEY
FOREIGN KEY
```

## Functions

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
- Date and Time Data Types and Functions ([docs](https://learn.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver16))
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
- Text and Image Functions ([docs](https://learn.microsoft.com/en-us/sql/t-sql/functions/text-and-image-functions-textptr-transact-sql?view=sql-server-ver16))
- Trigger Functions

## Scripting

[Parsing HTML in SQL Server](https://bertwagner.com/posts/parsing-html-sql-server/)

[Find value inside tables of all databases](https://stackoverflow.com/questions/436351/find-a-value-anywhere-in-a-database)
