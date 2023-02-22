Fact tables contain data that describes specific events within a business, such as bank transactions or product sales . There are basically two ways transaction-based fact table records are sourced, plus another way for non-transaction counts.  

Types of Fact tables:

- **Transaction table:** This is the transactions as it happens on the source. Each transaction and its measure such as price is extracted, transformed and loaded to facts at regular intervals of time. Ideally, if there are 100 transactions happened on a given day on the source and if fact is designed at the same level of granularity, in transaction fact table you would see 100 records added once ETL process finishes loading.  
- **Snapshot table:** This is not exactly a transaction on the source. It is generally to get the snapshot of the system. Example: Getting all customer account balance as of end of the day. Even when there is no transaction on any particular account, the snapshot fact table would gather all the current account balance information and keep it in the fact table to exactly know what the account balance of a given account is on a given date.  
- **Factless Fact:** This fact generally is not sourced from an OLTP transaction. Occasionally you need only to capture whether an event happened. Example: You might want to capture employee attendance, you only need to know which employees came to work and which employees were absent. Absent employees will not come from attendance sheet. This is prepared separately with the help of employee table and attended employees to load into factless fact. Factless facts, as the name says, will not have any measures. Factless facts are often used with counts, and particularly distinct counts. For example, how many distinct employees worked during a given week.  
  
**Ideal fact measures are additive in nature but it is not a requirement that a fact table have numeric measures**. For example, consider list of computers added and deleted from an environment. The fact table may capture the computers that are added and deleted. There is no measure here but count of computers becomes the measure. There is no measure stored in the fact table for this kind of transaction..  
  

## Identifying Facts and Measures

  
- Attributes of fact table are in general containing surrogate keys of the respective dimension tables
- The OLTP transactions or OLTP snapshot, are the source of fact records and would decide what business keys would make up to OLTP transaction. During the load process, these business keys are mapped to the business key of the respective dimensions to extract the corresponding surrogate keys.
- Numeric values that resulted from an OLTP transaction typically end up as measures in the fact table. One fact table can have more than one measure, including custom calculated measures based on measures derived from the OLTP system..
- Calculated measures that include only values from a single row may be pre computed during the load process and stored in the fact table, or they may be computed on the fly as they are used. Determination of which measures should be pre computed is a design consideration. There are other considerations in addition to the usual tradeoff between storage space and computational time.  
	- All the facts have a specific granularity  
	- A set of foreign keys constitutes a logical concatenated key 
	- The fact table typically contains the largest volume of data
- The needs of the analyst must be supported by the facts in the fact table, there must be measures which have relevance to the business goals which the organization seeks to fulfill  
· FACTS are measurable  
· Facts are by nature dynamic and variable over time  
· Fact tables have an unlimited number of rows—as opposed to dimension tables, which have a finite cardinality, even if very large.  
· Fact data represents the measurable results of a business event, or a business state and Dimensional data provides the context for that event or state.  
· Fact events vary depending on the business  
· It is important to understand the basic business process and identify the business events and states when developing a dimensional data warehouse.  
· Fact tables should not contain descriptive information or any data other than the numerical measurement fields and the foreign key pointers to the corresponding entries in the dimension tables.  
· **Identifying Measures**. The most useful measures to include in a fact table are numbers that are additive.  
o **Additive measures.** allow summary information to be obtained by adding various quantities of the measure, such as the sales of a specific item at a group of stores for a particular time period.  
o **Semi-additive measure**: Is additive across all dimensions except time. The classic example of a semi-additive fact is a daily account balance. It's perfectly legitimate to add the balances of every account on a specific day—the fact is additive across the Account dimension—but the end-of-month balance of my savings account is not the sum of the balances for the past month—the fact is non-additive across time. When aggregating across time you need a special function such as the last non-empty value, or the first non-empty value, or the average. if you include semi-additive facts in a dimensional database, you should ideally use a front end tool that manage the appropriate semi-additive aggregation. At the very least, the front end tool should warn users if they attempt to summarize across a semi-additive dimension.  
o **Non-additive measures**: Non additive measures are those which cannot be summarized like additive/semi additive measures. In general, you want to convert non-additive measure to additive measures. You can often do that by adding a weighting factor. For example, rather than store a rate, you can multiply the rate by a weight. After summing the weighted rate and also the weights, you can easily calculate a weighted average rate for any level of summarization.  
  
Each fact table also includes a multipart index that contains as foreign keys the primary keys of related dimension tables, which contain the attributes that describe the fact records.  
  

## Granularity

  
Granularity is defined as the lowest level of detail of the data in the fact tables particularly the measures. The more granular the data, the more detailed your reports and analysis can be. However, excess granularity consumes space and increases complexity. It is a trade off because once you aggregate a fact table, you cannot decompose the aggregates.  
  
There are three types of grain: Transaction, Periodic Snapshots and Accumulating Snapshots.  

- **Transactions** - This is the basic detail record of the warehouse as it happened in the OLTP systems. Example: Customer purchases a book or money transfer from savings to checking. The Time grain of a transaction is essentially continuous.  
- **Periodic Snapshots** - This is a set of detail records that are repeated over time. It is to get number of customers existing, inventory of the system etc., at the end of the day. The grain of a snapshot is the interval at which the snapshot is taken—whether hourly, daily, weekly, monthly, or yearly.  
- **Accumulating Snapshot** - This is a snapshot that can change over time. The common example is the student enrollment example. The student's data doesn't change but the dates for enrollment, admission, etc.  
  

