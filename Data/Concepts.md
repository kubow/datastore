# Data concepts

[Index - Data Engineering Wiki](https://dataengineering.wiki/Index)

- [Types of data](./Types/Types.md)
- [Storage Comparison](./Types/Storage%20Comparison.md)
	- [Data Warehouse](./Storage/Data%20Warehouse.md)
	- [LakeHouse|Data Lake(house)](./Storage/LakeHouse.md)
- [Modelling](./Model/Modelling.md)
- [Processing](./Processing/Processing.md)
- [Data Query Language](./Query/StructuralQueryLanguage.md)
- [Semantic layer](./Semantic%20layer.md)
- [Visualization](./Visualize/Visualization.md)
- [Business Intelligence](./BI/Business%20Intelligence.md)
- [Data Science](./Data%20Science.md)
- [Machine Learning](./AI_ML/Machine%20Learning.md) / [Artificial Intelligence](./AI_ML/Artificial%20Intelligence.md)
- [Natural Language](./NL/Natural%20Language.md)


![zpracovani dat](https://upload.wikimedia.org/wikipedia/commons/e/ee/Relationship_of_data%2C_information_and_intelligence.png)


- **Data**: apply meaning
- **Information**: apply context
- **Knowledge**: apply insight
- **Wisdom**: apply purpose
- **Decission**

[40 Key Computer Science Concepts Explained In Layman’s Terms](https://carlcheo.com/compsci)
[How To Reduce the Costs of Database Management in Financial Services](https://www.percona.com/blog/how-to-reduce-the-costs-of-database-management-in-financial-services/)
[mysql - Relationship between catalog, schema, user, and database instance - Stack Overflow](https://stackoverflow.com/questions/7942520/relationship-between-catalog-schema-user-and-database-instance)


# Data Analysis

[Data analysis - Wikipedia](https://en.wikipedia.org/wiki/Data_analysis)
- [Embedded analytics](#embedded-analytics)
- [Distributed analytics](#distributed-analytics)

### Embedded analytics

technology designed to make data analysis and business intelligence more accessible
[Embedded analytics - Wikipedia](https://en.wikipedia.org/wiki/Embedded_analytics)
[What Is Embedded Analytics? | Reveal Business Intelligence Glossary](https://www.revealbi.io/glossary/embedded-analytics)

### Distributed analytics

#### History (natural evolution)

- one data analytics team that takes care about preparing insights and dashboards over data
- people come to ask and rely on this team
- parallel need - more people to see **some** kind of analytics (external/internal)
- information needed to be shared across organization
- BI tools needed to shift to something that is **useful** and **customizable** by different types of
	- businesses
	- semi-technical users

#### Current state

- someone who understands the data on the architecture level (know SQL, how to query)
- rest of people are preparing **parts** of end-user analytics (the name distrbuted)
- responsibility to connect the physical data from their sources into so called **semantic model**
- building analytics easily by drag&dropping, even without SQL knowing code or understanding the data
- guarantee to see data dedicated to specific users
- play with it
- data needs to be shared across different strucutre (granularity and hierarchy -huge and varies)
- same mechanisms underneath but people see just relevant data