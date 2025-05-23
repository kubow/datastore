### Data Warehouse (DW, DWH, EDW)

System used for reporting and data analysis, considered as core component of business intelligence.  DW is central repository of integrated data from one or more disparate sources. Stores data (current and historical) used for analytical reports.

Data Mart = layer of Data Warehouse

- [Data Warehouse Design](Data%20Warehouse%20Design.md)
- Issues with Warehouse approach
    - Latency (delays data retrieval speed)
    - Complex querries (increases processing time)
    - Lack of Real-Time data (stale information hampers insights)
    - Inefficient Data Models (complicates data access and analysis)
    - Limited Scalability (struggles with large data volumes)
    - Outdated Technlogy (hinders perfromace and responsivness)



![[Data_warehouse_overview.jpg]]

![[DW_schema.png]]

Two main approaches creating warehouses:
- **Bill Inmon approach** - star schema mapping, not deployed until concept invented
- **Ralph Kimball approach** - to keep customers happy, deploy warehouses as modules

![[Data_warehouse_Environment.JPG]]


[Everything you need to know about tree data structures | Codementor](https://www.codementor.io/@leandrotk100/everything-you-need-to-know-about-tree-data-structures-pynnlkyud)  
  
[Databases and Performance: Advanced Compression no good for Data Warehousing (databaseperformance.blogspot.com)](https://databaseperformance.blogspot.com/2018/05/advanced-compression-no-good-for-data.html)  
  
[Data Warehouse Design – Inmon versus Kimball – TDAN.com](https://tdan.com/data-warehouse-design-inmon-versus-kimball/20300)  
[Introduction to Slowly Changing Dimensions (SCD) Types - Adatis](https://adatis.co.uk/introduction-to-slowly-changing-dimensions-scd-types/)  
[Data Vault — An Overview. Data Vault — An Overview | by John Ryan | Medium](https://medium.com/@jryan999/data-vault-an-overview-27bed8a1bf9f)  
  
  
time series  
[sql server - Datawarehouse Design: Combined Date Time dimension vs. Separate Day and Time dimensions and timezones - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/8128/datawarehouse-design-combined-date-time-dimension-vs-separate-day-and-time-dim?rq=1)  
[data warehouse - How many date dimensions for one fact - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/137971/how-many-date-dimensions-for-one-fact/137980)  
[database schema - Approach for storing circa and actual dates in genealogy data model - Stack Overflow](https://stackoverflow.com/questions/9850387/approach-for-storing-circa-and-actual-dates-in-genealogy-data-model?rq=1)  
  
  
  
Delimited list in database [https://stackoverflow.com/questions/3653462/is-storing-a-delimited-list-in-a-database-column-really-that-bad?rq=1](https://stackoverflow.com/questions/3653462/is-storing-a-delimited-list-in-a-database-column-really-that-bad?rq=1)  
  
Multilanguage database [https://stackoverflow.com/questions/316780/schema-for-a-multilanguage-database?rq=1](https://stackoverflow.com/questions/316780/schema-for-a-multilanguage-database?rq=1)  
  
Fact table foreign key null [https://dba.stackexchange.com/questions/3512/fact-table-foreign-keys-null](https://dba.stackexchange.com/questions/3512/fact-table-foreign-keys-null)  
  
Index on foreign key [https://dba.stackexchange.com/questions/53809/need-for-indexes-on-foreign-keys?rq=1](https://dba.stackexchange.com/questions/53809/need-for-indexes-on-foreign-keys?rq=1)  
  
SET NULL in foreign key constraint [https://dba.stackexchange.com/questions/5176/what-is-the-purpose-of-set-null-in-delete-update-foreign-keys-constraints/5182#5182](https://dba.stackexchange.com/questions/5176/what-is-the-purpose-of-set-null-in-delete-update-foreign-keys-constraints/5182#5182)  
  
Storing vs calculating aggregate values [https://dba.stackexchange.com/questions/239/storing-vs-calculating-aggregate-values](https://dba.stackexchange.com/questions/239/storing-vs-calculating-aggregate-values)  
  
Codementor: Everything you need to know about tree data structures [https://www.codementor.io/leandrotk100/everything-you-need-to-know-about-tree-data-structures-pynnlkyud](https://www.codementor.io/leandrotk100/everything-you-need-to-know-about-tree-data-structures-pynnlkyud)



