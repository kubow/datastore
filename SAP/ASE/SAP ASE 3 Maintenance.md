- [[#ASE Operational Management]]
- [[backup]]
- [[dbcc]]


# ASE Operational Management

do not restart ASE with problems, diagnose first (už vůbec ne "shutdown with nowait")
https://benohead.com/blog/2014/04/01/sybase-ase-list-tables-current-database-size/
https://stackoverflow.com/questions/33167390/list-all-tables-from-a-database-in-sybase
DBA user guide for beginners https://testmydailyworks.wordpress.com/2012/11/28/sybase-dba-user-guide-for-beginners/

transaction - who is holding
transaction log https://benohead.com/sybase-transaction-log-dump-non-logged-operations/

[Cascade Delete in ASE](https://stackoverflow.com/questions/30437304/get-info-about-foreign-key-on-delete-action)

https://stackoverflow.com/questions/3313421/how-to-determine-how-much-disc-space-a-table-is-using-in-ase

### ASE Client Utilities

[Graphical User Interfaces (GUIs) for ASE - SAP ASE - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBASE/Graphical+User+Interfaces+%28GUIs%29+for+ASE)

- **bcp** utility is a program that copies data to and from file. When performing database maintenance, for example defragging a table, you can use this utility to export data out of your database tables to an operating system for storage, or import data to a table from a file.
- **optdiag** utility displays information associated with the **sysstatistics** and **systabstats** system tables, such as size and structure of a table, its indexes, and the distribution of data within the columns. This utility can be used to detect inefficient space usage in data-only-locked tables.
- **sqldbgr** (SQL Debugger) is a command line utility that debugs stored procedures and triggers. This utility allows you to debug stored procedures by executing them step by step, observing the code path taken and values of variables at each step.
- **ddlgen** utility is Java/based tool that generates T-SQL data definition language (DDL) statements for server and database-level objects in SAP Sybase ASE. It can be used to define the structure of a database. Generate server and database level objects definitions.
- **defncopy** - Extract views, stored procedures and trigger object structure and definition into text file (neumí tabulky)
- **sybmigrate** utility is a migration tool to move schema and data from one ASE server to another. It allows you to transfer data from an ASE of one page size to an ASE of another page size.
- **sybcluster** - managing clusters
- **dbcc** - checking consistency of a database
- **showserver** - shows details about running server
- **charset** - for treating with non-unicode characters
- **cpre** - precompiling - embedded SQL
- ASE Cockpit (general tools)


```
showserver
ps -eaf | grep dataserver

```



## ASE Settings and Configuration

- Using Engines and CPUs 
- Background concepts 
- Single-CPU process model 
- Adaptive Server SMP process model 
- Asynchronous log service 
- Housekeeper wash task improves CPU utilization 
- Measuring CPU usage 
- Enabling engine-to-CPU affinity 
- Multiprocessor application design guidelines 
- Distributing Engine Resources 
- Successfully distributing resources 
- Managing preferred access to resources 
- Types of execution classes 
- Execution class attributes 
- Setting execution class attributes 
- Determining precedence and scope 
- Example scenario using precedence rules 
- Considerations for engine resource distribution

device settings (directio, dsync)

### Data Cache Configuration and Tuning 

- Properly configure memory and choose appropriate cache strategies
- Benefits of named caches, large I/Os, and metadata caches
- Create, delete, and modify named caches
- Bind objects to named caches
- Configure metadata caches
- Create buffer pools to enable large I/Os 
- Buffer pools used by queries 
- How to monitor and tune data cache structures
- Set optimal I/O size 
- Determine and set cache strategy 
- Configure cache partitioning 
- Monitor and tune asynchronous prefetch 

### Data Page Management and Allocation 

- Roles played by allocation page, OAM page, and GAM page in managing allocation
- Tables can grow and become fragmented 
- Structure of the following type of pages: Data, Log, Allocation, OAM and GAM 
- System tables used in object allocation 
- How objects are allocated 
- What happens when tables grow in relationship to allocation 
- What occurs in relationship to system tables and internally when the 'disk init' command is invoked 
- What happens in relationship to system tables and on the allocation tables when the 'create database' command is invoked 
- How various commands use or modify management pages 
- Fragments of a given database and database fragments on a given device 
- Which management pages contain inconsistencies, and discuss options and trade-offs in fixing these 
- Interpret data page header and row layouts 

### Non-master and master device failures 

- How to troubleshoot a device offline error
- How to restore a database with a fragment on a device that has failed 
- How devices and databases are restored 
- How to restore a master device with and without backups of the master database 
- How to recover from several distinct master device failure scenarios 
- Disk reinit and disk refit commands

