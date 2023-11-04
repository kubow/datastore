
## Maintain

Main administration
```shell
sudo systemctl restart postgresql  # restart postgresql service

```


Inside database
```psql
\d - list databases
\c db_name - connect to a database
```


[Creating a copy of a database in PostgreSQL - Stack Overflow](https://stackoverflow.com/questions/876522/creating-a-copy-of-a-database-in-postgresql)
[List all databases and tables using psql? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/1285/how-do-i-list-all-databases-and-tables-using-psql)


### SQL syntaxes

```sql
-- VIEWS
CREATE OR REPLACE view name AS SELECT ...;

SELECT CAST('10C' AS INTEGER); -- BOOLEAN, DATE, DOUBLE, VARCHAR, ...

```


### Backup / Restore

[How to restore PostgreSQL database from .tar file? - Server Fault](https://serverfault.com/questions/115051/how-to-restore-postgresql-database-from-tar-file)
[What if the Backup Server Is Down and a Backup Is Needed? (Multi-repo Functionality of PgBackRest)](https://www.percona.com/blog/what-if-the-backup-server-is-down-and-a-backup-is-needed-multi-repo-functionality-of-pgbackrest/)
[Full vs. Incremental vs. Differential Backups: Comparing Backup Types](https://www.percona.com/blog/what-are-full-incremental-and-differential-backups/)
[What To Do When a Data File in PostgreSQL Goes Missing](https://www.percona.com/blog/what-to-do-when-a-data-file-in-postgresql-goes-missing/)

Exporting [http://www.pgadmin.org/docs/1.18/export.html](http://www.pgadmin.org/docs/1.18/export.html)  
  
[Export a CREATE script for a database - Stack Overflow](https://stackoverflow.com/questions/6024108/export-a-create-script-for-a-database)

### Misc

Remove extended characters in string [http://stackoverflow.com/questions/15259622/how-do-i-remove-extended-ascii-characters-from-a-string-in-t-sql](http://stackoverflow.com/questions/15259622/how-do-i-remove-extended-ascii-characters-from-a-string-in-t-sql)  
Replace string in field [http://stackoverflow.com/questions/5060526/postgresql-replace-all-instances-of-a-string-within-text-field](http://stackoverflow.com/questions/5060526/postgresql-replace-all-instances-of-a-string-within-text-field)  
Replace ASCII to UTF8 [http://www.laudatio.com/wordpress/2008/11/05/postgresql-83-to_ascii-utf8/](http://www.laudatio.com/wordpress/2008/11/05/postgresql-83-to_ascii-utf8/)  
  
Postgres to sqlite convert [https://stackoverflow.com/questions/6148421/how-to-convert-a-postgres-database-to-sqlite](https://stackoverflow.com/questions/6148421/how-to-convert-a-postgres-database-to-sqlite)  
  
PostgreSQL, MonetDB, and Too-Big-for-Memory Data in R -- Part II [http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:733154](http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:733154)


[Find the WAL Count Between Two Segments in PostgreSQL](https://www.percona.com/blog/find-the-wal-count-between-two-segments-in-postgresql/)