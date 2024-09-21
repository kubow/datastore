
- **[Tables](./ClickHouse.Tables.md)**
- **Parts**: physical piece of data within table
	- **Data files**: Store the actual columnar data (in compressed format).
	- **Index files**: Sparse primary keys to speed up look-ups.
	- **Mark files**: Used to skip ranges of rows during queries for faster reads.
- **Indices**
	- **Primary key**: ClickHouse uses a sparse primary key index to speed up range queries. It organises data into blocks and stores primary key values for each block.
	- [A Practical Introduction to Primary Indexes in ClickHouse | ClickHouse Docs](https://clickhouse.com/docs/en/optimize/sparse-primary-indexes)
	- **Secondary indices**: These allow indexing of additional columns for improved performance on specific queries (less commonly used than primary keys).
	- Data skipping to filter data effectively
- **[Security](./ClickHouse.Security.md)**
- **Storage Engines**:
	- **Local file system**: The most common, default mode where data is stored on the server’s local disk.
	- **S3 storage**: ClickHouse supports remote object storage (like AWS S3) for storing large datasets in a cost-effective manner, particularly in cloud deployments.
- **Query Execution Engine**:
	- **Columnar processing**: ClickHouse processes data in columns rather than rows, allowing more efficient storage and faster aggregation queries.
	- **Parallelism**: Queries in ClickHouse can be parallelized across multiple CPU cores and even across multiple nodes in a distributed setup.
	- **Vectorized execution**: ClickHouse uses vectorized query execution, which processes batches of rows (in chunks) at a time to fully utilize modern CPU architectures.
- **Buffering** and **Caching**:
	- **Cache memory**: ClickHouse caches query results, table metadata, and column data in memory to speed up future queries.
	- **Buffer tables**: These are in-memory structures that act as an intermediary between inserts and the final table, batching smaller inserts into larger ones for efficiency.
- **Monitoring** and **Metrics**:
	- **System tables**: ClickHouse includes several system tables (`system.metrics`, `system.parts`, `system.replication_queue`, etc.) that provide detailed insights into the current state of the database and its performance.
	- **Logs**: ClickHouse writes various logs to track query execution, errors, and system events. This includes query logs (`system.query_log`), part merge logs, and replication logs.
- Background Tasks:
	- **Merges**: ClickHouse constantly merges parts in the background to improve read efficiency and reduce the number of parts on disk.
	- **Compactions**: Similar to merges, compaction involves optimizing parts for performance and storage.
	- **Replications**: Background processes handle synchronization and fault tolerance for replicated tables.
		- Replicated tables (`ReplicatedMergeTree`) ensure data availability across multiple servers. ClickHouse automatically handles data synchronization between replicas.
	- **Sharding**: Tables can be distributed across multiple nodes using the **`Distributed`** table engine, allowing the system to horizontally scale.
	- **Garbage collection**: Removes old parts no longer needed after merges or replication synchronization.
	- **Zookeeper**: For replicated tables - coordinate distributed nodes, ensure consistency, and manage replication tasks.

[Settings Overview | ClickHouse Docs](https://clickhouse.com/docs/en/operations/settings/)
### **Configuration Files**

- **clickhouse-server configuration** (`config.xml` or `config.d`): This file contains global settings for the ClickHouse server, like storage paths, replication setup, and memory limits.
- **user settings** (`users.xml` or `users.d`): Defines user access, permissions, and resource limits for different accounts using the ClickHouse system.

### **Data Formats**

[Data Formats supported](https://clickhouse.com/docs/en/sql-reference/formats/)

- ClickHouse supports various data formats for input and output:
    - **Native**: ClickHouse’s own highly efficient binary format.
    - **CSV/TSV**: For compatibility with traditional data exchange formats.
    - **JSON/JSONEachRow**: To handle semi-structured data.
