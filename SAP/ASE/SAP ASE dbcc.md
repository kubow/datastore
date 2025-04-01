https://wiki.scn.sap.com/wiki/display/SYBASE/DBCC+Commands
All results stored in dbccdb database

- Check page linkage for database objects (*dbcc checktable/checkindex/checkdb*)
- Check page allocation for database objects (*dbcc tablealloc/indexalloc/checkalloc/textalloc*)
- Check consistency of an entire database (*dbcc checkstorage*)
	- the only who makes not a lock, writing own tables, very fast, not fixing errors - do not proceed with warm-standby database
- Validate execution results of the most recent dbcc checkstorage run /makes lock (*dbcc checkverify*)
- Check referential integrity problems between system tables in database (*dbcc checkcatalog*)

[DBCC Commands - SAP ASE - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBASE/DBCC+Commands)

- [Install dbcc](#install-dbcc)
- [dbcc checkcatalog](#dbcc-checkcatalog)
- [dbcc checkstorage](#dbcc-checkstorage--checkverify)

```sql
sp_dbcc_help_fault --what to run on error  
sp_help dbcc  
exec sp_dbcc_summaryreport [database]  
exec sp_dbcc_faultreport long, [database]  
sp_indsuspect [table] -- check table for indexes marked as suspected (dbcc reindex)  
sp_dbcc_updateconfig  
dbcc checktable(syslogs) -- show transaction log summary  
select count(*) from syslogs
```


| Command and option | Level | Locking and performance | Speed / Throughness |
| --- | --- | --- | --- |
| checkstorage | Page chains and data rows for all indexes, allocation and OAM pages, device and partition statistics | No locking, performs extensive IO and may saturate the system's IO, can use dedicated cache with minimal mpact on other caches  | Fast / <br />High  |
| checktable checkdb | Page chains, sort order, data rows and partition statistics for all indexes | Shared table lock, dbcc checkdb locaks one table at a time and releases the lock after finishing | Slow / <br />High |
| checktable checkdb with skip_ncindex | Page chains, sort order, and data rows for ables and clustered indexes | Shared table lock; dbce checkdb locks one table at a time and releases the lack afer it fnishes checking that table | Up to 40 % faster than without skip_ncindex / <br />Medium |
| checkalloc | Page chains and partiton statistics | No locking; performs extensive IO and may saturate the IO calls; only allocation pages are cached | Slow / <br/> High |
| tablealloc full / <br/> indexalloc full with full | Page chains | Shared table lock; performs extensive IO only allocation pages are cached | Slow / <br/> High |
| tablealloc indexalloc with optimized | Allocation pages |  Shared table lock; performs extensive IO only allocation pages are cached | Moderate / <br/> Medium |
| tablealloc indexalloc with fast | OAM pages | Shared table lock | Fast / <br/> Low |
| checkcatalog | Rows in system tables | Shared page locks on system catalogs; releases lock after each page is checked, very few pages cached | Moderate / <br/> Medium |

[Internals Of Sybase ASE: DBCC](http://internalsofsybasease.blogspot.com/p/inside-qc.html)

dbcc secrets - [http://www.daf.tf/2011/10/](http://www.daf.tf/2011/10/)

[dbcc Checks | SAP Help Portal](https://help.sap.com/docs/SAP_ASE/4e870f06a15b4bbeb237cca890000421/a8933b36bc2b1014ac27ec4f7f83d103.html?version=16.0.2.0)

[DBCC tune - SAP ASE - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBASE/DBCC+tune)

| checks performed | checkstorage | checktable | checkdb | checkalloc | indexalloc | tablealloc | checkcatalog |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Allocation of text vauled columns | X |  |  |  |  |  |  |
| Index consistency | X | X |  |  |  |  |  |
| Index sort order | X | X |  |  |  |  |  |
| OAM page entries | X | X | X | X | X |  |  |
| Page allocation | X | X | X | X |  |  |  |
| Page consistency | X | X | X |  |  |  |  |
| Pointer consistency | X | X | X |  |  |  |  |
| System tables |  |  |  |  |  |  | X |
| Text column chains | X | X | X | X |  |  |  |
| Text valued columns | X | X | X |  |  |  |  |



## Install dbcc


```sql
----1. sp_plan_dbccdb <my_db> (obtain recommendations for databases)  
----2. use master go  
disk init --(initialize disk devices and the log)  
name = "dbccdb_data",  
physname = "sybase/data/dbccdb_data.dat",  
size = "15M" go  
disk init  
name = "dbccdb_log",  
physname = "sybase/data/dbccdb_log.dat",  
size = "2M" go  
----3. create database dbccdb (on data disk devices)  
on dbccdb_data = 15  
log on dbccdb_log = 2 go  
----4. add segments for scan (optional)  
----5. create named data cache (optional)  
----6. create scan and text workspaces  
use dbccdb go  
exec sp_addsegment scanseg, dbccdb, dbccdb_data go  
exec sp_addsegment textseg, dbccdb, dbccdb_data go  
sp_poolconfig "default data cache", "4M", "32K" go  
sp_configure "number of worker processes", 2 go  
----7. create tables for dbccdb (installdbccdb script)  
----8. create and initialize scan and text workspaces  
----9. sp_dbcc_updateconfig (initialize dbccdb)
```


## dbcc checkcatalog
  
dbcc checkcatalog checks:  
• sysobjects  
• sysindexes  
• syscolumns  
• systypes  
• sysprocedures  
• sysencryptkeys  
• syssegments  
• syspartitions  
• syspartitionkeys  
• master..sysdatabases  
• master..sysusages


## dbcc checkstorage / checkverify

ASE 16 SAG 2 [http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc31644.1600/doc/html/san1371158663946.html](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc31644.1600/doc/html/san1371158663946.html)  
  
[http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc31644.1600/doc/html/san1371158664821.html](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc31644.1600/doc/html/san1371158664821.html)  
  
WIKI - dbcc checkstorage fault codes - [https://wiki.scn.sap.com/wiki/display/SYBASE/DBCC+Checkstorage+Fault+Codes](https://wiki.scn.sap.com/wiki/display/SYBASE/DBCC+Checkstorage+Fault+Codes)