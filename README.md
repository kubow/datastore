# General repository about data related technologies

## Covered [[Data Concepts|data storing]] concepts

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
| <ul> <li>[[AWS]]</li> <li> [[Apache]]</li> <li> [[ClickHouse]]</li> <li> [[CockroachDB]]</li> <li> [[DataWatch]]</li> <li> [[dbt]]</li> <li> [[Elasticsearch]]</li> <li> [[GoodData]]</li> <li> [[Google]]</li> <li> [[IBM]]</li> <li> [[Incorta]]</li> <li> [[JSON]] (*standalone / JSON native db*)</li> <li> [[MariaDB]]</li> <li> [[MongoDB]]</li> <li> [[Microsoft]] </li> <li> [[MySQL]]</li> <li> [[Oracle]] </li> <li> [[Pentaho]]</li> <li> [[PSQL]]</li> <li> [[Redis]]</li> <li> [[Qlik]]</li> <li> [[SAP]] </li> <li> [[Snowflake]]</li> <li> [[SQLite]]</li> <li> [[Teradata]]</li> <li> [[Vertica]]</li> <li> [[XML]] (*standalone / XML native db*)</li></ul> | <ul><li>Data Discovery</li><ul><li>[SchemaCrawler](https://www.schemacrawler.com/) (DB schema discovery & comprehension tool - [github](http://sualeh.github.io/SchemaCrawler/))</li> <li>[SodaSQL](https://github.com/sodadata/soda-sql) (data testing and monitoring - [documentation](https://docs.soda.io/))</li></ul><li>Data Cleaning</li><ul><li>Talend DataCleaner (Profiling & Cleansing) [https://sourceforge.net/projects/datacleaner/](https://sourceforge.net/projects/datacleaner/)</li> <li>[[OpenRefine]]</li></ul><li>Data Monitoring</li><ul><li>HP OpenView (Rep Agent compatible)</li> <li>IBM Tivoli</li> <li>Ignite</li> <li>BMC</li> <li>Bradmark [http://www.bradmark.com/](http://www.bradmark.com/)</li></ul><li>Reporting & Visualizaion</li><ul><li>Microsoft reporting services</li> <li>IBM Cognos  </li> <li>ADASTRA  </li> <li>ERP  </li> <li>XL Cube</li></ul></ul> |


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

[Seven Databases in Seven Weeks](https://www.oreilly.com/library/view/seven-databases-in/9781680505962/)



## Web sites

[Knowledge Base of Relational and NoSQL DBMS](https://db-engines.com/en/)
