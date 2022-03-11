--- --- --- I N S T A L A T I O N --- --- ---
--#1 check resources, plan dbcc database
sp_plan_dbccdb
--#2 set max working processes if neccesary
sp_configure "number of worker processes"
sp_configure "memory per worker process"
--#3 cache + buffer config (optional)
sp_poolconfig
sp_cacheconfig
--#4 create dbcc database
if not exists (select * from master..sysdatabases where name="dbccdb")
    begin
        disk init 
            name = "t2k_dbccdb", 
            physname = "/sybase/t2k_dbccdb.dat",
            size = "50M"
        create database dbccdb
            on t2k_dbccdb = "25M"
            log on t2k_dbccdb = "4M"
            with override
    end
else
    begin
        print "already existing"
        --sp_helpdb dbccdb
    end
--#5 install dbbc with script
isql -Usa -S$SERVER_NAME -i $SYBASE/$SYBASE_ASE/scripts/installdbccdb
--#6 create segments and workspaces
sp_dbcc_createws dbccdb
--#7 update config table
sp_dbcc_updateconfig pubs2,"max worker processes"


--- --- --- W O R K A R O U N D --- --- ---
sp_help dbcc
dbcc checkstorage
dbcc checkverify


exec sp_dbcc_summaryreport database
exec sp_dbcc_faultreport long, database

sp_dbcc_help_fault

--then use corresponding