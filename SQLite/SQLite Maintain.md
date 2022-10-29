 
[SQLite Tutorial - An Easy Way to Master SQLite Fast](https://www.sqlitetutorial.net/)

[Pragma statements supported by SQLite](https://www.sqlite.org/pragma.html#pragma_integrity_check)

Columns/keys
[SQLite Primary Key: The Ultimate Guide To Primary Key (sqlitetutorial.net)](https://www.sqlitetutorial.net/sqlite-primary-key/)

[How do I rename a column in a SQLite database table? - Stack Overflow](https://stackoverflow.com/questions/805363/how-do-i-rename-a-column-in-a-sqlite-database-table#805508)
[sql - SQLite issue with Table Names using numbers? - Stack Overflow](https://stackoverflow.com/questions/4007780/sqlite-issue-with-table-names-using-numbers#4007798)

DML
[sql - Cross-table UPDATE in SQLITE3 - Stack Overflow](https://stackoverflow.com/questions/329197/cross-table-update-in-sqlite3)

Index 
[The SQLite Query Optimizer Overview](https://sqlite.org/optoverview.html#autoindex)
[SQLite Primary Key: The Ultimate Guide To Primary Key (sqlitetutorial.net)](https://www.sqlitetutorial.net/sqlite-primary-key/)

CLI
[Command Line Shell For SQLite](https://www.sqlite.org/cli.html)


Query plan
[EXPLAIN QUERY PLAN (sqlite.org)](https://www.sqlite.org/eqp.html)


```sql
.database  
.tables  
  
--Attach another database
ATTACH DATABASE file_name AS database_name;
--copy whole table as new  
CREATE TABLE NewTable AS SELECT * FROM OldTable WHERE 0;  
--copy just data structure  
create table NewTable as select * from OldTable where 1 <> 1

-- Capitalize First letter  
SELECT Czech, UPPER(SUBSTR(Czech,1,1)) || LOWER(SUBSTR(Czech,2,LENGTH(Czech))) AS Rest FROM seznam   
--update query - capitalize  
UPDATE seznam SET Czech=UPPER(LEFT(Czech,1))+LOWER(SUBSTRING(Czech,2,LEN(Czech)))  
UPDATE seznam SET Czech=UPPER(SUBSTR(Czech,1,1)) || LOWER(SUBSTR(Czech,2,LENGTH(Czech)))  
  
--replace part of string  
UPDATE table SET field = replace( field, 'find_string', 'replace_string' )

-- Conditionals
CASE WHEN key='value1' THEN 'something' WHEN key='value2' THEN 'somethingelse'
--Single quote
cast(X'27' as text)
--Double quote
cast(X'22' as text)
```

### Backup/Restore
[sql - How do I dump the data of some SQLite3 tables? - Stack Overflow](https://stackoverflow.com/questions/75675/how-do-i-dump-the-data-of-some-sqlite3-tables)

```batch
sqlite3.exe .\file.db ".dump" > DDL.sql
```

## Security

[SQLite3 Injection Cheat Sheet - ~/haxing (cked.me)](http://atta.cked.me/home/sqlite3injectioncheatsheet)
