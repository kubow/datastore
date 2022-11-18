[[PSQL System]]


## Install

[Install on Ubuntu 22](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart)

[Configure postgreSQL for the first time](https://stackoverflow.com/questions/1471571/how-to-configure-postgresql-for-the-first-time)



```bash
# check if running
pgrep -u postgres -fa -- -D
# connect to the deault database (after fresh installation)
sudo -u postgres psql template1
# at the psql command line
ALTER USER postgres with encrypted password 'xxxxxxx';
# restart the service
sudo /etc/init.d/postgresql restart

```

Inside the psql console
- [Find the hostname and port](https://stackoverflow.com/questions/5598517/find-the-host-name-and-port-using-psql-commands)
- 


## Maintain

Exporting [http://www.pgadmin.org/docs/1.18/export.html](http://www.pgadmin.org/docs/1.18/export.html)  
  
[http://stackoverflow.com/questions/6024108/export-a-create-script-for-a-database-from-pgadmin](http://stackoverflow.com/questions/6024108/export-a-create-script-for-a-database-from-pgadmin)  
  
duplicate database [http://stackoverflow.com/questions/876522/creating-a-copy-of-a-database-in-postgresql](http://stackoverflow.com/questions/876522/creating-a-copy-of-a-database-in-postgresql)  
Psql list all databases [http://dba.stackexchange.com/questions/1285/how-do-i-list-all-databases-and-tables-using-psql](http://dba.stackexchange.com/questions/1285/how-do-i-list-all-databases-and-tables-using-psql)  
  
Remove extended characters in string [http://stackoverflow.com/questions/15259622/how-do-i-remove-extended-ascii-characters-from-a-string-in-t-sql](http://stackoverflow.com/questions/15259622/how-do-i-remove-extended-ascii-characters-from-a-string-in-t-sql)  
Replace string in field [http://stackoverflow.com/questions/5060526/postgresql-replace-all-instances-of-a-string-within-text-field](http://stackoverflow.com/questions/5060526/postgresql-replace-all-instances-of-a-string-within-text-field)  
Replace ASCII to UTF8 [http://www.laudatio.com/wordpress/2008/11/05/postgresql-83-to_ascii-utf8/](http://www.laudatio.com/wordpress/2008/11/05/postgresql-83-to_ascii-utf8/)  
  
Postgres to sqlite convert [https://stackoverflow.com/questions/6148421/how-to-convert-a-postgres-database-to-sqlite](https://stackoverflow.com/questions/6148421/how-to-convert-a-postgres-database-to-sqlite)  
  
PostgreSQL, MonetDB, and Too-Big-for-Memory Data in R -- Part II [http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:733154](http://www.datasciencecentral.com/xn/detail/6448529:BlogPost:733154)