Column oriented DBMS for OLAP (new [[Clickhouse Cloud]])


https://clickhouse.com/



Each table must specify a **[table engine](https://clickhouse.com/docs/en/engines/table-engines/)**:

- **MergeTree** (most universal and functional table engine)
	- ORDER BY(a,...) is implicitly defining a PRIMARY KEY(a,...) and vice versa
	- Insers are performed in bulk (part is stored in folder)
	- **Part** folder contains immutable files(Merges up to 150GB):
		- primary.idx
		- column1.bin, ...columnx.bin
		- *.mrk2 (mark to help) files*
	- LZ4 compression by default (min/max default = 64K-1MB)
	- **Granule** = logical view inside blocks (bin files)
	- 8192 rows by default (or 10Mb in size)
	- **primary.idx** has keys per granule
	- sent to thread for processing
	- https://clickhouse.com/docs/en/guides/improving-query-performance/sparse-primary-indexes/sparse-primary-indexes-cardinality/
	- 

## Modelling data



```SQL
SHOW DATABASES
CREATE DATABASE my_database
SHOW TABLES IN my_database
CREATE TABLE my_table ( col1 UInt32, col2 String, col3 DateTime ) ENGINE = MergeTree PARTITION BY toYYYYMM(col3) ORDER BY col1
SELECT * FROM my_table

```


### Data types

https://clickhouse.com/docs/en/sql-reference/data-types/

Dat ingestion
[Data Formats supported](https://clickhouse.com/docs/en/sql-reference/formats/)


### Primary keys
https://clickhouse.com/docs/en/guides/improving-query-performance/sparse-primary-indexes/sparse-primary-indexes-intro


### Mutation Commands

- Update a row needs table alter
- Get staged and waiting for a merge

```SQL
ALTER TABLE random UPDATE y = "hello" WHERE x > 10  --cannot update primary key
DELETE FROM random WHERE y != "hello"
```





## Bonus

Uber replaced Elasticsearch with ClickHouse for logging, a good primary key could be a compound key like PRIMARY KEY(log_level, ..., timestamp)

Companies using ClickHouse for logs:
- Cloudflare: [https://blog.cloudflare.com/log-analytics-using-clickhouse/](https://blog.cloudflare.com/log-analytics-using-clickhouse/)
- Uber: [https://www.uber.com/blog/logging/](https://www.uber.com/blog/logging/)
- Ebay: [https://tech.ebayinc.com/engineering/ou-online-analytical-processing](https://tech.ebayinc.com/engineering/ou-online-analytical-processing/)