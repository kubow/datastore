[rqlite/rqlite: The lightweight, distributed relational database built on SQLite.](https://github.com/rqlite/rqlite)

rqlite wraps SQLite with a Raft consensus layer. It keeps SQLite's SQL engine and file format, but turns writes into replicated log entries so a cluster can provide fault-tolerant relational storage.

## Pattern

- SQLite provides the local SQL execution and storage engine.
- Raft provides leader election and replicated writes.
- Reads can be served with different consistency levels depending on configuration and API use.
- Access is commonly through HTTP API rather than direct SQLite file access.

## Tradeoffs

- Good fit when a small relational database needs simple clustering.
- Not the same as multi-writer SQLite; writes flow through the Raft leader.
- SQLite extensions and local file assumptions may not map cleanly to cluster use.

- [_Quick Start_ guide](https://rqlite.io/docs/quick-start/)
- [Developer guide](https://www.rqlite.io/docs/api)

