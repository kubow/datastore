PaaS serverless data warehouse that enables scalable analysis over petabytes of data.
[BigQuery - Wikipedia](https://en.wikipedia.org/wiki/BigQuery)
[BigQuery: Enterprise Data Warehouse  |  BigQuery: Cloud Data Warehouse  |  Google Cloud](https://cloud.google.com/bigquery)


## System

Main functions:

- **Managing data**
	- Create and delete objects such as tables, views, and user defined functions. 
	- Import data from [Google Storage](https://en.wikipedia.org/wiki/Google_Storage "Google Storage") in formats such as CSV, Parquet, Avro or JSON.
- **Query**
	- Queries are expressed in a standard [SQL dialect](https://cloud.google.com/bigquery/docs/reference/standard-sql/introduction).
	- Results are returned in [JSON](https://en.wikipedia.org/wiki/JSON "JSON") with a maximum reply length of approximately 128 MB, or an unlimited size when [large query results are enabled](https://cloud.google.com/bigquery/quotas#queries).
- **Integration** 
	- BigQuery can be used from [Google Apps Script](https://en.wikipedia.org/wiki/Google_Apps_Script "Google Apps Script")([source](https://developers.google.com/apps-script/advanced/bigquery)) (e.g. as a bound script in [Google Docs](https://en.wikipedia.org/wiki/Google_Docs "Google Docs")), or any language that can work with its [REST API or client libraries](https://cloud.google.com/bigquery/docs/reference/libraries).
- **Access control**
	- Share datasets with arbitrary individuals, groups, or the world.
- **Machine learning**
	- Create and execute machine learning models using SQL queries.
- **Cross-cloud analytics**
	- Analyze data across [Google Cloud](https://en.wikipedia.org/wiki/Google_Cloud "Google Cloud"), [Amazon Web Services](https://en.wikipedia.org/wiki/Amazon_Web_Services "Amazon Web Services"), and [Microsoft Azure](https://en.wikipedia.org/wiki/Microsoft_Azure "Microsoft Azure")(https://en.wikipedia.org/wiki/BigQuery#cite_note-8) (https://en.wikipedia.org/wiki/BigQuery#cite_note-9)
- **Data sharing**
	- Exchange data and analytics assets across organizational boundaries.(https://en.wikipedia.org/wiki/BigQuery#cite_note-10)
- **In-Memory analysis service**
	- [BI Engine](https://cloud.google.com/bigquery/docs/bi-engine-intro) built into BigQuery that enables users to analyze large and complex datasets interactively with sub-second query response time and high concurrency.(https://en.wikipedia.org/wiki/BigQuery#cite_note-11)(https://en.wikipedia.org/wiki/BigQuery#cite_note-12)
-   Business intelligence - Visualize data from BigQuery by importing into [Data Studio](https://datastudio.google.com/), a data visualization tool (https://en.wikipedia.org/wiki/BigQuery#cite_note-13)

Integrations:

-   Data integration: Confluent, [Fivetran](https://en.wikipedia.org/wiki/Fivetran "Fivetran"), [Informatica](https://en.wikipedia.org/wiki/Informatica "Informatica"), [SnapLogic](https://en.wikipedia.org/wiki/SnapLogic "SnapLogic"), [Qlik](https://en.wikipedia.org/wiki/Qlik "Qlik"), [Trifacta](https://en.wikipedia.org/wiki/Trifacta "Trifacta"), Talend, Striim and others
-   BI and data visualization: [Tableau](https://en.wikipedia.org/wiki/Tableau "Tableau"), [Microstrategy](https://en.wikipedia.org/wiki/Microstrategy "Microstrategy"), [ThoughtSpot](https://en.wikipedia.org/wiki/ThoughtSpot "ThoughtSpot"), [SaS](https://en.wikipedia.org/wiki/SaS "SaS") and [Qlik](https://en.wikipedia.org/wiki/Qlik "Qlik")
-   Connectors and developer tools: CData, Progress, Magnitude, KingswaySoft, ZapppySys