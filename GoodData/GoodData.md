# System 

- [[GD.UI|GD platform]] (BEAR)
- [[GD.CN|GD Cloud Native]] (TIGER)
	- no data storage
	- above data layer
- GD Cloud (PANTER)
	- hosted in the cloud

## General processing

1. **Data**
	- Connect to data sources
	- Build LDM (Semantic layer) 1 workspace = 1 LDM (abstract physical data structure)
		- [Mapping Data Sources](https://community.gooddata.com/data-sources-kb-articles-47/mapping-your-source-data-to-a-workspace-199)
		- [Data Modelling](https://help.gooddata.com/doc/enterprise/en/data-integration/data-modeling-in-gooddata) ([Data Models Community Discussion](https://community.gooddata.com/data-models-58))
			- **Dataset** ~ a database table
			- **Fact** ~ a column with a numerical value in it (measures or metrics called historically)
			- **Attribute** ~ a column with a categorical value (**Attribute labels** can group mode columns)
			- Relationships (1:1, 1:N, M:N)
			- Primary key / Referrence (composite key)
			- Date dimension ([Dates and Times](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/dates-and-times))
			- Measure = calculation on top of LDM
		- Using MAQL ([Analytical Query Language](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language)) for advanced querries
	- Load data
		- Manual upload from physical files ([Data Loading](https://help.gooddata.com/doc/enterprise/en/how-to-get-started-with-gooddata/load-data))
		- Automated Data Loads using ADD ([Automated Data Distribution](https://community.gooddata.com/data-sources-kb-articles-47/add-distributing-data-to-multiple-workspaces-197), [Incremental Data Loading](https://community.gooddata.com/data-sources-kb-articles-47/add-incremental-data-loading-198))
		- Custom Data Pipeline with ADS (Agile Data Warehousing Service)
		- Data Loads over REST APIs ([API Documentation](https://help.gooddata.com/doc/growth/en/expand-your-gooddata-platform/api-reference#/reference/data-integration/manage-executions-for-a-process/execute-a-process), [Load Data via API](https://help.gooddata.com/doc/free/en/data-integration/data-preparation-and-distribution/additional-data-load-reference/loading-data-via-rest-api))
2. **Analyze**
	- Create Insights (reusable components)
3. **Dashboards**
	- Create presentation layer (consists of Insights)
	- Manage --> Workspaces & Users --> Invite user ([User roles](https://help.gooddata.com/doc/enterprise/en/workspace-and-user-administration/managing-users-in-workspaces/user-roles))



