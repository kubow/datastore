Analytic solution focused on embedding and serving to multiple groups of consumers.
Flexible Deployment
- who is hosting GD itself?
- where does the data live?

[Headless BI x Data Lakehouse | GoodData](https://www.gooddata.com/blog/headless-bi-data-lakehouse/)
[Headless BI: Achieve Consistent Analytics Results | GoodData](https://www.gooddata.com/blog/headless-bi-achieve-consistent-analytics-results/)

[What Is Multitenancy? | GoodData](https://www.gooddata.com/blog/what-multitenancy/)

# System 

- [GoodData Platform](GD.Platform.md) (codename BEAR)
	- own / hosted data storage
- [GoodData Cloud(Native)](GD.Cloud(Native).md) (codename TIGER)
	- no data storage
	- above data layer
- GD Cloud (codename PANTER)
	- hosted in the cloud
	- tiger-as-a-service

### Architecture

- Home UI
- Workspaces
- LDM
- Metric Editor
- Analytical Designer (AD)
- KPI Dashboards (KD)

## General processing

1. **Data**
	- Connect to data sources ([DataSources](GD.DataSources.md))
	- Create a [Workspace](GD.Workspaces.md)
	- Build [LDM](GD.LDM.md) (Semantic layer) 1 workspace = 1 LDM (abstract physical data structure)
		- [Mapping Data Sources](https://community.gooddata.com/data-sources-kb-articles-47/mapping-your-source-data-to-a-workspace-199)
		- [Data Modelling](https://help.gooddata.com/doc/enterprise/en/data-integration/data-modeling-in-gooddata) ([Data Models Community Discussion](https://community.gooddata.com/data-models-58))
			- **Dataset** ~ a database table
			- **[Fact](https://help.gooddata.com/doc/enterprise/en/data-integration/data-modeling-in-gooddata/logical-data-model-components-in-gooddata/facts-in-logical-data-models)** ~ a column with a numerical value in it (measures or metrics called historically)
			- **[Attribute](https://help.gooddata.com/doc/enterprise/en/data-integration/data-modeling-in-gooddata/logical-data-model-components-in-gooddata/attributes-in-logical-data-models)** ~ a column with a categorical value (**Attribute labels** can group mode columns)
			- Relationships (1:1, 1:N, M:N)
			- Primary key / Referrence (composite key)
			- Date dimension ([Dates and Times](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/dates-and-times))
			- **Calculated Measure/Metric** ([Metric Editor](https://help.gooddata.com/doc/enterprise/en/how-to-get-started-with-gooddata/create-metrics/create-and-save-a-metric?pageId=81961865)) = calculation on top of LDM
		- Using [Metrics](GD.Metrics.md) for advanced querries
			- [Aggregation Functions](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language/maql-expression-reference/aggregation-functions)
			- [Arithmetic Operations](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language/maql-expression-reference/numeric-functions/arithmetic-operations)
			- [Filtering with WHERE condition](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language/maql-expression-reference/filter-expressions/filtering-with-the-where-clause)
			- [COUNT data aggregation](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language/maql-expression-reference/aggregation-functions/count)
	- Load data
		- Manual upload from physical files ([Data Loading](https://help.gooddata.com/doc/enterprise/en/how-to-get-started-with-gooddata/load-data))
		- Automated Data Loads using ADD ([Automated Data Distribution](https://community.gooddata.com/data-sources-kb-articles-47/add-distributing-data-to-multiple-workspaces-197), [Incremental Data Loading](https://community.gooddata.com/data-sources-kb-articles-47/add-incremental-data-loading-198), [ADD Load Modes](https://help.gooddata.com/doc/free/en/data-integration/data-preparation-and-distribution/direct-data-distribution-from-data-warehouses-and-object-storage-services/automated-data-distribution-v2-for-data-warehouses/load-modes-in-automated-data-distribution-v2-for-data-warehouses))
		- Custom Data Pipeline with **ADS** (Agile Data Warehousing Service)
		- Data Loads over REST APIs ([API Documentation](https://help.gooddata.com/doc/growth/en/expand-your-gooddata-platform/api-reference#/reference/data-integration/manage-executions-for-a-process/execute-a-process), [Load Data via API](https://help.gooddata.com/doc/free/en/data-integration/data-preparation-and-distribution/additional-data-load-reference/loading-data-via-rest-api))
2. **Analyze** ([Analytical Designer](https://help.gooddata.com/doc/enterprise/en/how-to-get-started-with-gooddata/add-insights-and-dashboards/create-an-insight?pageId=81961834))
	- Create Insights (reusable components)
3. **Dashboards**
	- Create presentation layer (consists of Insights)
	- [Geo charts](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/analytical-designer/visualize-your-data/insight-types/geo-charts-pushpins) ([Using Geo Charts](https://www.gooddata.com/blog/using-geo-charts-gooddata-technical-overview/))
	- Manage --> Workspaces & Users --> Invite user ([User roles](https://help.gooddata.com/doc/enterprise/en/workspace-and-user-administration/managing-users-in-workspaces/user-roles))
4. Embed
	- 
5. Operate 

## Development

- Analytics as a code, CI/CD
- Using Python SDk for statistical analysis
- Integration with MindsDB for ML
- Integrating GoodData with [dbt](../dbt.md)

[Access GD workspace from Apache Zeppelin](https://medium.com/gooddata-developers/accessing-gooddata-workspace-from-apache-zeppelin-notebook-a057856030e6)

[Gooddata blog](https://padak.posthaven.com/tag/gooddata)
