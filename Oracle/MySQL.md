multiplatform relational DBMS owned by Oracle 
[https://www.mysql.com/](https://www.mysql.com/)  

[MySQL databáze - český manuál](https://www.junext.net/mysql/)

- [[MySQL.Storage engines]]
- Process engines
	- Connection/Thread processor
	- Parser
	- Query caching
	- Optimalization
- Databases
- Tables
- Data types
- Work with data

[COUNT(*) vs COUNT(col) in MySQL - Percona Database Performance Blog](https://www.percona.com/blog/count-vs-countcol-in-mysql/)

## Installation

[MySQL :: MySQL NDB Cluster: Scalability](https://www.mysql.com/products/cluster/scalability.html)
  
MySQL Workbench [https://dev.mysql.com/downloads/workbench/](https://dev.mysql.com/downloads/workbench/)  
  
MySQL Schema Generator [https://www.quora.com/Is-there-an-online-MySQL-schema-generator-that-allows-you-to-design-your-database](https://www.quora.com/Is-there-an-online-MySQL-schema-generator-that-allows-you-to-design-your-database)  
  
Launching an AWS MySQL server and importing data from csv files (for free!) [https://www.codementor.io/michaeldu/launching-an-aws-mysql-server-and-importing-data-from-csv-files-for-free-jfpcu409p](https://www.codementor.io/michaeldu/launching-an-aws-mysql-server-and-importing-data-from-csv-files-for-free-jfpcu409p)  

```shell
# db mysql/mariadb  
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql  
systemctl enable mysqld  
systemctl start mysqld  
systemctl status mysqld
```

### Upgrade

[\[BUG\] Stopping Purge/Resuming Purge in Error Logs After Upgrade to MySQL 5.7.40 - Percona Database Performance Blog](https://www.percona.com/blog/bug-stopping-purge-resuming-purge-in-error-logs)


[Tale of a MySQL 8 Upgrade and Implications on Backup - Percona Database Performance Blog](https://www.percona.com/blog/tale-of-a-mysql-8-upgrade-and-implications-on-backup/)
[A Quick Peek at MySQL 8.0.32 - Percona Database Performance Blog](https://www.percona.com/blog/quick-peek-at-mysql-8-0-32/)

#### Clients

PHPmyAdmin  
  
SQL Buddy [http://sqlbuddy.com/](http://sqlbuddy.com/)  
SQL Buddy on Fedora [http://www.tecmint.com/install-sql-buddy-a-web-based-mysql-administration-tool-for-rhel-centos-fedora/](http://www.tecmint.com/install-sql-buddy-a-web-based-mysql-administration-tool-for-rhel-centos-fedora/)

## Maintain

[Identify Active Databases and Users in MySQL - Percona Database Performance Blog](https://www.percona.com/blog/identify-active-databases-and-users-in-mysql/)

[Table Doesn't Exist: MySQL lower_case_table_names Problems - Percona Database Performance Blog](https://www.percona.com/blog/table-doesnt-exist-mysql-lower_case_table_names-problems/)

### Performance

[Deep Dive into MySQL's Performance Schema - Percona Database Performance Blog](https://www.percona.com/blog/deep-dive-into-mysqls-performance-schema/)
[Why MySQL Could Be Slow With Large Tables - Percona Database Performance Blog](https://www.percona.com/blog/why-mysql-could-be-slow-large-tables)

### Archivation

[Quick Data Archival in MySQL Using Partitions - Percona Database Performance Blog](https://www.percona.com/blog/quick-data-archival-in-mysql-using-partitions/)


### Replication

[Working of MySQL Replication Filters When Using Statement-based and Row-based Replication - Percona Database Performance Blog](https://www.percona.com/blog/mysql-replication-filters-when-using-statement-based-and-row-based-replication/)

