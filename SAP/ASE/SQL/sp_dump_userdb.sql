--http://froebe.net/blog/2013/06/05/sybase-ase-a-simple-way-to-let-a-user-backup-a-database-using-a-stored-procedure/ 
use sybsystemprocs
go

if exists (select 1 from sybsystemprocs..sysobjects where name = "sp_dump_userdb")
	drop procedure sp_dump_userdb
go

CREATE PROCEDURE dbo.sp_dump_userdb
@dbName varchar(100) IN
AS 
BEGIN
	if (@dbName in ('master', 'tempdb', 'tempdb2', 'tempdb3', 'sybsystemprocs', 'sybsystemdb'))
	begin
		print "sp_load_userdb only works with user databases."
	end 
	else
	if exists (select 1 from master..sysdatabases where name = @dbName)
	begin
		DECLARE @DAYofMonth smallint
		DECLARE @dbNamePath varchar(255)
		DECLARE @out varchar(255)

		select @DAYofMonth = datepart(day, getdate())
		select @dbNamePath = "/dba/backup/sybbackup/user_backups/" + @dbName + "_" + convert(varchar(10), @DAYofMonth) + ".dmp"
		select @out = "Backing up database '" + @dbName + "' to " + @dbNamePath
		print @out

		dump database @dbName to @dbNamePath with init,compression=3

		/*  Remove old dump files (older than 2 weeks) */
		exec xp_cmdshell "find /dba/backup/sybbackup/user_backups -mtime +14 -exec rm {} \;"

		print "Backup complete!"
	end 
	else
	begin
		select "'" + @dbName + "' is an unknown database.  Please verify name."
	end 
END
go