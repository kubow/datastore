# MariaDB

MariaDB is a relational DBMS that started as a community fork of [MySQL](../Oracle/MySQL.md). It remains broadly MySQL-compatible in many common workloads, but it has its own optimizer work, storage engines, features and release path.

[https://mariadb.org/](https://mariadb.org/)

## Relationship To MySQL

- Shares historical roots with MySQL and supports the MySQL client/server protocol for many use cases.
- Often works with MySQL-oriented tools and drivers, especially for common SQL workloads.
- Divergence matters for advanced features, optimizer behavior, replication, system variables, authentication and storage engines.
- InnoDB/XtraDB behavior is version-sensitive, so storage-engine assumptions should be checked per MariaDB release.
- Treat it as MySQL-family, not as a drop-in identical engine for every workload.

Related: [MySQL](../Oracle/MySQL.md)

[12 MySQL/MariaDB Security Best Practices for Linux (tecmint.com)](https://www.tecmint.com/mysql-mariadb-security-best-practices-for-linux/)

