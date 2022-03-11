--Page compression is now supported for indicies

create table a (b int)
sp_configure 'enable compression',1
create index a1 on a(b) with index_compression = page
sp_help 'a' 
--shows  a1    b   	 nonclustered, compressed, contain compressed data 
create index a2
    on a(b) 
    local index ip1 with index_compression = PAGE, 
    ip2 with index_compression = PAGE,ip3 

/* Session options are: set compression default|ON|OFF

This command affects only leaf rows that are built for compressed indexes after the command is executed.
create table b (c int) with index_compression = PAGE|NONE
alter table order_line set index_compress = PAGE|NONE
alter table sales modify partition Y2009 set index_compression = PAGE
alter index a.b set index_compression = PAGE|NONE */

-- Sort operator perfromance improvement

-- Hash join operator perfromance improvement

-- Query plan optimization with star joins

-- Dynamic thread assignment
