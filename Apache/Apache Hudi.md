# Apache Hudi

Lakehouse table format focused on incremental processing, upserts, deletes, and streaming ingestion.

https://hudi.apache.org/

## Position

- Lakehouse table format alongside [Apache Iceberg](./Apache%20Iceberg.md), [Delta Lake](../DeltaLake/Delta%20Lake.md), and [Apache Paimon](./Apache%20Paimon.md).
- Strong fit when CDC, incremental pulls, and record-level updates are central.

## Notes

- Supports copy-on-write and merge-on-read table types.
- Commonly used with Spark, Flink, Kafka, Hive, Presto, Trino, and cloud object storage.
- Good candidate for pipelines that need incremental data products instead of full refresh patterns.

