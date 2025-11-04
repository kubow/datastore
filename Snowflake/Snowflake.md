https://www.snowflake.com/en/

Cloud-based data storage and analytics service (data-as-a-service)
[Beyond “Modern” Data Architecture](https://www.snowflake.com/en/blog/beyond-modern-data-architecture/)

- **Core Data Platform:**
    - Data Warehousing
    - Data Lake
    - Data Engineering
    - Data Science
    - Data Application Development
- **Additional Products and Features:**
    - Snowflake Catalog
    - Snowflake Data Masking
    - Time Travel
    - External Tables
    - Data Sharing
    - Snowflake SQL
    - Snowflake Scripting

[Reference | Snowflake Documentation](https://docs.snowflake.com/en/reference)

[Snowflake Snowpark: Overview, Benefits, and How To](https://www.ascend.io/blog/snowflake-snowpark-overview-benefits-and-how-to-harness-its-power/)
### Data Unloading

[Overview of data unloading](https://docs.snowflake.com/en/user-guide/data-unload-overview.html)
[COPY_INTO](https://docs.snowflake.com/en/sql-reference/sql/copy-into-location.html)

Polaris Catalogue
- [Polaris Catalog™ overview | Snowflake Documentation](https://other-docs.snowflake.com/en/polaris/overview)
- [Polaris Catalog: An Open Source Catalog for Apache Iceberg](https://www.snowflake.com/en/blog/introducing-polaris-catalog/)

## Stored Procedures

- [Snowflake 101: Working with Stored Procedures](https://select.dev/posts/snowflake-stored-procedures)
```sql
CREATE OR REPLACE PROCEDURE hello_world(message VARCHAR)
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
AS
BEGIN
   RETURN message; 
END;
```

