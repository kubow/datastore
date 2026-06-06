# General repository about data related technologies

## Covered [data storing](Data/Concepts.md) concepts

- Higher architecture and concepts
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

| Data Storing Engines                                             | Specific Data Tools                                                                                                                           |
| ---------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [Amazon Web Services](Amazon/AWS.md) #platform                   | **Data Discovery**                                                                                                                            |
| [Amazon Athena](Amazon/AWS%20Athena.md) #query                   | [AWS Glue](Amazon/AWS%20Glue.md) (data integration and catalog)                                                                               |
| [DynamoDB](Amazon/AWS%20DynamoDB.md) #storage #nosql             |                                                                                                                                               |
| [Airbyte](Airbyte/Airbyte.md) #integration                       | [Fivetran](Fivetran/Fivetran.md) (managed data movement)                                                                                      |
| [Apache](Apache/Apache.md) (multiple products)                   | [SchemaCrawler](https://www.schemacrawler.com/) (DB schema discovery & comprehension tool - [github](http://sualeh.github.io/SchemaCrawler/)) |
| [Apache Beam](Apache/Apache%20Beam.md) #processing               | [Apache NiFi](Apache/Apache%20NiFi.md) (dataflow automation)                                                                                  |
| [Apache Doris](Apache/Apache%20Doris.md) #storage #olap          |                                                                                                                                               |
| [Apache Flink](Apache/Apache%20Flink.md) #processing #streaming  |                                                                                                                                               |
| [Apache HBase](Apache/Apache%20HBase.md) #storage #nosql         |                                                                                                                                               |
| [Apache Hudi](Apache/Apache%20Hudi.md) #format                   |                                                                                                                                               |
| [Apache Kudu](Apache/Apache%20Kudu.md) #storage #olap            |                                                                                                                                               |
| [Apache Pinot](Apache/Apache%20Pinot.md) #storage #olap          |                                                                                                                                               |
| [Apache Solr](Apache/Apache%20Solr.md) #search                   |                                                                                                                                               |
| [AutoMQ](AutoMQ.md) #streaming                                   | [SodaSQL](https://github.com/sodadata/soda-sql) (data testing and monitoring - [documentation](https://docs.soda.io/))                        |
| [ClickHouse](ClickHouse/ClickHouse.md) #storage                  |                                                                                                                                               |
| [CockroachDB](CockroachDB/CockroachDB.md) #storage               | **Data Processing**                                                                                                                           |
| [Cosmos DB](MS/MS%20Azure%20Cosmos%20DB.md) #storage #nosql      | [Azure Data Factory](MS/MS%20Azure%20Data%20Factory.md) (data integration)                                                                    |
| [Couchbase](Couchbase/Couchbase.md) #storage #nosql              |                                                                                                                                               |
| [CrateDB](CrateDB/CrateDB.md) #storage                           | [Apache Airflow](./Apache/Apache%20Airflow.md) (orchestration)                                                                                |
| [Databricks](Databricks/Databricks.md) #storage #platform        | [Talend DataCleaner](https://sourceforge.net/projects/datacleaner/) (Profiling & Cleansing)                                                   |
| [DataWatch](DataWatch.md) #storage                               | [OpenRefine](Google/OpenRefine.md)                                                                                                            |
| [Debezium](./Debezium.md)                                        | [Meltano](meltano.md) (data extracting)                                                                                                       |
| [Delta Lake](DeltaLake/Delta%20Lake.md) #format                  | [Prefect](Prefect/Prefect.md) (workflow orchestration)                                                                                        |
| [DuckDB](./Duck/DuckDB.md) #storage #embed                       | [dbt](dbt.md) (data transformation)                                                                                                           |
| [Elasticsearch](Elasticsearch/Elasticsearch.md) #storage #search | [dlt](dlt.md)                                                                                                                                 |
| [Exasol](Exasol/Exasol.md) #storage #olap                        |                                                                                                                                               |
| [Firestore](Google/Google%20Firestore.md) #storage #document     | [Google Dataflow](Google/Google%20Dataflow.md) (stream and batch processing)                                                                  |
| [Google](Google/Google.md) #platform                             | [Estuary](./Estuary.md)                                                                                                                       |
| [IBM](IBM/IBM.md) #platform                                      | [Kestra](Kestra/kestra.md)                                                                                                                    |
| [InfluxDB](InfluxDB/InfluxDB.md) #storage                        | [Mage.AI](Mage.AI/Mage.AI.md)                                                                                                                 |
| [JSON](JSON/JSON.md) (*standalone / JSON native db*)             | [y42](y42.md)                                                                                                                                 |
| [MariaDB](MariaDB/MariaDB.md) #storage                           |                                                                                                                                               |
| [MarkLogic](MarkLogic/MarkLogic.md) #storage #nosql              |                                                                                                                                               |
| [Milvus](Milvus/Milvus.md) #storage #vector                      | [Qdrant](Qdrant/Qdrant.md) #storage #vector                                                                                                   |
| [MongoDB](MongoDB/MongoDB.md) #storage #oltp                     | **Data Analysis & Reporting** ([full list](Data/Visualize/Visualization.md))                                                                  |
| [Microstrategy](Microstrategy/Microstrategy.md)                  | [GoodData](GoodData/GoodData.md) #platform #analytics                                                                                         |
| [Microsoft](MS/Microsoft.md) #platform                           | [Incorta](Incorta/Incorta.md) #platform #analytics                                                                                            |
| [Minio](Minio/Minio.md)                                          | [PowerBI](MS/PowerBI/PowerBI.md) #platform #analytics                                                                                         |
| [Neo4J](Neo4J/Neo4J.md) #storage #graph                          | [Qlik](Qlik/Qlik.md) #platform #analytics                                                                                                     |
| [OpenSearch](OpenSearch/OpenSearch.md) #search                   |                                                                                                                                               |
| [Oracle](Oracle/Oracle.md) #platform                             | [SAS/STAT](https://www.sas.com/en_us/software/stat.html)                                                                                      |
| [Pentaho](Pentaho/Pentaho.md) #etl                               |                                                                                                                                               |
| [PostgreSQL](PostgreSQL/PostgreSQL.md) #storage                  |                                                                                                                                               |
| [Prometheus](Prometheus/Prometheus.md) #storage #timeseries      |                                                                                                                                               |
| [QuestDB](QuestDB/QuestDB.md) #storage #timeseries               |                                                                                                                                               |
| [Redis](REDIS/Redis.md) #storage                                 |                                                                                                                                               |
| [RelationalAI](./RelationalAI/RelationalAI.md)                   |                                                                                                                                               |
| [Salesforce](Salesforce/SFDC.md)                                 |                                                                                                                                               |
| [SAP](SAP/SAP.md) #platform                                      | **Data Monitoring**                                                                                                                           |
| [ScyllaDB](ScyllaDB/ScyllaDB.md) #storage #nosql                 |                                                                                                                                               |
| [SingleStore](SingleStore/SingleStore.md) #storage               |                                                                                                                                               |
| [Snowflake](Snowflake/Snowflake.md) #storage                     | HP OpenView (Rep Agent compatible)                                                                                                            |
| [StarRocks](StarRocks/StarRocks.md) #storage #olap               |                                                                                                                                               |
| [SQLite](SQLite/SQLite.md) #storage #embed                       | [IBM Tivoli](IBM/Tivoli.md)                                                                                                                   |
| [Teradata](Teradata/Teradata.md) #storage                        | Ignite                                                                                                                                        |
| [TigerBeetle](TigerBeetle.md)                                    |                                                                                                                                               |
| [TimescaleDB](TimescaleDB/TimescaleDB.md) #storage #timeseries   |                                                                                                                                               |
| [Trino](Trino/Trino.md) #query                                   | [Temporal](Temporal/Temporal.md) (durable workflow engine)                                                                                    |
| [TDEngine](TDEngine/TDEngine.md)                                 | BMC                                                                                                                                           |
| [Vertica](Vertica/Vertica.md)                                    | Bradmark [http://www.bradmark.com/](http://www.bradmark.com/)                                                                                 |
| [Weaviate](Weaviate/Weaviate.md) #storage #vector                |                                                                                                                                               |
| [XML](XML/XML.md) (*standalone / XML native db*)                 |                                                                                                                                               |

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


### Engines overview database description (sqlite3 database source) ###

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

[Embedded databases (1): The harmony of DuckDB, KùzuDB and LanceDB | The Data Quarry](https://thedataquarry.com/posts/embedded-db-1/)
[Embedded databases (2): KùzuDB, an extremely fast OLAP graph database | The Data Quarry](https://thedataquarry.com/posts/embedded-db-2/)


## Books

[Principles of Database Management: The Practical Guide to Storing, Managing and Analyzing Big and Small Data](https://www.amazon.com/Principles-Database-Management-Practical-Analyzing/dp/1107186129/)
[Database in Depth: Relational Theory for Practitioners](https://www.amazon.com/Database-Depth-Relational-Theory-Practitioners/dp/0596100124)
[What is High Availability? The Ultimate Guide | Percona](https://www.percona.com/blog/the-ultimate-guide-to-database-high-availability/)

[Seven Databases in Seven Weeks](https://www.oreilly.com/library/view/seven-databases-in/9781680505962/)
[Segmentation Fault - A DBA Perspective](https://www.percona.com/blog/segmentation-fault-a-dba-perspective/)

## Free sources

[Index of /~database/documents @ University of Oklahoma](https://www.cs.ou.edu/~database/documents/)


[UI bakery sample databases](https://uibakery.io/sql-playground)
[Datasets - Data | World Resources Institute](https://datasets.wri.org/dataset)
[GitHub - jOOQ/sakila: The Sakila Database](https://github.com/jOOQ/sakila/search?l=tsql)

[Datové sady - Národní katalog otevřených dat (NKOD)](https://data.gov.cz/datov%C3%A9-sady)
[The MONDIAL Database](https://www.dbis.informatik.uni-goettingen.de/Mondial/)


## Web sites

[Knowledge Base of Relational and NoSQL DBMS](https://db-engines.com/en/)
