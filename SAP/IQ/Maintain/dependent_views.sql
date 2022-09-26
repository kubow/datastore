
create table T1 (C1 int, C2 bit, C3 varchar(10));
create table T2 (C1 int, C2 bit, C3 varchar(10));
create view V1_T1 as
select C1, C2, C3 from T1 union all select * from T2;
create view V1_V1 as select C1 from V1_T1 where C2 = 1;
create view V2_V1 as select C1 from V1_T1 where C3 = 'A';

select * from systab where table_id in (
    select dep_view_id
    from sa_dependent_views ('V1_T1','DBA')
    );

