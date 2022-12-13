# Keys and Indexes

  
  

## Types of Keys and Indexes

  
  
Consider the following types of keys:  
**Surrogate Key**: A key to represent uniqueness in dimensions and acts as a method of being referenced from fact tables. It generally an integer data type and get incremented for each key, to act as Identity column of the dimension.  
**Natural Key:** Also termed as Business key. This is the primary key or the unique key on the source system to represent the identification of entity uniquely. Typically this is also part of physical implementation of warehouse schema participating in dimension structure but will not be as a key. Natural key is just another attribute of dimension structure.  
  
Consider the following types of Indexes:  
**Clustered**: Need of having indexes on the fact tables and dimensions are very crucial in warehouse and should be optimized for data access queries. Typically clustered index on dimensions is created on surrogate key and surrogate keys used in the fact will be a composite key for fact tables.  
**Non-Clustered**: There is a requirement of creating non clustered indexes on measures and on other widely accessed columns of the fact table.  
**Covering Index:** Covering index will contain all the columns of the table, in this context it is for fact table. The idea behind of creating covering index is boosting performance for any queries need not be part of any other index at the cost of index size.  
  

## Key and Index Guidelines

  
  
Consider the following Key and Index guidelines for your dimensional model:  
• Avoid using GUIDs as keys. GUIDs may be used in data from distributed source systems, but they are difficult to use as table keys. GUIDs use a significant amount of storage (16 bytes each), cannot be efficiently sorted, and are difficult for humans to read. Indexes on GUID columns may be relatively slower than indexes on integer keys because GUIDs are four times larger. GUIDs are not generally accessed in the query and so there is no need of creating indexes on GUIDs  
• Have non clustered indexes created on the business keys if they are part of facts  
• Have clustered index created on dimension surrogate keys in facts (or create clustered index on Identity column and use non-clustered for SK FK’s)  
• There is no need to create separate indexes on measurements as they are accessed via the surrogate keys or business keys  
• For each dimension table, add a clustered index on the surrogate keys (primary key)  
• Make sure to use the index in the same order it is created. For example, if an index is created on columns F1, F2 in the order, try having your query filters out first on F1 and then F2  
• Analyze the query execution plan for specific report queries and sample ad hoc queries before optimizing the usage  
• Keep index keys smaller, do not include all the columns of the fact in the covering indexUses Indexed views to improve query performance that access data through views