# General repository about data related technologies

## Covered [data storing](Data/Concepts.md) concepts

- Higher architecture and cocepts
- SQL
	- Relational DB (OLTP)
	- Analytical DB (OLAP)
- NoSQL 
	- Key-Value DB
	- Graph DB
	- Document DB
- On-Premise / Cloud / Hybrid
  
## Covered data engines \*

\* Following product types are included:
- **Data storage engine** referred here as a [Database engine (wikipedia.org)](https://en.wikipedia.org/wiki/Database_engine) (interchangeable with terms "Database server" or "DBMS")
	- **Column-oriented** https://en.wikipedia.org/wiki/List_of_column-oriented_DBMSes
	- **ERP** as part of data storage engines https://en.wikipedia.org/wiki/Category:ERP_software
- [Business Intelligence software (wikipedia.org)](https://en.wikipedia.org/wiki/Business_intelligence_software) referred here as a **BI Tool** (retrieve, analyze, transform and report data)

---

| Data Storing Engines |   Specific Data Tools |
| --- |  --- | 
| [Amazon stores](Amazon/AWS.md) | **Data Discovery** |
| [Apache](Apache/Apache.md) | - [SchemaCrawler](https://www.schemacrawler.com/) (DB schema discovery & comprehension tool - [github](http://sualeh.github.io/SchemaCrawler/)) |
| [ClickHouse](ClickHouse/ClickHouse.md) | - [SodaSQL](https://github.com/sodadata/soda-sql) (data testing and monitoring - [documentation](https://docs.soda.io/)) |
| [CockroachDB](CockroachDB.md) | **Data Cleaning** |
| [CrateDB](CrateDB/CrateDB.md) | - Talend DataCleaner (Profiling & Cleansing) [https://sourceforge.net/projects/datacleaner/](https://sourceforge.net/projects/datacleaner/) |
| [DataWatch](DataWatch.md) | - [OpenRefine](Google/OpenRefine.md)|
|  | **Data Monitoring** |
| [DuckDB](DuckDB.md) ||
| [Elasticsearch](Elacsticsearch/Elasticsearch.md)| - HP OpenView (Rep Agent compatible) |
| [GoodData](GoodData/GoodData.md) | - [IBM Tivoli](IBM/Tivoli.md) |
| [Google](Google/Google.md) | - Ignite|
| [IBM](IBM/IBM.md) | - BMC|
| [Incorta](Incorta/Incorta.md) | - Bradmark [http://www.bradmark.com/](http://www.bradmark.com/) |
| [InfluxDB](InfluxDB.md) | - [dbt](dbt.md) |
| [JSON](JSON/JSON.md) (*standalone / JSON native db*)| **Reporting & Visualizaion** |
| [MongoDB](MongoDB/MongoDB.md) | - Microsoft reporting services|
| [Microsoft](MS/Microsoft.md) | - [IBM Cognos](IBM/Cognos.md)|
| [Oracle](Oracle/Oracle.md)| - ADASTRA |
| [Pentaho](Pentaho/Pentaho.md) | - ERP |
| [PostgreSQL](PostgreSQL/PostgreSQL)| - XL Cube|
| [Qlik](Qlik/Qlik.md) ||
| [Redis](REDIS/Redis.md) ||
| [Salesforce](Salesforce/SFDC.md)||
| [SAP](SAP/SAP.md) ||
| [Snowflake](Snowflake/Snowflake.md) ||
| [SQLite](SQLite/SQLite.md)||
| [Teradata](Teradata/Teradata.md)||
| [Vertica](Vertica/Vertica.md)||
| [XML](XML/XML.md) (*standalone / XML native db*)||

****
Universal Data Clients

- Data Grip
- DBeaver
- SquirelSQL

Universal Database tweakers

- [goranschwarz/DbxTune](https://github.com/goranschwarz/DbxTune)

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ2FudHRcbiAgICB0aXRsZSBIaXN0b3JpY2FsIG92ZXJ2aWV3IChTaW5jZSAyMDAwKVxuICAgIGRhdGVGb3JtYXQgIFlZWVktTU1cbiAgICBzZWN0aW9uIEFwYWNoZVxuICAgIEFwYWNoZSBQYXJxdWV0ICAgICAgICAgICA6YTEsIDIwMTYtMDEsIDIwMDBkXG4gICAgQXBhY2hlIC4uIEZ1dHVyZSAgICAgOmFmdGVyIGExICAsIDIwZFxuICAgIHNlY3Rpb24gSlNPTlxuICAgIFN0YW5kYXJ0aXplZCBpbiAyMDEzICAgICAgOjIwMDAtMDEgLCA3NzAwZFxuICAgIHNlY3Rpb24gTWljcm9zb2Z0XG4gICAgT2ZmaWNlIChNb3N0bHkgQWNjZXNzIGFuZCBFeGNlbCkgICAgICA6MjAwMC0wMSwgNzcwMGRcbiAgICBTUUwgU2VydmVyICAgICAgOjIwMDAtMDEsIDc3MDBkXG4gICAgc2VjdGlvbiBNeVNRTFxuICAgIE15U1FMICAgIDoyMDEyLTAxLCAzMzEwZFxuICAgIHNlY3Rpb24gT3JhY2xlXG4gICAgT3JjYWxlICAgOjIwMDAtMDEgLCA3NzAwZFxuICAgIFxuXG4gICAgICAgICAgICAiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ2FudHRcbiAgICB0aXRsZSBIaXN0b3JpY2FsIG92ZXJ2aWV3IChTaW5jZSAyMDAwKVxuICAgIGRhdGVGb3JtYXQgIFlZWVktTU1cbiAgICBzZWN0aW9uIEFwYWNoZVxuICAgIEFwYWNoZSBQYXJxdWV0ICAgICAgICAgICA6YTEsIDIwMTYtMDEsIDIwMDBkXG4gICAgQXBhY2hlIC4uIEZ1dHVyZSAgICAgOmFmdGVyIGExICAsIDIwZFxuICAgIHNlY3Rpb24gSlNPTlxuICAgIFN0YW5kYXJ0aXplZCBpbiAyMDEzICAgICAgOjIwMDAtMDEgLCA3NzAwZFxuICAgIHNlY3Rpb24gTWljcm9zb2Z0XG4gICAgT2ZmaWNlIChNb3N0bHkgQWNjZXNzIGFuZCBFeGNlbCkgICAgICA6MjAwMC0wMSwgNzcwMGRcbiAgICBTUUwgU2VydmVyICAgICAgOjIwMDAtMDEsIDc3MDBkXG4gICAgc2VjdGlvbiBNeVNRTFxuICAgIE15U1FMICAgIDoyMDEyLTAxLCAzMzEwZFxuICAgIHNlY3Rpb24gT3JhY2xlXG4gICAgT3JjYWxlICAgOjIwMDAtMDEgLCA3NzAwZFxuICAgIFxuXG4gICAgICAgICAgICAiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

### Model structure for any product ###

- **System**
	- Architecture
	- Product fundamentals
- **Install**
	- Preparation, installation
	- Editions
	- Licensing
	- Versions
	- Upgrading
- **Maintenance**
	- Operational Management 
	- Monitoring
	- Security
	- Backup / Recovery


### Engines overview database description (sqlite3) ###

view "engine_overview" with columns for
- engine name
- developer (language used + website)
- engine category (and storage type)
	- basic categories (SQL, NoSQL, graph, key-value, document, time series)
	- storage types (trasnactional, analytical, integration, data warehousing)
- supported operating systems (win, unix, linux, mac)
- security rating
- deployment model
- sourcing model (open-source?, free version available?)


# Useful resources

## Books

[Principles of Database Management: The Practical Guide to Storing, Managing and Analyzing Big and Small Data](https://www.amazon.com/Principles-Database-Management-Practical-Analyzing/dp/1107186129/)
[Database in Depth: Relational Theory for Practitioners](https://www.amazon.com/Database-Depth-Relational-Theory-Practitioners/dp/0596100124)
[What is High Availability? The Ultimate Guide | Percona](https://www.percona.com/blog/the-ultimate-guide-to-database-high-availability/)

[Seven Databases in Seven Weeks](https://www.oreilly.com/library/view/seven-databases-in/9781680505962/)
[Segmentation Fault - A DBA Perspective](https://www.percona.com/blog/segmentation-fault-a-dba-perspective/)

## Free sources


[UI bakery sample databases](https://uibakery.io/sql-playground)
[Datasets - Data | World Resources Institute](https://datasets.wri.org/dataset)
[GitHub - jOOQ/sakila: The Sakila Database](https://github.com/jOOQ/sakila/search?l=tsql)

[Datové sady - Národní katalog otevřených dat (NKOD)](https://data.gov.cz/datov%C3%A9-sady)


## Web sites

[Knowledge Base of Relational and NoSQL DBMS](https://db-engines.com/en/)
