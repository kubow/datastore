------------------------------------------------------------
--- PRIMARY SERVER --- Containing Data --- (t2k_ds) --------
------------------------------------------------------------

--1a / Add server

select @@servername 
sp_addserver t2k_rem_ds, asenterprise
--sp_dropserver t2k_rem_ds
sp_helpserver

--2a / Add remote login

sp_addremotelogin t2k_rem_ds, sa, sa
sp_remoteoption t2k_rem_ds, sa, sa, trusted, true
--sp_dropremotelogin t2k_rem_ds
sp_helpremotelogin


--3a / Insert tables

select * into pubs2..br_smlouva from pubs2..aaa
select * from pubs2..br_smlouva
select * into pubs2..brsmlouva from pubs2..br_smlouva
select * from pubs2..brsmlouva

sp_helpobjectdef pubs2.dbo.br_smlouva

------------------------------------------------------------
--- SECONDARY SERVER - Remotely Connecting - (t2k_rem_ds) --
------------------------------------------------------------

--1b / Secondary Server - (t2k_rem_ds)

sp_configure 'remote access',1

sp_addserver t2k_ds, direct_connect
sp_addexternlogin t2k_ds, sa, sa 

sp_addremotelogin t2k_ds, sa, sa
sp_remoteoption t2k_ds, sa, sa, trusted, true

sp_helpserver
sp_helpremotelogin
sp_helpexternlogin

--2b / create proxy tables

sp_addobjectdef "dc_aaa", "t2k_ds.pubs2.dbo.aaa", "table"
create proxy_table dc_aaa at "t2k_ds.pubs2.dbo.aaa"

sp_addobjectdef "br_smlouva", "t2k_ds.pubs2.dbo.br_smlouva", "table"
create existing table br_smlouva (col1 int, col2 char) external table at "t2k_ds.pubs2.dbo.br_smlouva" 

sp_addobjectdef "smlouva", "t2k_ds.pubs2.dbo.brsmlouva", "table"
create existing table br_smlouva (col1 int, col2 char) at "t2k_ds.pubs2.dbo.brsmlouva"


--3b / Select from tables

exec t2k_ds...sp_who

select * from dc_aaa
select * from br_smlouva

shutdown
--!!!!!!!