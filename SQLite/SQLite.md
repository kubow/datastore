# SQLite

[SQLite Home Page](https://www.sqlite.org/index.html)
[SQLite - Wikipedia](https://en.wikipedia.org/wiki/SQLite)
[charles leifer | SQLite: Small. Fast. Reliable. Choose any three.](https://charlesleifer.com/blog/sqlite-small-fast-reliable-choose-any-three-/)
[Well-Known Users Of SQLite](https://www.sqlite.org/famous.html)

SQLite is an embedded relational database engine. It is linked into the application process, stores data in a single ordinary file, and needs no separate server process.

## Related Notes

- [Installation and tooling](SQLite%20Install.md)
- [Maintenance](SQLite%20Maintenance.md)
- [rqlite](./RQLite.md) - distributed relational database built on SQLite.

## System

[Architecture of SQLite](https://sqlite.org/arch.html)
[The Schema Table (sqlite.org)](https://www.sqlite.org/schematab.html)
[How does SQLite work? Part 2: btrees | Hacker News](https://news.ycombinator.com/item?id=23668133)

## Core Fundamentals

- **Embedded engine**: SQLite is a C library used in-process, not a client/server DBMS.
- **Single-file database**: the database is an ordinary cross-platform file, plus temporary journal/WAL files during writes.
- **ACID transactions**: transactions are durable through rollback journal or WAL mode.
- **Serverless concurrency model**: many readers can coexist; writes are serialized. WAL improves read/write overlap but still has one writer at a time.
- **B-tree storage**: tables and indexes are stored as B-trees over fixed-size pages managed by the pager.
- **Dynamic typing with affinity**: values have storage classes, while columns have type affinity rather than strict static typing by default.
- **Rowid tables**: ordinary tables have an implicit integer `rowid`; `WITHOUT ROWID` tables use the primary key as the storage key.
- **SQL virtual machine**: SQL compiles into bytecode executed by SQLite's VDBE.

## Important Features

- Transactions, savepoints, triggers, views and foreign keys.
- CTEs, recursive queries, window functions and `UPSERT`.
- Expression, partial and covering indexes.
- Generated columns and `STRICT` tables for stronger typing.
- `ATTACH DATABASE` for querying multiple database files in one connection.
- User-defined scalar, aggregate and window functions.
- Loadable extensions.

## Extension Modules

- **FTS5**: full-text search virtual tables.
- **R-Tree**: spatial and range indexing.
- **JSON1 / JSONB**: JSON functions and operators.
- **Geopoly**: polygon operations.
- **Session**: changeset and patchset support.
- **CSV / fileio / series**: useful command-line and extension-table helpers.
- **SpatiaLite**: geospatial database extension built on SQLite.

## Operational Patterns

- **Rollback journal**: traditional transaction journal; simple and robust.
- **WAL mode**: write-ahead log; usually better for read-heavy apps with occasional writes.
- **Busy timeout / retry**: important when multiple processes may write.
- **Vacuuming**: `VACUUM` rebuilds the database file; `auto_vacuum` changes free-page handling.
- **Integrity checks**: `PRAGMA integrity_check` and `PRAGMA quick_check`.
- **Backups**: online backup API, `.backup`, `.dump`, file-level backup only when safe.

## Fits Well

- Embedded applications and local-first apps.
- Mobile, desktop, edge and IoT storage.
- Application metadata, cache, queue/outbox and local catalogs.
- Small to medium analytical datasets when write concurrency is low.
- Test fixtures and portable data files.

## Does Not Fit Well

- High-concurrency write workloads.
- Central multi-tenant database servers with role management and network access control.
- Workloads that require built-in replication, clustering or point-in-time recovery without extra tooling.
- Very large shared databases where operational control matters more than embeddability.

## Engines And Systems Built Around SQLite

- [rqlite](./RQLite.md)
	- Distributed relational database built on SQLite and Raft.
	- Adds HTTP API, clustering and replicated writes.
- dqlite
	- Distributed SQLite using Raft, created by Canonical.
	- Used where an embedded SQL store needs consensus-backed replication.
- libSQL / Turso
	- SQLite fork and hosted/distributed service family.
	- Adds server mode, replication-oriented features and cloud/edge deployment options.
- LiteFS
	- Filesystem layer for SQLite replication, commonly associated with Fly.io.
	- Keeps SQLite as the application database while replicating file changes.
- Litestream
	- Continuous SQLite backup/replication tool to object storage.
	- Good for disaster recovery rather than multi-writer clustering.
- SpatiaLite
	- Geospatial engine extension on top of SQLite.
	- Adds spatial types, functions and indexes.
- Datasette
	- Publishing/exploration tool for SQLite databases.
	- Not a storage engine, but important in the SQLite ecosystem.
- SQL.js / SQLite WASM
	- SQLite compiled to WebAssembly for browser and sandboxed runtimes.
	- Useful for local analysis and offline browser apps.

## Practical Examples

Batch command line:
[Accessing Sqlite from a DOS batch file - bigcode](https://bigcode.wordpress.com/2010/12/12/accessing-sqlite-from-a-dos-batch-file/)

Use case:
[1.1 Billion Taxi Rides with SQLite, Parquet & HDFS](https://tech.marksblogg.com/billion-nyc-taxi-rides-sqlite-parquet-hdfs.html)
