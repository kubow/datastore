# Amazon Athena

Serverless interactive query service for data in Amazon S3 and other sources.

https://aws.amazon.com/athena/

## Position

- Managed query engine, not a primary storage engine.
- Compare with [Trino](../Trino/Trino.md), [Presto](../Apache/Apache%20Presto.md), [BigQuery](../Google/Google%20BigQuery.md), [Dremio](../Dremio/Dremio.md), and [DuckDB](../Duck/DuckDB.md).

## Notes

- Commonly queries Parquet, ORC, CSV, JSON, Iceberg, and Hive-style data on S3.
- Uses AWS Glue Data Catalog for metadata in many deployments.
- Good fit for ad-hoc SQL over object storage without managing query clusters.

