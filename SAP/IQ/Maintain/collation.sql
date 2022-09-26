--using sa_db_properties system procedure
select * from sa_db_properties() where PropName='Collation'

--using db_property system function
select db_property('Collation')

--confirm also the boot message of iqmsg file