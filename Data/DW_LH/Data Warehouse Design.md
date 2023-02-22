# Designing a Warehouse Schema

  
Following are the basic steps for designing a data warehouse based on facts and dimensions.  
  

## Identify Facts and Fact Table Grain

  
• Identity business processes for analysis such as sales trend over the period or cross sell  
• Determine the facts that are needed directly or indirectly for the identified business analysis  
• The facts identification is the process of looking at source database and see if the source database can satisfy business needs such as source does not have any information on products name/brand sold but has only consolidated information on the kind of product that is sold  
• Identify and list out source facts typically stored in transaction tables  
• Determine the lowest level of granularity needed for the facts such as business analysis needs only weekly sales information  
• Determine the entities for the source transactions. It can be identified from the parameters for the source measures such as Product cost is based on products, date and store  
  

## Identify Dimension Keys and Attributes

  
A dimension logically consists of a primary (unique) key that maps to a foreign key in the fact table. The dimension also includes additional attributes about that key. For example, in a Customer dimension, the Customer ID may be the logical primary key. Some of the attributes provide the basis for grouping the facts. These are the _groupable_ attributes. For example, Gender, City, State, and Country may be groupable attributes of a customer. Other attributes are descriptive. For example, Mobile Phone Number is an attribute of a customer, but a report is unlikely to group by phone numbers. Some of the groupable attributes can be organized into a hierarchy, allowing drill-down reporting. For example, City rolls up to State, which rolls up to Country. Not all attributes can be organized into a single hierarchy.  
• As OLTP is normalized there can be more than one table present for each business entity such as Products, Products Manufacturer details  
• Extract the required attributes of each business entity such as Products needs only Product Name, Manufacturer though there are other attributes of parameters but not needed for the analysis  
• Denormalize the business entity (flattening normalized tables to make unique set of attributes of each business entity)  
• Prepare a logical data modal consisting structure on how business entities related each other and entities that depend on source measures  
• Hierarchies for the dimensions are stored with in the dimensional table in star schema  
• In Star schema every dimension will have surrogate key as a primary key and there is no child/parent table present for the dimensions  
• Fact tables will have a composite key containing the dimension keys  
  

## Steps in designing Snow Flake Schema

  
• It is similar to Star schema but with a degree of normalization is being performed  
• One or more dimension tables, each with a generated primary key, which contain one or more descriptive fields used to determine some level attributes for each dimension. In addition, a dimension table may contain a join to one or more other child dimension tables that supply additional level attributes for each dimension Example: Manufacturer information is kept in a separate dimension and Product dimension has a reference of Manufacturer in its attributes. In star schema the manufacturer information would have been as attributes to Product dimension (not a separate dimension)  
• In a snowflake schema, more than one table is required to completely define the set of attributes for the dimension.  
• In a snow flake schema, a dimension table may have have a relationship to foreign keys in more than one dimension table. For example, a Geography table can join to the GeographyKey of Customer, Reseller, and Manufacturer  
• Whether a dimension is designed as a single table (star) or multiple tables (snowflake) has no effect on the fact table.  
• In a fully-normalized snowflake dimension, you can clearly see the hierarchical relationship between attributes. In a star dimension, you may not see the hierarchical relationships.  
  

## Guidelines for choosing Star vs. Snowflake

  
• Consider a snowflake schema to reduce storage requirements for a large dimension tables. For example, Storing the information about the manufacturer in a product dimension table would make a product dimension unnecessarily large because one manufacturer may provide multiple products  
• Consider snowflaking a dimension if one entity is referenced by multiple dimensions. For example, Customers, Resellers, and Manufacturers may all have a Geography component. Extracting geography information into a normalized table allows for consistency between geographical definitions for the different dimensions. A snowflaked dimension accessed from multiple dimensions is called a _reference_ dimension.  
• Another reason for using a snowflake schema is to supply information, not about the level attributes of a dimension, but the secondary attributes of a level.