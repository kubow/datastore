create procedure
//
// This procedure is to monitor the IQ server by checking DBspace usage and to prevent
// the IQ server from running out of main space.
//
// Information written by this procedure into the log is as follows:
//
// 1. Main Store
// 2. Temp Store
// 3. Versioning Space
//
// If usage of Main store reaches the specified threshold,
// IQ server disconnects the connection which holds the most Main space.
// Exceptions: DBA connections never dropped
dba.sp_dropConnOnMainUsed(LogFile varchar(50),FreeMainSpace integer)
begin
    declare maintotal unsigned bigint;
    declare mainused unsigned bigint;
    declare temptotal unsigned bigint;
    declare tempused unsigned bigint;
    declare databasename varchar(30);
    declare versionsize varchar(255);
    declare servername varchar(30);
    declare connname varchar(30);
    declare TempKB unsigned bigint;
    declare connuserid varchar(30);
    declare CurrTime varchar(30);
    declare MsgText varchar(255);
    declare connid integer;
    declare blocksizeX2 unsigned bigint;
    declare local temporary table m_iq_txn_table(
        TxnID unsigned bigint null,
        CmtID unsigned bigint null,
        VersionID unsigned bigint null,
        State char(12) null,
        TxnCreateTime char(26) null,
        ConnHandle unsigned bigint null,
        IQConnID unsigned bigint null,
        Dbremote bit not null,
        CursorCount unsigned bigint null,
        SpCount unsigned bigint null,
        SpNumber unsigned bigint null,
        MainTableKBCreated unsigned bigint null,
        MainTableKBDropped unsigned bigint null,
        TempTableKBCreated unsigned bigint null,
        TempTableKBDropped unsigned bigint null,
        MainWorkSpaceKB unsigned bigint null,
        )
        in SYSTEM on commit preserve rows;
    declare local temporary table iq_status_main(
        Name varchar(40) null,
        Value varchar(128) null,
        )
        in SYSTEM on commit preserve rows;
    set CurrTime=“left“(convert(varchar(30),getdate(*),115),16);

    execute immediate ‚iq utilities main into iq_status_main status‘;
select substring(Value,cast(locate(Value,‘=‘) as tinyint)+1,length(Value)) into
versionsize
from iq_status_main where name like ‚%Other%‘ order by Name asc;
select Value into versionsize from iq_status_main where name = ‚Other Versions:‘;
call sp_iqspaceused(maintotal,mainused,temptotal,tempused);
set databasename=db_name(*);
set servername=@@servername;
// IQ main store free space > FreeMainSpace then return. If it is < FreeMainSpace
// then drop the connection which is taking maximum main space.
if cast(100-(mainused*100/maintotal) as integer) > FreeMainSpace then
drop table m_iq_txn_table;
drop table iq_status_main;
return
end if;
select first block_size/512 into blocksizeX2 from SYSIQINFO;
execute immediate ‚iq utilities main into m_iq_txn_table command statistics 10000‘;
//Drop connection only when they could release some amount of space.
select top 1 ConnHandle,
connection_property(‚Name‘,connHandle) as Name,
connection_property(‚Userid‘,connHandle) as Userid,
max(cast(MainTableKBCreated*blocksizeX2/2 as unsigned bigint)+cast(MainTableKBDropped*
blocksizeX2/2 as unsigned bigint)) as MainWorkSpaceKB into connid,
connname,connuserid,
TempKB from m_iq_txn_table where
MainTableKBCreated > 0 and
Userid <> ‚DBA‘ and
MainTableKBCreated > MainTableKBDropped
group by ConnHandle order by
MainWorkSpaceKB desc;
if connid is not null then
execute immediate ‚drop connection ‚ || connid;
set MsgText=‘echo ‚ || CurrTime || ‚ IQ Main free space of: ‚ ||
cast(cast(100-(mainused*100/maintotal) as numeric(5,2)) as varchar(10)) || ‚% ‚ ||
‚>> ‚ || LogFile;
call xp_cmdshell(MsgText);
set MsgText=‘echo ‚ || CurrTime || ‚ IQ Temp free space of: ‚ ||
cast(cast(100-(tempused*100/temptotal) as numeric(5,2)) as varchar(10)) || ‚% ‚ ||
‚>> ‚ || LogFile;
call xp_cmdshell(MsgText);
set MsgText=‘echo ‚ || CurrTime || ‚ IQ Versioning Size : ‚ || cast(versionsize as
varchar(30)) || ‚>> ‚ || LogFile;
call xp_cmdshell(MsgText);