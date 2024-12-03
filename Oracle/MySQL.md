multiplatform relational DBMS owned by Oracle
[https://www.mysql.com/](https://www.mysql.com/)

[MySQL databáze - český manuál](https://www.junext.net/mysql/)

- [[MySQL Architecture]]

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

[Impact of Querying Table Information From information_schema - Percona Database Performance Blog al finalal final](https://www.percona.com/blog/impact-of-querying-table-information-from-information_schema/)
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
[It’s All About Replication Lag in PostgreSQL](https://www.percona.com/blog/replication-lag-in-postgresql/)
[Increase the Ability to Securely Replicate Your Data and Restrict Replication To Row-based Events in MySQL](https://www.percona.com/blog/securely-replicate-your-data-and-restrict-replication-to-row-based-events-in-mysql/)
[Replication Issues and Binlog Compressor](https://www.percona.com/blog/replication-issues-and-binlog-compressor/)
