# Delta Lake

Open table format and storage layer for lakehouse workloads.

https://delta.io/

## Position

- Lakehouse table format alongside [Apache Iceberg](../Apache/Apache%20Iceberg.md), [Apache Hudi](../Apache/Apache%20Hudi.md), and [Apache Paimon](../Apache/Apache%20Paimon.md).
- Closely associated with [Databricks](../Databricks/Databricks.md), but usable outside Databricks as an open format.

## Notes

- Adds ACID transactions, schema enforcement/evolution, time travel, and metadata handling on data lake files.
- Commonly stored on S3, ADLS, GCS, or compatible object storage.
- Often queried with Spark, Databricks SQL, Trino, Presto, Flink, and other lakehouse engines.

