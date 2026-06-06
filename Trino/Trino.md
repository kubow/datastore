# Trino

Distributed SQL query engine for federated analytics across warehouses, lakehouses, object storage, and operational systems.

https://trino.io/

## Position

- Query engine, not a storage engine.
- Common frontliner for SQL over Iceberg, Hive, Delta Lake, S3-compatible object storage, Kafka, relational databases, and many SaaS sources.
- Successor lineage from PrestoSQL; compare with [Presto](../Apache/Apache%20Presto.md), [Dremio](../Dremio/Dremio.md), [Spark](../Apache/Apache%20Spark.md), and [DuckDB](../Duck/DuckDB.md).

## Notes

- Coordinator and worker architecture.
- Uses connectors to push work to underlying systems when possible.
- Strong fit for interactive federated queries and lakehouse SQL.
- Usually paired with a metastore or catalog such as Hive Metastore, AWS Glue Data Catalog, Nessie, or a lakehouse catalog.