## Fact tables Guidelines

  
Consider the following guidelines when designing your Fact tables:  
  

### Aggregating Data in Fact Tables

  
Data is generally aggregated to store the summarized information over a period of time of the fact measures such as the number of units of a product sold in a given month. The source for these aggregations is the detailed granular fact which collects transactional information from source at regular intervals of time. In some data warehouses, the aggregation is performed directly by the ETL process to move it into an aggregated fact table where the detailed transactional records do not have any value for the report users. For example, executives may not need to see the number of units sold at 6th hour of a day. Consider the following guidelines when designing your Fact tables that contain aggregate data:  
· Aggregating data in the fact table should only be done after considering the consequences. Aggregation is the process of calculating summary data from detail records. It is often tempting to reduce the size of fact tables by aggregating data into summary records when the fact table is created. Detailed information is no longer directly available to the analyst. If detailed information is needed, the detail rows that were summarized will have to be identified and located, possibly in the source system that provided the data. Fact table data should be maintained at the finest granularity feasible.  
· Avoid aggregation in warehouse tables if you will use an OLAP cube as the source for reports and analysis. In this case, the cube provides the aggregation functionality, but if you need to get to details it still available in the fact table.  
· If the reports query the underlying relational structure then aggregation will make queries faster  
· It would make sense to archive only aggregated information rather than all the warehouse records.  
· To enhance relational queries, you may want to store the summary records in separate tables  
· Mixing aggregated and detailed data in the fact table can cause issues and complications when using the data warehouse. For example, a sales order often contains several line items and may contain a discount, tax, or shipping cost that is applied to the order total instead of individual line items, yet the quantities and item identification are recorded at the line item level. Summarization queries become more complex in this situation.  
  

### Determine if a source numeric field is to be measure or an attribute

  
Sometimes during the design process, it is unclear whether a numeric data field from a production data source is a measured fact or an attribute. Generally, if the numeric data field is a measurement that changes each time we sample it, it is a fact. If it is a discretely valued description of something that is more or less constant, it is a dimension attribute. One way of making the distinction is whether it is a value you would want to use as a grouping item for a report. If it is, then it is an attribute. Often, an aggregatable measure also appears as an attribute by bucketing the values. For example, order quantity is typically a measure, but Order Size (i.e., Order Quantity bucketed into 5 discrete buckets) is an attribute.  
Storage is cheap and time is expensive:  
This is true in most of the data warehouse processes. This means that you should store measures needed for reports as part of the fact measures. Ideally, all the measures would directly be coming from source transactions but any calculations on these measures can be computed and stored in another measure attribute of the fact. This reduces the report query time as there is no more computation involved. If reports directly query relational tables, create aggregation tables with pre-computed totals to enable reports to query at different grains with no computation during the reporting query.  
Retain all measures coming from source in your fact  
Have the original details of the measurements which are used for calculating the additive/non additive fields, can be used for later aggregations. Example:  
If you keep all the measurements that are available from source in the fact table, any possible custom measurements later on the fact table can be done without changing the design of the fact table. This ensures if one calculation is feasible to extract from source system then the warehouse system provides the same feasibility.  
  

### If the granularity of two facts tables is the same, consider combining them

  
As a general rule when you start your dimensional modeling each business function should have its own fact table. As your dimensional model evolves try combining the fact tables where the granularity is the same between the fact tables. Combing the facts makes analysis easier and eliminates the need for unnecessary joins.  
  
Use indexed views to improve the performance of relational queries  
The performance of queries against the relational data warehouse can be significantly improved when you use indexed views. Indexed view is a pre-computed table comprising aggregated or joined data from fact and possibly dimension tables. A indexed view is one way of implementing particularly when the requested data set is summary values that were not pre computed or aggregated  
  

### Fact table Index Guidelines

  
· Consider having a composite primary key for your Fact table. Consider composite key (typically composite of all related dimension surrogate keys) as the primary key for Fact tables. Conversely, you can add an Identity column as a primary key in the fact table.  
· Some dimensional modeling will have business keys also being part of facts for enabling report performance. These business keys do not need to be part of the composite key of the fact as their corresponding dimension SKs are declared in composite key. There can be non clustered index to cover these business keys for better reports performance.  
· Business keys which are used by ad hoc queries should be part of non clustered index. Non-clustered indexes will the increase efficiency and responsiveness of ad-hoc queries. In the absence non key attributes covered by an index, would result in a clustered index scan (provided clustered index is created & available) which is expensive  
  
Ensure fact table measures have relevance to the business goals  
Though it is possible to create multiple measurements from the source measures, the fact measures should represent business requirement. Create only those measures that are required for the reports/analytic needs of the business users.  
Ex: If Percentage sold is not a requirement for business people, do not create this as a measurement just because it is possible to create from the available data  
  
It is suggested to try creating additive measures and avoid having non additive measures in the fact tables.  
  
Determine when and where calculated measures are pre-computed.  
Calculated measures are those measures which are not directly available from source but computed from the measures coming from source.  
Example: Number Sold is the source measure. Percentage of the items sold per city is the measure calculated based on number of items sold in the city to the total items old in the given day.  
Calculated measures can be created in the facts while loading enabling the reports which query the relational data warehouse table directly.