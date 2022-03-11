sp_helpdb master

sp_helpthreshold

sp_addthreshold master, logsegment, 1024000, sp_thresholdaction
sp_addthreshold master, logsegment, 512000, sp_thresholdaction
sp_addthreshold master, logsegment, 256000, sp_thresholdaction
sp_addthreshold master, logsegment, 192000, sp_thresholdaction

-- tempdb thresholds

-- (true - transactions will get aborted, false - transactions will be suspended upon the event where the transaction log space is filled up)
sp_dboption tempdb,"abort tran on log full",true 

-- (gives flexibility to terminate user session/raise warning before transaction log is filled up)
-- http://www.databasejournal.com/features/sybase/article.php/3866671/Using-the-Sybase-ASE-Resource-Governor.htm
sp_add_resource_limit "user1",null,"at all times","tempdb_space",200