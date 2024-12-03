[Database | Oracle](https://www.oracle.com/database/)

[ORACLE-BASE - Oracle DBA and development articles, scripts, HOWTOs and forums (8i, 9i, 10g, 11g, 12c, 13c, 18c, 19c, 21c, 23ai)](https://oracle-base.com/)

### Referrences

- [Viktor T. Toth - Oracle Cheat Sheet](https://www.vttoth.com/CMS/technical-notes/?view=article&id=81)
- [Oracle Database/SQL Cheatsheet - Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Oracle_Database/SQL_Cheatsheet)
- [Oracle SQL reference](http://www.cheat-sheets.org/saved-copy/oracle_sql_reference.pdf)
- [Oracle Editions Cheatsheet](https://www.red-database-security.com/wp/oracle_cheat.pdf)

### DBA Guides

- [Oracle by Example Series: 2 Day DBA 11g](https://www.oracle.com/webfolder/technetwork/tutorials/obe/db/11g/r2/2day_dba/index.html)
- [The Ultimate DBA Guide to Getting Current with Oracle Database](https://blogs.oracle.com/oracleuniversity/post/the-ultimate-dba-guide-to-getting-current-with-oracle-database)
- [Oracle Database Database Administrator’s Guide, 23ai](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/index.html)

## Architecture

[Oracle / PLSQL: Data Types](https://www.techonthenet.com/oracle/datatypes.php#)

[Database Limits](https://docs.oracle.com/en/database/oracle/oracle-database/23/refrn/database-limits.html) (Data field types support)

Best practices for implementing data warehouse in Oracle 12c [http://www.oracle.com/technetwork/database/bi-datawarehousing/twp-dw-best-practices-for-implem-192694.pdf](http://www.oracle.com/technetwork/database/bi-datawarehousing/twp-dw-best-practices-for-implem-192694.pdf)

[Oracle brings the Autonomous Database to JSON | ZDNET](https://www.zdnet.com/article/oracle-brings-the-autonomous-database-to-json/#ftag=RSSbaffb68)
## Install

[Oracle SQL Developer Release 19.2 - Get Started](https://docs.oracle.com/en/database/oracle/sql-developer/19.2/)
## Maintenance

[Oracle Warehouse Management User's Guide](https://docs.oracle.com/cd/E18727_01/doc.121/e13433/T211976T321834.htm)

[sql - How to Select Top 100 rows in Oracle? - Stack Overflow](https://stackoverflow.com/questions/27034585/how-to-select-top-100-rows-in-oracle#27034932)
[Databases and Performance: Top Oracle Monitoring Views & Tables](https://databaseperformance.blogspot.com/2018/04/top-oracle-monitoring-views-tables.html)
[Granting Rights on Stored Procedure to another user of Oracle - Stack Overflow](https://stackoverflow.com/questions/4305323/granting-rights-on-stored-procedure-to-another-user-of-oracle#4305531)
[Databases and Performance: Interactive Complex SQL Scripts - A Solution](https://databaseperformance.blogspot.com/2018/06/interactive-complex-sql-scripts-solution.html)
[Oracle Database: How-To: Create a New database using DBCA - YouTube](https://www.youtube.com/watch?v=nqelGH_XU18)
### Importing
- [oracle database - How to load an inconsistent CSV file using sql loader? - Stack Overflow](https://stackoverflow.com/questions/54176682/how-to-load-an-inconsistent-csv-file-using-sql-loader)
- [RMAN restore fails with RMAN-06023 but there are backups available ~ Marko Sutic's Database Blog](https://msutic.blogspot.com/2010/11/rman-restore-fails-with-rman-06023-but.html)
- [How to Restore Oracle Database using RMAN (with Examples)](https://www.thegeekstuff.com/2014/11/oracle-rman-restore/)

```sql
RMAN> SET DBID 12345;  
RMAN> STARTUP NOMOUNT;  
  
RMAN> RESTORE CONTROLFILE FROM "/backup/rman/ctl_c-12345-20141003-03";   
RMAN> ALTER DATABASE MOUNT;  
  
RMAN> RESTORE DATABASE;  
RMAN> RECOVER DATABASE;  
RMAN> ALTER DATABASE OPEN RESETLOGS;

--- Restoring a database
set NLS_LANG=AMERICAN_AMERICA.EE8MSWIN1250  
imp file=ES_20130429_093744.dmp fromuser=aplpop touser=aplpopvl log=imp_in.log  
pause

```
### Audit
[Book Review: Security, Audit and Control Features: Oracle Database](https://www.isaca.org/resources/isaca-journal/issues/2017/volume-6/security-audit-and-control-features-oracle-database)
[Auditing Oracle Database](https://www.isaca.org/resources/isaca-journal/past-issues/2014/auditing-oracle-database)

### Index
[Oracle Bitmap Index | Guide to Oracle Bitmap Index | Query Examples](https://www.educba.com/oracle-bitmap-index/)