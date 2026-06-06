# MySQL

MySQL is a multi-platform relational DBMS owned by Oracle. It is a client/server SQL database with pluggable storage engines, most commonly InnoDB.

[https://www.mysql.com/](https://www.mysql.com/)

[MySQL databáze - český manuál](https://www.junext.net/mysql/)

- [MySQL Architecture](MySQL%20Architecture.md)

## Core Fundamentals

- **Client/server DBMS**: applications connect to `mysqld` over local sockets or TCP.
- **SQL layer plus storage engines**: parser, optimizer, privilege checks and replication sit above engines such as InnoDB, MyISAM, Memory, NDB and others.
- **InnoDB default**: transactional storage engine with MVCC, row-level locking, crash recovery, buffer pool and clustered primary keys.
- **Schema model**: MySQL historically treats `database` and `schema` as synonyms.
- **Concurrency**: InnoDB handles many readers/writers through MVCC, locks and transaction isolation.
- **Replication-first ecosystem**: binary logs enable async replication, semi-sync replication, point-in-time recovery and change data capture.
- **Operational personality**: many behaviors depend on server variables, SQL modes, storage engine settings and filesystem/collation choices.

## Important Features

- ACID transactions with InnoDB.
- Stored procedures, functions, triggers, events and views.
- Partitioned tables.
- CTEs, window functions and recursive CTEs in MySQL 8.
- JSON data type and JSON functions.
- Full-text indexes for InnoDB and MyISAM.
- Spatial data types and indexes.
- Performance Schema and `sys` schema for observability.
- Roles, users, grants and pluggable authentication.

## Fits Well

- Web and application OLTP workloads.
- Read-heavy systems with replicas.
- Systems that benefit from mature tooling, managed services and broad driver support.
- Moderate analytics inside an OLTP application, especially with proper indexing and summaries.

## Does Not Fit Well

- Heavy analytical scans without columnar/MPP extensions.
- Multi-primary distributed SQL without extra systems.
- Schemas needing strong standard SQL portability.
- Workloads where exact behavior across SQL modes, collations and storage engines must be identical across vendors.

## Ecosystem And Related Engines

- [MariaDB](../MariaDB/MariaDB.md)
	- Fork of MySQL with its own optimizer, storage engines and release path.
- Percona Server for MySQL
	- MySQL-compatible distribution focused on operational/performance features.
- MySQL NDB Cluster
	- Distributed shared-nothing storage engine for high availability and scale-out.
- MySQL HeatWave
	- Oracle-managed MySQL service with in-memory analytics acceleration.
- Vitess
	- Sharding and clustering layer for MySQL, originally from YouTube.
- PlanetScale
	- Managed Vitess/MySQL-compatible service.
- Amazon Aurora MySQL
	- MySQL-compatible managed engine with distributed cloud storage.
- TiDB
	- MySQL-compatible distributed SQL database; not MySQL internally, but relevant for MySQL ecosystem migrations.

## Lineage And Compatibility

MySQL is the common reference point for a broader family of compatible or historically related systems. [MariaDB](../MariaDB/MariaDB.md) started as a fork of MySQL after Oracle acquired Sun/MySQL, while Percona Server stays closer to MySQL with operational enhancements. Aurora MySQL, PlanetScale/Vitess and TiDB target MySQL protocol or SQL compatibility, but are not simply the same engine internally.

Compatibility should be checked at several layers:

- Wire protocol and client drivers.
- SQL dialect, optimizer behavior and SQL modes.
- Stored routines, triggers, events and replication behavior.
- Storage engines and engine-specific features, especially [InnoDB](MySQL%20Architecture.md#innodb) and its variants.
- Operational tooling, backup, HA and observability.

## Installation

[MySQL :: MySQL NDB Cluster: Scalability](https://www.mysql.com/products/cluster/scalability.html)

MySQL Workbench [https://dev.mysql.com/downloads/workbench/](https://dev.mysql.com/downloads/workbench/)

MySQL Schema Generator [https://www.quora.com/Is-there-an-online-MySQL-schema-generator-that-allows-you-to-design-your-database](https://www.quora.com/Is-there-an-online-MySQL-schema-generator-that-allows-you-to-design-your-database)

Launching an AWS MySQL server and importing data from csv files (for free!) [https://www.codementor.io/michaeldu/launching-an-aws-mysql-server-and-importing-data-from-csv-files-for-free-jfpcu409p](https://www.codementor.io/michaeldu/launching-an-aws-mysql-server-and-importing-data-from-csv-files-for-free-jfpcu409p)

### Settings

[The Most Important MySQL Setting](https://www.percona.com/blog/the-most-important-mysql-setting/)

```shell
# db mysql/mariadb
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mysqld
systemctl start mysqld
systemctl status mysqld
```

### Upgrade

[\[BUG\] Stopping Purge/Resuming Purge in Error Logs After Upgrade to MySQL 5.7.40 - Percona Database Performance Blog](https://www.percona.com/blog/bug-stopping-purge-resuming-purge-in-error-logs)
[MySQL 5.7 Upgrade Issue: Reserved Words](https://www.percona.com/blog/mysql-5-7-upgrade-issue-reserved-words/)

[Tale of a MySQL 8 Upgrade and Implications on Backup - Percona Database Performance Blog](https://www.percona.com/blog/tale-of-a-mysql-8-upgrade-and-implications-on-backup/)
[A Quick Peek at MySQL 8.0.32 - Percona Database Performance Blog](https://www.percona.com/blog/quick-peek-at-mysql-8-0-32/)

#### Clients

PHPmyAdmin

SQL Buddy [http://sqlbuddy.com/](http://sqlbuddy.com/)  
SQL Buddy on Fedora [http://www.tecmint.com/install-sql-buddy-a-web-based-mysql-administration-tool-for-rhel-centos-fedora/](http://www.tecmint.com/install-sql-buddy-a-web-based-mysql-administration-tool-for-rhel-centos-fedora/)

## Maintain

[Identify Active Databases and Users in MySQL - Percona Database Performance Blog](https://www.percona.com/blog/identify-active-databases-and-users-in-mysql/)

[Table Doesn't Exist: MySQL lower_case_table_names Problems - Percona Database Performance Blog](https://www.percona.com/blog/table-doesnt-exist-mysql-lower_case_table_names-problems/)

[MySQL 8 Doesn't Like Your Groups](https://www.percona.com/blog/mysql-8-doesnt-like-your-groups/)

[Impact of Querying Table Information From information_schema - Percona Database Performance Blog](https://www.percona.com/blog/impact-of-querying-table-information-from-information_schema/)
[The Impacts of Fragmentation in MySQL](https://www.percona.com/blog/the-impacts-of-fragmentation-in-mysql/)

[MySQL Key Performance Indicators (KPI) With PMM](https://www.percona.com/blog/mysql-key-performance-indicators)

### Performance

[Deep Dive into MySQL's Performance Schema - Percona Database Performance Blog](https://www.percona.com/blog/deep-dive-into-mysqls-performance-schema/)
[Why MySQL Could Be Slow With Large Tables - Percona Database Performance Blog](https://www.percona.com/blog/why-mysql-could-be-slow-large-tables)

[MySQL Data Caching Efficiency](https://www.percona.com/blog/mysql-data-caching-efficiency/)

InnoDB
[InnoDB Performance Optimization Basics](https://www.percona.com/blog/innodb-performance-optimization-basics-updated)

### Indexes

[Take This Unique Quiz About Duplicate Indexes In MySQL | pt-duplicate-key-checker](https://www.percona.com/blog/take-this-unique-quiz-about-duplicate-indexes-in-mysql-pt-duplicate-key-checker/)

### Partitions

[Fixing Misplaced Rows in a Partitioned Table](https://www.percona.com/blog/fixing-misplaced-rows-in-a-partitioned-table/)

### Backup / Restore

[Backup and Restore Using MySQL Shell](https://www.percona.com/blog/backup-and-restore-using-mysql-shell/)
[A Workaround for The “RELOAD/FLUSH_TABLES privilege required” Problem When Using Oracle mysqldump 8.0.32](https://www.percona.com/blog/workaround-for-the-reload-flush_tables-privilege-required-problem-when-using-oracle-mysqldump-8-0-32/)
Archiving
[Quick Data Archival in MySQL Using Partitions - Percona Database Performance Blog](https://www.percona.com/blog/quick-data-archival-in-mysql-using-partitions/)

### Replication

[Working of MySQL Replication Filters When Using Statement-based and Row-based Replication - Percona Database Performance Blog](https://www.percona.com/blog/mysql-replication-filters-when-using-statement-based-and-row-based-replication/)
[Increase the Ability to Securely Replicate Your Data and Restrict Replication To Row-based Events in MySQL](https://www.percona.com/blog/securely-replicate-your-data-and-restrict-replication-to-row-based-events-in-mysql/)
[Replication Issues and Binlog Compressor](https://www.percona.com/blog/replication-issues-and-binlog-compressor/)
