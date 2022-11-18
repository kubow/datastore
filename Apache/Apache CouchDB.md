Apache CouchDB™ is a database that uses JSON for documents, JavaScript for MapReduce indexes, and regular HTTP for its API  
  
[https://en.wikipedia.org/wiki/Couchdb](https://en.wikipedia.org/wiki/Couchdb)  
[http://couchdb.apache.org/](http://couchdb.apache.org/)

## Architecture

[3. Design Documents — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/ddocs/index.html)



## Installation

[1.1. Installation on Unix-like systems — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/install/unix.html)  
  
[1.2. Installation on Windows — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/install/windows.html)  
  
[1.3. Installation on macOS — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/install/mac.html)  
  
[1.4. Installation on FreeBSD — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/install/freebsd.html)  
  
[1.10. Troubleshooting an Installation — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/install/troubleshooting.html)


```bash
couchdb start  # Starts a CouchDB instance  
http://localhost:5984/_utils  # Starts a CouchDB instance  
brew install couchdb  # Installs CouchDB on Mac OSx
```

## Maintain

[Overview — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/)  
  
[4. Best Practices — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/best-practices/index.html)  
  
[indexing - How to create and maintain couchDB/pcouchDB doc _id's - Stack Overflow](https://stackoverflow.com/questions/30769178/how-to-create-and-maintain-couchdb-pcouchdb-doc-ids)

### Replication

[database - Replication Modes Definitions? - Stack Overflow](https://stackoverflow.com/questions/5460183/replication-modes-definitions?rq=1)  
  
[2. Replication — Apache CouchDB® 3.2 Documentation](https://docs.couchdb.org/en/stable/replication/index.html)


### REST API


```bash
curl -XGET localhost:5984  # Retrieves information about this node (GET)  
curl -XGET localhost:5984/_active_tasks  # Retrieves the list of active tasks (GET)  
curl -XGET localhost:5984/_all_dbs  # Retrieves the list of database names (GET)
```
