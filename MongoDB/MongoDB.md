NO-SQL database [https://www.turnkeylinux.org/mongodb](https://www.turnkeylinux.org/mongodb)  
  
List of types and operators [https://www.w3resource.com/mongodb/mongodb-type-operators.php](https://www.w3resource.com/mongodb/mongodb-type-operators.php)  
SQL to MongoDB Mapping [https://gist.github.com/aponxi/4380516](https://gist.github.com/aponxi/4380516)  
  
MongoDB download [http://www.mongodb.org/downloads](http://www.mongodb.org/downloads)  
MongoDB Cheat Sheet [https://blog.codecentric.de/files/2012/12/MongoDB-CheatSheet-v1_0.pdf](https://blog.codecentric.de/files/2012/12/MongoDB-CheatSheet-v1_0.pdf)  

[Compression Methods in MongoDB: Snappy vs. Zstd](https://www.percona.com/blog/compression-methods-in-mongodb-snappy-vs-zstd/)



### Installation
[Is MongoDB Open Source? Is Planet Earth Flat?](https://www.percona.com/blog/is-mongodb-open-source)

[MongoDB V4.2 EOL Is Coming: How To Upgrade Now and Watch Out for the Gotchas!](https://www.percona.com/blog/how-to-upgrade-mongodb-v4.2-eol)

Client interfaces
[What is the MongoDB Connector for BI — MongoDB Connector for BI](https://www.mongodb.com/docs/bi-connector/master/) (postgreSQL facet)
[Connect BI Tools — MongoDB Connector for BI](https://www.mongodb.com/docs/bi-connector/current/client-applications/)



## Administration


Administer or OS level:  


```bash
mongod # start mongo  
ps aux | grep mongo  
ls aux # show all running processes  
ls -la # check permissions  
sudo chown user file # in case, some of dbfiles do not belong tu ser trying to run db instance  
mongo # start shell
```



  
  
Mongo app commands

```sql
show db --list of databases  
use db_name  
db -- show selected database  
show collections --list of document group  
db.collection_name.find()  -- search   
help -- get some help commands
```


[MongoDB: How To Convert BSON Documents to a Human-readable Format](https://www.percona.com/blog/mongodb-how-to-convert-bson-documents-to-a-human-readable-format/)
[Dealing With Chunks That "Lost Weight" in MongoDB](https://www.percona.com/blog/dealing-with-chunks-that-lost-weight-in-mongodb/)
  
  
MongoDB Wall [https://www.ampower.me/wall/Mongo-93](https://www.ampower.me/wall/Mongo-93)  
MongoDB C# Driver [http://www.layerworks.com/blog/2014/11/11/mongodb-shell-csharp-driver-comparison-cheat-cheet](http://www.layerworks.com/blog/2014/11/11/mongodb-shell-csharp-driver-comparison-cheat-cheet)  
MongoDB performance best practises [https://admins247.com/mongodb-performance-best-practices/](https://admins247.com/mongodb-performance-best-practices/)  
MongoDB performance best practises [https://codemason.me/2016/04/07/performance-best-practices-for-mongodb/](https://codemason.me/2016/04/07/performance-best-practices-for-mongodb/)  
Bhishan Bhandari: MongoDB and Python [http://feedproxy.google.com/~r/TheTaraNights/~3/eMelD25GwpI/](http://feedproxy.google.com/~r/TheTaraNights/~3/eMelD25GwpI/)  
Polyglot.Ninja(): Auto incrementing IDs for MongoDB [http://polyglot.ninja/auto-incrementing-ids-for-mongodb/](http://polyglot.ninja/auto-incrementing-ids-for-mongodb/)

[CommitQuorum in Index Creation From Percona Server for MongoDB 4.4](https://www.percona.com/blog/commitquorum-in-index-creation-from-percona-server-for-mongodb-4-4/)

### Backup / restore

[How To Fix Oplog Restore Error: E11000 Duplicate Key Error Collection Using Percona Backup for MongoDB](https://www.percona.com/blog/how-to-fix-oplog-restore-error-e11000-duplicate-key-error-collection-using-percona-backup-for-mongodb/)

