Column oriented DBMS for OLAP created originally by Yandex
- https://clickhouse.com/
- [[Clickhouse Cloud]]

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

## System




### Data types

[Data Types | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/data-types)

- Dates
	- [Support Dates and DateTimes outside of 1970-2105 range. · Issue #7316 · ClickHouse/ClickHouse](https://github.com/ClickHouse/ClickHouse/issues/7316)


[System Tables and a Window into the Internals of ClickHouse](https://clickhouse.com/blog/clickhouse-debugging-issues-with-system-tables)
System tables:
- [time_zones | ClickHouse Docs](https://clickhouse.com/docs/en/operations/system-tables/time_zones)



## Install

[ClickHouse Quick Start | ClickHouse Docs](https://clickhouse.com/docs/en/getting-started/quick-start)

```shell
curl https://clickhouse.com/ | sh
sudo ./clickhouse install
cd /etc/clickhouse-server # config files
sudo clickhouse start  # start clickhouse server
clickhouse-client
cat /var/log/clickhouse-server/clickhouse-server.err.log  # browse errorlog
```

### Connect

[Command-Line Client | ClickHouse Docs](https://clickhouse.com/docs/en/interfaces/cli/)
[python clickhouse-driver 0.2.5 documentation](https://clickhouse-driver.readthedocs.io/en/latest/index.html)
Interfaces:
- [MySQL Interface | ClickHouse Docs](https://clickhouse.com/docs/en/interfaces/mysql)
- [PostgreSQL Interface | ClickHouse Docs](https://clickhouse.com/docs/en/interfaces/postgresql)



## Work with data

### Data types

https://clickhouse.com/docs/en/sql-reference/data-types/

Every table needs to have engine defined

```SQL
SHOW DATABASES
CREATE DATABASE my_database
SHOW TABLES IN my_database
CREATE TABLE my_table ( col1 UInt32, col2 String, col3 DateTime ) ENGINE = MergeTree PARTITION BY toYYYYMM(col3) ORDER BY col1
SELECT * FROM my_table

```


[Working with Time Series Data in ClickHouse](https://clickhouse.com/blog/working-with-time-series-data-and-functions-ClickHouse)




Data ingestion
[Data Formats supported](https://clickhouse.com/docs/en/sql-reference/formats/)

Settings
[Settings Overview | ClickHouse Docs](https://clickhouse.com/docs/en/operations/settings/)

### Primary keys
https://clickhouse.com/docs/en/guides/improving-query-performance/sparse-primary-indexes/sparse-primary-indexes-intro


### Mutation Commands

- Update a row needs table alter
- Get staged and waiting for a merge

```SQL
ALTER TABLE random UPDATE y = "hello" WHERE x > 10  --cannot update primary key
DELETE FROM random WHERE y != "hello"
```


Performance: 
	- designed to handle large volumes of data at high speed. 
	- uses columnar storage and data compression techniques to optimize query performance
	- distributed architecture that allows it to scale horizontally, making it well-suited for big data applications.


## Bonus

Uber replaced Elasticsearch with ClickHouse for logging, a good primary key could be a compound key like PRIMARY KEY(log_level, ..., timestamp)

Companies using ClickHouse for logs:
- Cloudflare: [https://blog.cloudflare.com/log-analytics-using-clickhouse/](https://blog.cloudflare.com/log-analytics-using-clickhouse/)
- Uber: [https://www.uber.com/blog/logging/](https://www.uber.com/blog/logging/)
- Ebay: [https://tech.ebayinc.com/engineering/ou-online-analytical-processing](https://tech.ebayinc.com/engineering/ou-online-analytical-processing/)