# SAC Predictive Features

All of these (except Smart Discovery and Smart Insights) are available both for **Acquired Data** and **Live Data**:

- [[#Predictive Forecast]]
- [[#Search to Insight]] (request data in natural language by typing a question about your data)
- [[#Smart Grouping]]
- [[#Smart Insights]]
- [[#Smart Predict]]
- [[#Smart Discovery]] (create a story automatically)

## Predictive Forecast

Predictive forecasting uses historical data to predict future possibilities. The more historical data there is, the more accurate the prediction. Predictive forecasting takes different values into account, and also looks at trends, cycles, and fluctuations in your data. This data-driven approach optimizes your planning process as it is based on facts, not feelings.

The key features of predictive forecasting are as follows:

- Easy to use
- No set-up required
- Use Smart Predict for more advanced requirement
- Select from existing algorithms:
	- Automatic
	- Linear regression
	- Triple exponential smoothing
	- Add additional inputs

### Time Series Forecasting

- Project expected values in future time periods in planning and charting use cases
- Validate the quality by looking at the confidence interval, hindcast and quality indicators
- Include additional factors (such as weather information) to simulate expected values in future time periods
- Create forecasts with time series, trend charts and line charts


- **Time Series Forecasting**
	- use trained dataset to build a model that can apply on target dataset
	- train a model based on a data file
	- apply the model to the target prospects
	- use the output to predict next year sales (for example)
	- make adjustments if needed
	- write to a planning model



## Search to Insight

Search to Insight helps information workers ask questions of their data in natural language and get a result that is visualized.
in case of Live Data there are supported all live connections except for SAP HANA Cloud and SAP DWC.

### Key features

- Access search to insight from the home page or stories
- Search across models or within a specific model
- View other measures and dimensions that are searchable within a model
- Specify a chart type when asking questions (advanced)

Example questions users can answer with search to insight:

- Basic questions / filtered measure
- Part to whole / contribution questions
- Top n / bottom n sort and rank questions
- Change over time questions
- Questions restricting / filtering a measure
- Measure correlation questions
- Measure variance / comparison questions

1. Identify info worker use cases / questions
2. Index model with search to insight
3. Create synonyms
4. Test search
5. Training & rollout to end users / info workers

Identify use cases to enable with search to insight

Before you start (not in SAC)

- Identify user groups / information workers that search to insight can enable
- Identify key questions they want to be able to ask in natural language
- Identify the models / views needed to answer these questions

Indexing live models with search to insight

- Search to insight needs to index the master data in the live model to support querying and typeahead at search time.
- Only the names of measures, dimensions, and members (that is, the master data) are added to the index. The raw data from the live connection is not duplicated in SAC.
- One index is generated per model. All users searching this model use the same index.
- Search results are not returned from the index.

Search results are returned from the live connection based on the user’s data access rights as set up for SAP HANA, BW, and so on.

- The index is securely stored in your SAC tenant.

About prompts / variables when indexing live models

- Prompts / variables set the scope of what data is indexed in the live model and is ultimately searchable by end users
- If no variables are set, search to insight will attempt to index all data

Best Practice

- Generate the index using a technical user account with admin access to the underlying data to set the largest index scope possible
- Don’t set variables for optional prompts and avoid mandatory prompts if possible

## Smart Grouping

- scatter plot chart -> enable smart grouping
- automaticallly creates clusters using regression

## Smart Insights

Clicking on data point to get smart textual and visual insights.

Smart Insights allows you to quickly develop a clear understanding of intricate aspects of your business data.

Consider you are interested in analyzing the total annual salary spent in North America (NA). You can see that the company has employees situated in three countries: Belgium, Canada and USA. As the company is spending more in the US, explore who are the top contributors.

- right-click chart/data table point -> system adds context (like total salary)
- SAC can help to determine what are key contributors to that total
- case Live Data only supported for SAP HANA on-premise



## Smart Predict

Smart Predict helps you answer business questions that need predictions or predictive forecasts to plan for future business evolution. It automatically learns from your historical data, and finds the best relationships or patterns of behavior to easily generate predictions for future events, values, and trends. Additionally, you get easy-to-understand Key Performance Indicators (KPIs) and visualizations that help you evaluate the predictions accuracy. You can then leverage those predictions and predictive forecasts with confidence to augment your planning model and stories.

You can create one or several predictive models within a Smart Predict. Each predictive model produces intuitive visualizations of the results making it easy to interpret its findings. Once you have compared the key quality indicators for different models, you choose the one that provides the best answers to your business question, so you can apply this predictive model to new datasources for predictions.

• Trial tenants do not currently support Smart Predict.

• Smart Predict is not necessarily available on all existing SAP Analytics Cloud tenants. To verify that Smart Predict is available in your SAP Analytics Cloud system, see: [SAP Note - 2661746](https://launchpad.support.sap.com/#/notes/2661746)

Planning models can be used as datasources for Smart Predict. This means you get to add predictive forecasts directly to your planning models. You can easily combine dimensions to split your data into entities, getting forecasts for each entity to improve predictive accuracy and confidence. This is beneficial for large-scale forecasting.

Planning users get access to predictive reports so they can see the quality of the debriefs and KPIs. Experiencing the business-orientated insights firsthand will build confidence for them to use the predictive forecasts.

Smart Predict is explained fully in the SACPR1 training: SAP Analytics Cloud: Predictive Functions.

Smart Predict scenarios are as follows:

- **Classification**
	- What is the likelihood that a future event occurs?
	- This event is observed at individual level and at a certain horizon.
	- Who is likely to buy a new product?
	- Which client is a candidate for a churn?
- **Regression**
	- What could be the prediction of a business value, taking into account the context of its occurence?
	- What will be the revenue generated by a product line based on planned transport charges and tax duties?
- **Time Series forecast**
	- What are future values of a business value over time (at a ceratin granularity or place)?
	- How much ice cream will be sold over next twelve months?
	- I would like to enrich my historical daily sales with other factors like vacation months or seasons.

- run a canned program to project out months
- time series chart: Add -> Forecast - choose Atomatic / Advanced option
- table: More -> Predictive Forecast - to publish to a planning model
- supported for datasets and planning models but not for analytic models
- case Live Data only supported for SAP HANA on-premise


## Smart Discovery
not available with Live Data
Smart data discovery is a next-generation data discovery capability that provides business users or citizen data scientists with insights from advanced analytics. Running a Smart Discovery on a data set uses artificial intelligence to analyze that data and generate a story consisting of Overview, Key Influencers, Unexpected Values, and Simulation pages.

### Key Features
- supervised machine learniong using regression for measures and offers cassification if you select a dimension
- Auto-generate fully populated, multi-tabbed stories with Overview, Key Influencers, Unexpected Values and Simulation tabs
- Identify actionable insights powered by Machine Learning
- Expose key influencers driving business-critical KPIs
- Analyze outliers to identify impactful decisions
- Predict future outcomes with interactive simulation

With dynamic text token in chart footers, you can supplement visualizations with smart textual explanations on the contributors behind your data.
SAP Analytics Cloud Runs on SAP HANA, so the core predictive features of SAP HANA are available, which includes the Automated Predictive Library (APL) and the Predictive Analysis Library (PAL).

The measure should be set as Target.