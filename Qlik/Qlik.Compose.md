Data Pipeline Automator 

- PostrgreSQL database running inside.
- Easy to setup, real business value that setup will happen in very short time
- Still need to do some modelling
- Need to have a source system with a [[Qlik.Replicate]]
- Work organized in projects (versioned with GIT repository).

1. Create database that will be a warehouse (a lot of importers)
    - Can be Microsoft SQL Server, Snowflake, Amamazon Redshift, Google Big Query, Oracle Cloud
    - World-wide importers, sanboxed
2. Define a Model (Entities, Relationships and Attributes - Domains)
    - Either Physical or Logical - but preferably business model - closest to conceptual data model
    - Import from ERWin ([erwin Data Modeler - Wikipedia](https://en.wikipedia.org/wiki/Erwin_Data_Modeler))
    - Run discover on full load source
3. Data Warehouse generation
    - it is always a pair - generate for one source one mapping
    - auto-generated and predefined is a big advantage
    - Data quality options (validation and cleansing - basic)
    - imports can have ETL sets applied (select update insert) [ELT in some cases]
    - Do not expect higher level optimizations
4. Data Mart generation
    - excerpt from warehouse, define star schemas and dimensions

**Data Sources** must be:

- acted
- analyzed
- aggregated
- cataloged
- captured
- cleaned
- combined
- formatted
- governed
- identified
- moved
- profiled
- queried
- secured
- tagged
- transformed
- validated
- visualized

**DevOps** - methodology based on building, testing and releasing for technology, people and processes

**DataOps** - methodology based for technology, peopole and processes to generate, deliver and refine analytic output

- Change Data Capture (CDC)
- Data Preparation
- Data Integration (both structured & unstructured)
- Data Analytics

Processes:

- Continous Integration (integrate new data sources and data pipelines into existing data architecture)
- Continous Deployment (merges new data amd code into the data pipeline)
- Orchestration (instantiate data tools that automate pipeline - job triggers, alerts, notifications, profiling, validation...)
- Continous Testing (asks key questions related to data integrity)

People:

- Data architect (responsible for building the overall data blueprint -design, deploy and manage data in a framework)
- Data engineer (integrates, aggregates and curates data sets - get data prepared for production by transforms)
- Data scientist (experiments, builds and publish data models for advanced analyses - help business interpret data)
- Data analyst (queries, interprets and turns data into insights)
- Business user (stakeholders and data consumers that review the analyses presented - create reports, dashboards and visualizations)