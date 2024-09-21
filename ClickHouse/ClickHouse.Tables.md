## Table Engines

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
- **Dictionary**: Holds static or slowly changing data, optimized for lookups.
- **Distributed**: Enables sharding across multiple ClickHouse servers, used for distributed queries.
- **Log/StripeLog**: Used for small datasets with simple logging or batch processing.
- **Memory**: Stores data entirely in memory for fast reads/writes, ideal for temporary operations.

**System Tables**:

- [System Tables and a Window into the Internals of ClickHouse](https://clickhouse.com/blog/clickhouse-debugging-issues-with-system-tables)
	- system.users
	- system.roles, system.role_grants
	- system.current_roles, system.enabled_roles
	- system.settings_profiles
	- system.settings (for currently used profile)
	- system.quotas
	- system_quotas_usage
	- system.row_policies
	- system.user_directories
	- [time_zones | ClickHouse Docs](https://clickhouse.com/docs/en/operations/system-tables/time_zones)

```SQL
SHOW DATABASES
CREATE DATABASE my_database
SHOW TABLES IN my_database

CREATE TABLE my_table ( col1 UInt32, col2 String, col3 DateTime ) ENGINE = MergeTree PARTITION BY toYYYYMM(col3) ORDER BY col1
SELECT * FROM my_table
SELECT formatReadableSize(total_bytes) FROM system.tables WHERE name = 'xxx'

```

- Update a row needs table alter
- Get staged and waiting for a merge

```SQL
ALTER TABLE random UPDATE y = "hello" WHERE x > 10 --cannot update primary key
DELETE FROM random WHERE y != "hello"
```

## Data types

[Data Types | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/data-types)

- **Numeric Types**:
    - **Integers**: `Int8`, `Int16`, `Int32`, `Int64`, `UInt8`, `UInt16`, `UInt32`, `UInt64` (signed/unsigned integer types).
    - **Floating-point**: `Float32`, `Float64` (32-bit and 64-bit floating-point types).
- **String Types**:
    - **`String`**: Variable-length string data.
    - **`FixedString(N)`**: Fixed-length string data, more efficient for fixed-size data like short codes.
- **Date and Time Types**:
    - **`Date`**: Represents a calendar date, typically stored in a compact 16-bit format.
    - **`DateTime`**: Represents a date and time (stored as an integer representing Unix time).
    - **`DateTime64`**: A higher precision version of `DateTime`, supporting fractional seconds.
    - [Support Dates and DateTimes outside of 1970-2105 range. · Issue #7316 · ClickHouse/ClickHouse](https://github.com/ClickHouse/ClickHouse/issues/7316)
- **UUID**:
    - **`UUID`**: A special type for storing universally unique identifiers.
- **Array and Nested Types**:
    - **`Array(T)`**: Stores arrays of a given type `T`.
    - **`Tuple(T1, T2, ...)`**: Stores a fixed-size collection of multiple types.
    - **`Nested`**: Supports complex hierarchical data structures similar to JSON-like data.
- **Nullable Types**:
    - **`Nullable(T)`**: Allows a column to store `NULL` values alongside values of type `T`.
- **LowCardinality Types**:
    - **`LowCardinality(T)`**: Optimized for columns with a small set of distinct values. Internally, it stores a dictionary of unique values and references to them, reducing the storage footprint and speeding up certain queries.
- **Decimal Types**:
    - **`Decimal(Precision, Scale)`**: Provides fixed-point arithmetic with user-defined precision and scale, important for financial data.
- **IP Address Types**:
    - **`IPv4`**, **`IPv6`**: Data types designed for storing and processing IP addresses efficiently.
- **JSON Types**:
    - **`JSON`**, **`JSONEachRow`**: Semi-structured data formats to support JSON-like storage and parsing.
