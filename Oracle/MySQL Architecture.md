# MySQL Architecture

## Server Layers

- **Connection handling**: socket/TCP listener, authentication, session state and thread handling.
- **SQL layer**: parser, resolver, privilege checks, optimizer and executor.
- **Optimizer**: chooses join order, access paths, indexes and execution strategy.
- **Storage engine API**: handler interface used by InnoDB, MyISAM, Memory, NDB and other engines.
- **Logging**: binary log, error log, slow query log, relay logs and InnoDB redo/undo.
- **Metadata**: data dictionary, `information_schema`, `performance_schema` and `sys` schema.

Query cache was removed in MySQL 8.0, so old architecture diagrams that include it apply only to older versions.

## Core Objects

- Server instance
- Databases / schemas
- Tables, views and temporary tables
- Indexes and constraints
- Users, roles and grants
- Stored procedures, functions, triggers and events

[Creating and Using MySQL 8 User Attributes](https://www.percona.com/blog/creating-and-using-mysql-8-user-attributes/)
[Comparisons of Proxies for MySQL](https://www.percona.com/blog/comparisons-of-proxies-for-mysql/)
[COUNT(*) vs COUNT(col) in MySQL - Percona Database Performance Blog](https://www.percona.com/blog/count-vs-countcol-in-mysql/)

## Storage Engines

- [InnoDB](#innodb)
- [MyISAM](#myisam)
- [Memory](#memory)
- [NDB Cluster](#ndb-cluster)
- [Archive](#archive)
- [CSV](#csv)
- [Federated](#federated)

[MySQL :: MySQL 8.0 Reference Manual :: 16 Alternative Storage Engines](https://dev.mysql.com/doc/refman/8.0/en/storage-engines.html)

## InnoDB

InnoDB is the default storage engine and the right baseline choice for most MySQL workloads.

- ACID transactions.
- MVCC and row-level locking.
- Clustered primary key: table data is stored with the primary key B-tree.
- Secondary indexes point back to the primary key.
- Redo log for crash recovery.
- Undo logs for rollback and consistent reads.
- Buffer pool caches data and indexes.
- Foreign key support.
- Full-text and spatial indexes are supported in modern versions.

Important operational concepts:

- Choose primary keys carefully because they shape clustered storage and secondary index size.
- Size `innodb_buffer_pool_size` for the working set.
- Watch long transactions because they can retain undo history.
- Use `EXPLAIN`, Performance Schema and slow query logs for query tuning.

### InnoDB Lineage And Variants

InnoDB is the shared storage-engine reference point for much of the MySQL family, but variants are not always identical.

- Oracle MySQL maintains InnoDB as the default transactional engine.
- Percona Server historically included XtraDB, an enhanced InnoDB fork focused on instrumentation and performance.
- [MariaDB](../MariaDB/MariaDB.md) has used both XtraDB and InnoDB across its release history; check version-specific behavior.
- Amazon Aurora MySQL is MySQL-compatible, but its distributed cloud storage layer means InnoDB operational assumptions do not map one-to-one.
- MySQL NDB Cluster is a separate distributed storage engine, not an InnoDB variant.

[InnoDB - Wikipedia](https://en.wikipedia.org/wiki/InnoDB)
[InnoDB - Wikipedie](https://cs.wikipedia.org/wiki/InnoDB)

## MyISAM

Older non-transactional storage engine. Historically the default storage engine, but no longer the preferred default.

- Table-level locking.
- No transactions and no crash-safe recovery comparable to InnoDB.
- Separate files:
	- `*.MYD` - data files
	- `*.MYI` - index files
- Can still appear in legacy systems.

[MyISAM - Wikipedia](https://en.wikipedia.org/wiki/MyISAM)
[MyISAM - Wikipedie](https://cs.wikipedia.org/wiki/MyISAM)
[MySQL :: MySQL 8.0 Reference Manual :: 16.2 The MyISAM Storage Engine](https://dev.mysql.com/doc/refman/8.0/en/myisam-storage-engine.html)

## Memory

Stores table data in memory. Useful for temporary lookup/cache-like tables, but data is not durable across server restart.

## NDB Cluster

Distributed shared-nothing storage engine used by MySQL NDB Cluster.

- Synchronous replication between data nodes.
- Designed for high availability and scale-out.
- Operationally different from ordinary InnoDB deployments.

## Archive

Compressed insert-only storage engine for historical/archive data. Limited indexing and update behavior.

## CSV

Stores tables as CSV files. Useful for interchange and diagnostics, not for serious transactional workloads.

## Federated

Accesses tables from a remote MySQL server. Useful in special integration cases, but usually avoided for high-performance core workloads.

## Replication And High Availability

- **Binary log**: records changes for replication and point-in-time recovery.
- **Asynchronous replication**: common primary-replica pattern.
- **Semi-synchronous replication**: waits for at least one replica acknowledgment.
- **Group Replication / InnoDB Cluster**: MySQL-native HA clustering pattern.
- **NDB Cluster**: separate distributed storage-engine architecture.
- **Vitess**: external sharding/control plane for MySQL-compatible fleets.

## Query And Performance Internals

- `EXPLAIN` and `EXPLAIN ANALYZE` show execution plans.
- Optimizer statistics influence join order and index choice.
- Performance Schema exposes wait, statement, transaction and memory instrumentation.
- Slow query log and `pt-query-digest` are common performance workflows.
- `information_schema` can be expensive on large installations; prefer Performance Schema/sys views where appropriate.
