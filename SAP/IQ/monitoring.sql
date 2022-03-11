
-- # 1 capture information
sp_iqworkmon status
sp_iqworkmon "START"
sp_iqworkmon status
sp_iqworkmon "STOP"

sp_iqtableuse
sp_iqcolumnuse
sp_indexuse

sp_iqunusedtable
sp_iqunusedcolumn
sp_iqunusedindex

INSERT mon_table (idx_nm, tab_nm, owner, idx_typ)
    SELECT * FROM so_iqunusedindex();
COMMIT;
EXEC sp_iqworkmon reset;

-- # 2 capture 
create table iqmontable (c1 int)
go
iq utilities main into iqmontable start monitor '-interval 20'
go
-- run the above for a minute
iq utilities main into iqmontable stop monitor
go

iq utilities private into iqmontable start monitor '-debug –interval 20'
go
-- run the above for a minute
iq utilities private into iqmontable stop monitor
go
drop table iqmontable
go
