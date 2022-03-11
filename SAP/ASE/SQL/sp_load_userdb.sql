--http://froebe.net/blog/2013/06/05/sybase-ase-a-simple-way-to-let-users-restore-a-database-using-a-stored-procedure/
use sybsystemprocs
go

if exists (select 1 from sybsystemprocs..sysobjects where name = "sp_load_userdb")
	drop procedure sp_load_userdb
go

CREATE PROCEDURE dbo.sp_load_userdb
@dbName varchar(100) = NULL, 
@DAYofMonth smallint = NULL
AS 
BEGIN
	if (@dbName is NULL or not exists select 1 from (master..sysdatabases where name = @dbName))
	begin
		print "Please specify a database and day of month to restore from."
		print "sp_load_userdb d1folio1, 15"
	end
	else
	if (@dbName in ('master', 'tempdb', 'tempdb2', 'tempdb3', 'sybsystemprocs', 'sybsystemdb'))
	begin
		print "sp_load_userdb only works with user databases."
	end 
	else
	if (@DAYofMonth is NULL or @DAYofMonth < 1 or @DAYofMonth > 31)
	begin
		DECLARE @cmd varchar(255)

		print "Dump file not found!"
		select @cmd = "find /some_dir/user_backups -name " + @dbName + "_*" + " -type f -exec basename {} \;"
		print @cmd
		exec xp_cmdshell @cmd
	end
	else
	begin
		if (db_name() = "master")
		begin
			DECLARE @dbNamePath varchar(255)

			exec kill_user_connections @dbName
			select @dbNamePath = "/some_dir/user_backups/" + @dbName + "_" + convert(varchar(10), @DAYofMonth) + ".dmp"
			load database @dbName from @dbNamePath
			online database @dbName
		end 
		else
			print "Please run sp_load_userdb from the master database."
	end 
END
go