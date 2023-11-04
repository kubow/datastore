
[An in-process SQL OLAP database management system - DuckDB](https://duckdb.org/)
[DuckDB — What’s the Hype About?. This was a blog post that I already… | by Oliver Molander | Better Programming](https://betterprogramming.pub/duckdb-whats-the-hype-about-5d46aaa73196)

- Simple and portable
- Feature-rich
	- Direct Parquet, CSV, JSON query
	- Joins aggregates
- Fast - optimized for analytics
- Open Source


[DuckDB ADBC - Zero-Copy data transfer via Arrow Database Connectivity - DuckDB](https://duckdb.org/2023/08/04/adbc.html)

[Guides - DuckDB](https://duckdb.org/docs/archive/0.8.1/guides/index)

```sql
--- import from csv / parquet / json / xlsx 
CREATE TABLE new_tbl AS SELECT * FROM read_csv_auto('input.');  -- create new table
INSERT INTO tbl SELECT * FROM read_csv_auto('input.');  -- update existing one
--- tables interaction
CREATE TABLE tbl(i INTEGER); 
CREATE SCHEMA s1; 
CREATE TABLE s1.tbl(v VARCHAR); 
SHOW ALL TABLES;
DESCRIBE tbl;

```

[python - How to read a csv file from google storage using duckdb - Stack Overflow](https://stackoverflow.com/questions/76297471/how-to-read-a-csv-file-from-google-storage-using-duckdb)


[The Guide to Data Analysis with DuckDB - Analytics Vidhya](https://www.analyticsvidhya.com/blog/2021/12/the-guide-to-data-analysis-with-duckdb/)

[Build a poor man’s data lake from scratch with DuckDB | Dagster Blog](https://dagster.io/blog/duckdb-data-lake)
