
**DML (Data Manipulation Language) -** [https://en.wikipedia.org/wiki/Data_manipulation_language](https://en.wikipedia.org/wiki/Data_manipulation_language)  
**insert -** add data to a table (insert into publishers (pub_name, pub_id) values ("New Age Books", "123"))  
**update -** update data already in a table (update publishers set pub_name = "New Age Books 2" where pub_id = "123")  
**delete** - remove data from table (delete from publishers)  
**select** - retrieve data from table (select pub_name, pub_id from publishers)


```sql
INSERT INTO table_name VALUES ()  
INSERT INTO table_name SELECT * FROM another_table_name  
--Include both datastructure and data  
SELECT *  
INTO NewTable  
FROM ExistingTable;  
--Include data structure only  
SELECT *  
INTO NewTable  
FROM ExistingTable  
WHERE 1 <> 1;
```


