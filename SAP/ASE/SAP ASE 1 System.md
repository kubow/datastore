
[Prepared for the Future with next-gen SAP ASE | SAP Blogs](https://blogs.sap.com/2020/03/03/prepared-for-the-future-with-next-gen-sap-ase/)

[SAP Sybase ASE “Magic Numbers” and Hardcoded Behaviour | just dave info (wordpress.com)](https://justdaveinfo.wordpress.com/2015/05/19/sap-sybase-ase-magic-numbers-and-hardcoded-behaviour/)


# Layers

- Database > Segment > Device (Physical - Raw Device or Data File)
- Allocation Unit
- Extent
- ASE Page (OS Block for Data Files / Raw Partitions special - do not have this concept)

## **Database objects**

- **Tables** - store data
- **Views** - simplify / restrict access to data
- **Indexes** - improving DB performance during data retrieval
- **Defaults** - supply default values to tables
- **Rules** - restrict type of data that can be inserted into tables
- **Stored procedures / Triggers** - stored batches of SQL statements (help maintain data)

- Disk / Device
- Segments
- Allcations
- Cache
- Tables / Views
- Users