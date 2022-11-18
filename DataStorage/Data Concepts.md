- [[Data Warehouse]]
- [[DataStorage Comparison]]


## Data Architecture
![DataArchitecture](DataArchitecture.png)
## Data Process
![DataProcess](DataProcessStore.jpg)


## Data Cardinality (czech transl. "Mohutnost dat")

| left | right | relation name  | example|
|------|-------|----------------|---------|
| 1 | 1 | one-to-one | person ←→ id card|
| 0..1 | 1 | optional on one side one-to-one | driving license id ←→ person|
| 0..* or * | 0..* or * | optional on both sides many-to-many | person ←→ book|
| 1..* | 1 | many-to-one | person ←→ birth place |

## SQL Structure
- DDL (Data Definition Language) [Wiki](https://en.wikipedia.org/wiki/Data_definition_language)
    - create
    - drop
    - alter
    - rename
- DML (Data Manipulation Language) [Wiki](https://en.wikipedia.org/wiki/Data_manipulation_language)
    - insert ( *insert into table_name (col1, col2) values ("str_val", int_val)* )
    - update ( *update table_name set col1 = "new_value" where id = 1* )
    - delete ( *delete form table_name* )
    - select ( *select col1, col2 form table_name* )
- DCL (Data Control language Language) [Wiki](http://github.com)
    - grant
    - revoke



## Time Series

Processing time series data: What are the options? [https://www.zdnet.com/article/processing-time-series-data-what-are-the-options/#ftag=RSSbaffb68](https://www.zdnet.com/article/processing-time-series-data-what-are-the-options/#ftag=RSSbaffb68)  
  
Time Series Analysis and forecasting - Tutorial [http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:746271](http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:746271)  
  
Time-series data mining & applications [http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:724697](http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:724697)  
  
Dataquest: Data Retrieval and Cleaning: Tracking Migratory Patterns [https://www.dataquest.io/blog/data-retrieval-and-cleaning/](https://www.dataquest.io/blog/data-retrieval-and-cleaning/)