--First we need to create a database encryption key (DEK) in the master database which is used to encrypt the database
sp_configure "enable encrypted columns",1
--Create a master key and optionally a dual master key
create encryption key master with passwd "password"
set encryption passwd 'password' for key master
--Alter new pasword
alter encryption key master with passwd “testtest” modify encryption with passwd “sap16ase”
--Create the database encryption key
create encryption key dbkey for database encryption
alter encryption key encrypt_db_key for database encryption with dual control

--Check encrypted columns
sp_encryption system_encr_passwd, password

--Options for creating a database encryption key are:
create encryption key <name> [ for <algorithm>] for database encryption [with {[master key] [key_length 256] [init_vector random] [[no] dual_control]}

--Currently algorithm must be AES and key_length must be 256
--init_vector must be randon for full database encryption
--Encrpytion key can also be encrypted for dual control
--The way the encryption key is protected and the owner can be changed with "alter encryption key"
--You must backup the Database Encryption Key,master or dual master key and encrypted database
--E.g. use ddlgen to generate the sql for creating the keys
--To load an encrypted database restore the master key and DEK, create the database for encryption with the same DEK as the original database

load database with verify only -- = full is not supported as the backup server cannot decrypt

-- You cannot mount/unmount encrypted database / Keys can be dropped via "drop encryption key"
create database <name> encrypt with <keyname>

-- You cannot encrypt an in-memory database / An existing database can be encrypted via:
alter database <name> encrypt with <keyname> [parallel N]
alter database <name> resume encryption [parallel N]
alter database <name> suspend encryption

--To check if a database is encrypted as well as progress either use sp_helpdb or
select dbencryption_status(“status”, db_id(“existdb”))
select dbencryption_status(“progress”, db_id(“existdb”))
--Check encryption keys
select * from master..sysencryptkeys

--Suspend encryption
alter database pubs3 suspend encryption
--Resume encryption
alter database pubs3 resume encryption
--Delete encryption
drop encryption key encrypt_db_key

