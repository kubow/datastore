[SQL Anywhere - Wikipedia](https://en.wikipedia.org/wiki/SQL_Anywhere)
[SAP SQL Anywhere | RDBMS for IoT and Data-Intensive Apps](https://www.sap.com/products/technology-platform/sql-anywhere.html)

## Architecture

SQL Anywhere databases, transaction logs, and dbspaces are simply regular les on a filesystem. The filesystem is provided by the operating system and is responsible for turning operations on files and directories into I/O requeststhat can be issued to the storage driver. The storage driver then forwards its requests directly to the storage controller (hardware) which finally passes the requests down to the disk drive.

- **UltraLite** - The lightened version of SQL Anywhere  
- **Mobilink** - Reliable, bidirectional synchronization between remote and enterprise systems including SQL Anywhere, Sybase ASE, Oracle, Microsoft SQL Server, IBM DB2, application servers, ERP systems and Web services.

[SAP SQL Anywhere - Architecture - Support Wiki](https://wiki.scn.sap.com/wiki/display/SQLANY/SQL+Anywhere)

High level overview:

- Filesystem 
- Storage Driver 
- Storage Controller 
- Disk Drive

Data Server parts:

- Server
	- Options
	- Properties ([list v17](https://dcx.sap.com/index.html#sqla170/en/html/3bc6ad206c5f1014b043b4cc42d7fc07.html))
- Connection
	- Options
	- Properties ([list v17](https://dcx.sap.com/index.html#sqla170/en/html/3bc695906c5f10148aaabe9d8f52d0e5.html))
- Database
	- Options
	- Properties ([list v17](https://dcx.sap.com/index.html#sqla170/en/html/3bc6a5766c5f1014a1b8e1f06f9b86e0.html))
	- Views ([v12](https://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.help.sqlanywhere.12.0.1/dbreference/rf-system-views.html))
	- Tables
- Memory
	- Initial cache size
	- Maximum cache size
	- Minimum cache size
	- 


## Install

[SAP SQL Anywhere Database Client Download - SAP SQL Anywhere - Support Wiki](https://wiki.scn.sap.com/wiki/display/SQLANY/SAP+SQL+Anywhere+Database+Client+Download)
[Get SQL Anywhere - Manage, Synchronize and Exchange Data](https://sqlanywhere.info/)
[SAP Store SQLAnywhere](https://www.sapstore.com/solutions/99017/SAP-SQL-Anywhere)
[SAP SQL Anywhere 16.0 Components by Platforms - SAP SQL Anywhere - Support Wiki](https://wiki.scn.sap.com/wiki/display/SQLANY/SAP+SQL+Anywhere+16.0+Components+by+Platforms#SA)

### Versions

![[ASA_history.jpg]]

- 1992: Initially published as "Watcom SQL" (version 3) by Watcom
- 1993: PowerSoft took over Watcom
- 1995: Sybase bought PowerSoft and renamed the product "SQL Anywhere" (Version 4)
- 1998: Renamed "Adaptive Server Anywhere" (Version 6)
- 2005: Renamed "SQL Anywhere" (Version 10)
- 2008: Version 11 released
- 2010: SAP acquired Sybase - Version 12 released
- 2013: Version 16 released
	- Version 13 and 14 were skipped for cultural reasons (13 is bad luck in US and 14 in China). 
	- Fifteen was also dropped because Sybase wanted to align several product versions with 16, so SQL Anywhere directly jumped from 12 to 16.  
- 2015: Version 17 released
- 2016: "Standard" and "Workgroup" disappeared. Per CPU licenses replaced by Core.

[SQL Anywhere history](https://www.sqlanywhere.info/EN/sql-anywhere/sql-anywhere-history.html)
[Announcing SQL Anywhere 17! | SAP Blogs](https://blogs.sap.com/2015/07/15/announcing-sql-anywhere-17-2/)

[SAP SQL Anywhere (sapstore.com)](https://www.sapstore.com/solutions/99017/SAP-SQL-Anywhere)
[SQL Anywhere - Editions and Licensing Models](https://sqlanywhere.info/EN/sql-anywhere/sql-anywhere-licensing.html)


### Editions

[Current Editions](https://sqlanywhere.info/EN/sql-anywhere/sql-anywhere-licensing.html) :

- **Edge Edition** - per named users or per core licenses (4/8 only) available
- **Advanced Edition** - per named users or per core licenses, supports more OS, more features
- **DB & Sync Client** - add-on to per-named user Server licenses (Edge/Advanced)
- **Personal Database** - Run database on a client

[Socket/CPU definition](https://answers.sap.com/questions/10956399/what-is-the-defintion-of-socket-andor-cpu-in-conne.html)

### Licensing

[Licensing SAP SQL Anywhere in Virtual Environments – Updated | SAP Blogs](https://blogs.sap.com/2014/12/02/licensing-sap-sql-anywhere-in-virtual-environments/)
[What is the defintion of socket and/or CPU in connection with SQLAnywhere 16 | SAP Community](https://answers.sap.com/questions/10956399/what-is-the-defintion-of-socket-andor-cpu-in-conne.html)
[Licensing SQL Anywhere 16? - SQLA Forum](https://130.214.205.148/questions/19287/licensing-sql-anywhere-16)
Available types of version 16 license keys [https://launchpad.support.sap.com/#/notes/2196280](https://launchpad.support.sap.com/#/notes/2196280)


## Maintain

[SAP SQL Anywhere -Main page - Support Wiki](https://wiki.scn.sap.com/wiki/display/SQLANY)

[Search "SQL Anywhere" the SAP Community](https://community.sap.com/search/?by=updated&ct=all&mt=67837800100800005169)

[SQL Anywhere® 16 - Introduction (softpi.com)](https://www.softpi.com/wp-content/uploads/2016/05/SAP_Sybase_SQL_Anywhere_16_INTRO.pdf)


Blog
[SQL Anywhere blog](http://sqlanywhere.blogspot.com/)
not secure [SAP SQL Anywhere forum](https://130.214.205.148/)




### Cache

You can  disable dynamic cache sizing by using the -ca 0 server option. 

The following database server properties return information about the database server cache:  
- **CurrentCacheSize** Returns the current cache size, in kilobytes.  
- **MinCacheSize** Returns the minimum allowed cache size, in kilobytes.  
- **MaxCacheSize** Returns the maximum allowed cache size, in kilobytes.  
- **PeakCacheSize** Returns the largest value the cache has reached in the current session, in kilobytes.


### Multiprogramming Level
[Server Configuration Multiprogramming Level](https://help.sap.com/docs/SAP_SQL_Anywhere/61ecb3d4d8be4baaa07cc4db0ddb5d0a/814c2a796ce210148d899ecd9daeb081.html?version=17.0)


```bash
-gn vs. -gna

```


### Monitoring


```bash
./dbstats -e {server_name}
./dbstats -e {server_name} -o {log_file_name}
```



## SQL 

[Sybase SQL Anywhere Reference - SQLines Tools](http://www.sqlines.com/sybase-asa)