
[Prepared for the Future with next-gen SAP ASE | SAP Blogs](https://blogs.sap.com/2020/03/03/prepared-for-the-future-with-next-gen-sap-ase/)

[SAP Sybase ASE “Magic Numbers” and Hardcoded Behaviour | just dave info (wordpress.com)](https://justdaveinfo.wordpress.com/2015/05/19/sap-sybase-ase-magic-numbers-and-hardcoded-behaviour/)

SAP claims to have 10k+ customers onASE with over 600+ apps on ASE in production

# Main features

| Main Features | Improvement areas | Common abbreviations |
| --- | --- | --- |
| <ul><li> Compression </li><li> In-row LOBs </li><li> Data partititoning </li><li> Task scheduler </li><li> Resource configuration limits </li></ul> | <ul><li> Scalability & Performance </li><li> Workload optimization </li><li> Security </li><li> Real-time data distribution </li><li> Cloud ready & flexible deployment </li></ul> | <ul><li> **XOLTP** (Extreme OLTP) </li><li> **IMRS** (In-memory row storage) </li><li> **MVCC** (Multi version concurency control) </li><li> **HCB** (Hash cached B-trees) </li><li> **CCL** (Common crypto library) </li></ul> |





# Layers

- Database > Segment > Device (Physical - Raw Device or Data File)
- Allocation Unit
- Extent
- ASE Page (OS Block for Data Files / Raw Partitions partitioned)

![[ASE_databases.png]]

## **Database objects**

- **Tables** - store data
- **Views** - simplify / restrict access to data
- **Indexes** - improving DB performance during data retrieval
- **Defaults** - supply default values to tables
- **Rules** - restrict type of data that can be inserted into tables
- **Stored procedures / Triggers** - stored batches of SQL statements (help maintain data)


- Allcations
- Cache
- Users