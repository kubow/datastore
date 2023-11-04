
[Prepared for the Future with next-gen SAP ASE | SAP Blogs](https://blogs.sap.com/2020/03/03/prepared-for-the-future-with-next-gen-sap-ase/)
[SAP Sybase ASE “Magic Numbers” and Hardcoded Behaviour | just dave info (wordpress.com)](https://justdaveinfo.wordpress.com/2015/05/19/sap-sybase-ase-magic-numbers-and-hardcoded-behaviour/)


# Main features

| Main Features | Improvement areas | Common abbreviations |
| --- | --- | --- |
| <ul><li> Compression </li><li> In-row LOBs </li><li> Data partititoning </li><li> Task scheduler </li><li> Resource configuration limits </li></ul> | <ul><li> Scalability & Performance </li><li> Workload optimization </li><li> Security </li><li> Real-time data distribution </li><li> Cloud ready & flexible deployment </li></ul> | <ul><li> **XOLTP** (Extreme OLTP) </li><li> **IMRS** (In-memory row storage) </li><li> **MVCC** (Multi version concurency control) </li><li> **HCB** (Hash cached B-trees) </li><li> **CCL** (Common crypto library) </li></ul> |



# Layers

- Database > Segment > Device (Physical - Raw Device or Data File)
- Allocation Unit
- Extent
- ASE Page (OS Block for Data Files / Raw Partitions partitioned)

![[ASE_databases.png]]

## **Database objects**

- **Tables** - store data
- **Views** - simplify / restrict access to data
- **Indexes** - improving DB performance during data retrieval
- **Defaults** - supply default values to tables
- **Rules** - restrict type of data that can be inserted into tables
- **Stored procedures / Triggers** - stored batches of SQL statements (help maintain data)


HASH MARK TABLE = temporary table


- Allcations
- Cache
- Users

## ASE Client Utilities

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
