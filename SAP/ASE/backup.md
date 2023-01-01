[http://logicalread.solarwinds.com/sybase-backup-database-creation-statements-se01/](http://logicalread.solarwinds.com/sybase-backup-database-creation-statements-se01/)

Amazon backups - [http://d0.awsstatic.com/enterprise-marketing/SAP/sap-on-aws-backup-and-recovery-guide-v2-2.pdf](http://d0.awsstatic.com/enterprise-marketing/SAP/sap-on-aws-backup-and-recovery-guide-v2-2.pdf)

![[dump_load.png]]

## Traceflags on Backup Server




## Automation of the 'DUMP DATABASE' and 'DUMP TRANSACTION' processes on Sybase ASE

You want to automate the 'DUMP DATABASE' and 'DUMP TRANSACTION' processes on Sybase ASE. For this you want to use a local file system for intermediate storage.
Using a local file system as an intermediate storage method for database and transaction log dumps is convenient since it is easy to set up and does not require additional hardware such as tape devices. Also, local file systems are always available to store a dump. Scheduled database or transaction log dumps will not fail due to inaccessible dump devices.
One disadvantage, however, is that you need additional disk space on your database server and you need to take care that subsequent dumps do not overwrite existing dump files. You need to secure the file system where you store your transaction log and database dumps against hardware failures - for example, by frequently performing a tape backup of the file system and/or enabling RAID10 for the file system.
Handling of many files in the file system can be more difficult compared to using a tape device when transaction log dumps have to be loaded.

The recommendations given in this note may serve as a blueprint for your setup. Please treat the advice given in this note as a possible suggestion as to how to set up the task, not as the one and only right approach. Also, verify that your setup suits your particular needs and test to restore your
SAP system frequently. Do not just assume you have successfully backed up your data!

To automate the dump process
- Create a file system to store the dumps
- create a stored procedure to call the dump command
- create a job and a schedule for each database you want to back up
- setup a threshold action to dump the transaction log when a threshold for the fill level has been reached.

### Create a file system to store the dumps
If you use a local file system to dump databases and transaction logs, it is recommended that you create a separate file sytem for the dumps that is located on a separate storage. This reduces the danger of both the database devices and the dump devices becoming unusable in the case of an error.
On UNIX/LINUX systems you mount the new file systems below the `/sybase/<SAPSID>` directory. 
Then use these directories as mount points for the file system(s) that will take up the dumps of the transaction log and the database dumps. This is not a requirement, but may be convenient.


### Create a stored procedure to call the dump command
Attached to this note you will find an tgz archive which contains SQL text for a Sybase ASE stored procedure 'sp_dumptrans' and a stored procedure 'sp_dumpdb'.
The stored procedure 'sp_dumptrans' generates a unique, timestamp-based name for a dump device file name. It then calls the 'dump transaction' command using this device name.
The stored procedure 'sp_dumpdb' generates a unique, timestamp based dump device file and calls the 'dump database' command using this device name.
Review the SQL text for these procedures and adapt it as needed. Change the code that generates the path for the dump device as required.
It is recommended that you create these stored procedures in the 'saptools' database.
Create and schedule ASE jobs to dump databases and transaction logs Sybase ASE comes with an integrated job scheduler, which you can use to automatically call the 'DUMP DATABASE' and the 'DUMP TRANSACTION' commands.
We recommend that you use the DBA Planning calendar in DBACOCKPIT to create these jobs and that you use the previously created stored procedures.
In order to minimize the potential for transaction loss in the case of a disk error, we recommend that you schedule a 'DUMP TRANSACTION' command frequently in a production environment.
Setup a threshold action for the transaction log In addition to a scheduled 'DUMP TRANSACTION' command, it is also recommended that you set up a threshold action that triggers a 'DUMP TRANSACTION' command whenever the so-called 'last chance threshold' in the transaction log is reached. If the fill level of the transaction log reaches this 'last chance threshold', ASE determines whether a stored procedure 'sp_thresholdaction' exists in the database in which the 'last chance threshold' has been reached. If 'sp_thresholdaction' does exist in the database, its execution is triggered.
Attached to this note you will find an SQL text for the possible implementation of 'sp_thresholdaction'. Its code executes the previously defined stored procedure 'sp_dumptrans'.
You can create additional thresholds. For more information on this task, refer to the Sybase documentation.