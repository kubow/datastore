ClickHouse's SQL dialect description:

1.  [Query Language | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/statements/): 
	- supports most standard SQL features such as SELECT, FROM, WHERE, GROUP BY, ORDER BY, JOIN, and UNION. 
	- support for subqueries, materialized views, and window functions.
2. [Functions | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/functions/)
	- rich set of built-in functions
	- [Aggregate Functions | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/aggregate-functions) 
		- rollups, cube sets, grouping sets, pivot and unpivot tables.
	- support for user-defined functions (UDFs) in several programming languages such as C++, Python, and JavaScript.
3. [Syntax | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/syntax/): 
	- similar to standard SQL
	- uses backticks instead of double quotes to delimit identifiers
	- uses square brackets instead of single quotes for string literals.
4. Indexing ([A Practical Introduction to Primary Indexes in ClickHouse | ClickHouse Docs](https://clickhouse.com/docs/en/optimize/sparse-primary-indexes#clickhouse-index-design)):
	- no traditional indexing methods like B-trees or hash indexes. 
	- Instead, it uses a unique indexing system called 'MergeTree'. It allows for efficient data retrieval by using sorted, compressed data blocks.
    