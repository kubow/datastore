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
[Sybase ASE Performance and Tuning](http://aseperformance.blogspot.com/)
https://stackoverflow.com/questions/3313421/how-to-determine-how-much-disc-space-a-table-is-using-in-ase



```
showserver
ps -eaf | grep dataserver

```

[Performance Tuning and Time Invested](https://logicalread.com/performance-tuning-and-time-invested-tl01/#.ZAj41-vMJ2Q)

Principles of performance: 

- Tuning levels
- Non-procedural SQL

## ASE Settings and Configuration

[Configuring an ASE Server](https://tldp.org/HOWTO/Sybase-ASE-HOWTO/config.html)

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


### Transactions

[Ease Sybase Database Recovery](https://logicalread.com/sybase-backup-database-creation-statements-se01/#.Y7RIHdLMLmE)

[Why and When to Use Sybase ASE Transaction Dumps](https://logicalread.com/sybase-ase-transaction-dumps-se01/#.Y7RH4NLMLmE)

[SybaseFacts: Monitor Sybase error log](http://sybase1500.blogspot.com/2012/10/monitor-sybase-error-log.html)

[2009194 - SYB: How to Capture Tabular Data Stream Protocol Traffic in SAP Netweaver Context | SAP Knowledge Base Article](https://userapps.support.sap.com/sap/support/knowledge/en/2009194)


### Locking and Concurrency Control 

- Introduction tow Locking 
- Locking Configuration and Tuning 
- Locking Reports 
- Using Locking Commands 
- Indexes 
- Indexing for Concurrency Control 

### Understanding Sysmon 

- Introduction to sp_sysmon 
- Monitoring Performance with sp_sysmon   

### Multiple temporary Databases, Partitioning in ASE 15, tempdb performance issue. 

- Creating multiple temporary Databases  
- Partitioning in ASE 15 
- tempdb performance issue 
- Resource Governor   

### Maintenance Activities & troubleshooting: reorg, update stats, index stats, optdiag