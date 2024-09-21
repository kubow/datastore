SAP IQ - Tap into Big Data:
- Speed & Flexibility
	- Faster, Ad-hoc and realtime optimized, for unstructured data
- Lower TCO
	- Compression up to 70%, lower maintenanance
- Exploit value of Big data
- Transforming businesses through deeper insights
- Extend power of analytics across entire enterprise


# SAP IQ System parts

[![](https://mermaid.ink/img/pako:eNp1kkFvwjAMhf-KlRNMlInuVqFJQC-TQNoo2qXl4DYGojVpSdINBPz3pbTbgG29xHLep_fi-sCyghML2CovPrINagvTeaIATJWuNZYbiOavcTR6hqcXiEi_k17W1wBcaMqsKBQsxk3nGxkP4hAtpmgIViIn0yLX2Hjx0w0HcSdhzmKGQkFkC03DVD927vpi201Ydwl970Ltt-pobyzJ-4kzy4v1FcdT8GAUjf6gH1p6QbIsNOr9jaGV5ZlqEFL89nl-PHVu_7_sayD1N42bqYELuISd5-0u7gZxE0SjMtiwTtYGcZWL8YvxG2ZGxuCaLvRiK82ZuMrdHqHveY_OsK4nuSBlDQy9vusdNW0rMtYc618NiWI9JklLFNytxaEGEmY3JClhgSs56reEJerkdFjZItqrjAVWV9RjVcnRUijQDUqyYIW5cV3iws131uzZed1On4Okv-k)](https://mermaid.live/edit#pako:eNp1kkFvwjAMhf-KlRNMlInuVqFJQC-TQNoo2qXl4DYGojVpSdINBPz3pbTbgG29xHLep_fi-sCyghML2CovPrINagvTeaIATJWuNZYbiOavcTR6hqcXiEi_k17W1wBcaMqsKBQsxk3nGxkP4hAtpmgIViIn0yLX2Hjx0w0HcSdhzmKGQkFkC03DVD927vpi201Ydwl970Ltt-pobyzJ-4kzy4v1FcdT8GAUjf6gH1p6QbIsNOr9jaGV5ZlqEFL89nl-PHVu_7_sayD1N42bqYELuISd5-0u7gZxE0SjMtiwTtYGcZWL8YvxG2ZGxuCaLvRiK82ZuMrdHqHveY_OsK4nuSBlDQy9vusdNW0rMtYc618NiWI9JklLFNytxaEGEmY3JClhgSs56reEJerkdFjZItqrjAVWV9RjVcnRUijQDUqyYIW5cV3iws131uzZed1On4Okv-k)
**Dbspace**: logical name for a container of files or raw partitions called dbfiles (temporary store has exactly 1 dbspace, other more with IQ_VLDBMGMT option purchased).
**Dbfile**: operating system file contained within a dbspace (RLV_STORE and SYSTEM contain one dbfile, others multiple).

Pro vlastní ukládání dat jsou použity **dbspaces**, jejichž přehled uvádí následující tabulka:

| Store            | Dbspace            | typ uložených dat                                                                                                                                                       |     |
| ---------------- | ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| **IQ Main**      | **IQ_SYSTEM_MAIN** | Databázová struktura, <br> metadata pro incremental bacup, <br> data pro database space/identity                                                                        |     |
|                  | USER_DBSPACES      | Tabulky a metadata, <br> indexy polí a joinů                                                                                                                            |     |
| **IQ Catalog**   | SYSTEM catalog     | Systémové tabulky a pohledy, <br> uložené procedury, <br> ASA tabulky a definice funkcí                                                                                 |     |
|                  | Other catalog      | ASA tabulky                                                                                                                                                             |     |
| **IQ Temporary** | **IQ_SYSTEM_TEMP** | Soubor dočasných souborů <br> které definují dočasný dbspace                                                                                                            |     |
|                  | IQ_SYSTEM_MSG      | Externí soubor držící zprávy <br>o aktivitě databáze                                                                                                                    |     |
|                  | IQ_SHARED_TEMP     | Sdílený dočasný prostor pro <br> zjednodušení multiplex operací ([wiki](https://wiki.scn.sap.com/wiki/display/SYBIQ/IQ+Shared+System+Temporary+Store+-+IQ_SHARED_TEMP)) |     |
|                  | RLV_DBSPACE        | RLV transakční logy                                                                                                                                                     |     |

These are SAP IQ server/database permanent logs and optional trace files:

| Trace file | Name | Number | optional | click me | click me |
|------------|------|--------|----------|----------|----------| 
| Message log file | Dbname.iqmsg | 1 or many | No |  in .db directory or dbspace IQ_SYSTEM_MSG  | continuous  |
| Server log file  | server.nnnn.srvlog  | 1 every server cycle  | No  | $IQLOGDIR16  if defined. $IQDIR16/logfiles directory otherwise  | continuous  |
| Standard system output  | server.nnnn.stderr  | 1 for every cycle  | No  | $IQLOGDIR16  if defined. $IQDIR16/logfiles directory otherwise  | continuous  |
| Stacktrace  | stktrc-YYYYMMDD-HHNNSS_#.iq  | 1 per event or per request  | Yes and under specific conditions  | Directory where db started  | One-shot  |
| Html Query plan  |  query_name.html  | 1 per per request  | Yes  | Directory where db started. Can be specified with sql option QUERY_PLAN_AS_HTML_DIRECTORY  | One-shot  |
| Backup log  |  .backup.syb  | 1  |   |  $IQLOGDIR16  |  continuous  |
| Connection trace  | To be specified by DBA/user  | 1 per connection  | Yes  | directory where the client apllication started  | Duration of connection  |
| Sql log  | To be specified by DBA  | 1 or many  | Yes  |    |    |

[IQ Log Files](https://help.sap.com/saphelp_iq1608_iqintro/helpdata/en/a4/458b4184f21015969eeef6dad5820c/frameset.htm?frameset=/en/a4/44fa8784f210159103c323abc60b82/frameset.htm)

Součásti produktu:

- SAP IQ Server Components
	- SAP IQ Server
	- SAP Control Center (deprecated)
	- [SAP IQ Cockpit](https://help.sap.com/docs/SAP_IQ/14180868751e10149705b0ef6818ec08/5536c2c36e244afeaa8dc483d5a63f5d.html?version=16.1.1.0)
	- SySAM utilities
- SAP IQ Client Components
	- Interactive SQL
	- [isql](https://help.sap.com/docs/SAP_IQ/a893062984f21015b9e8b03f96ed0cbb/a2749f8784f21015b3ad89edd5ed5bf0.html?version=16.1.1.0) (a další [utility](https://help.sap.com/docs/SAP_IQ/a893062984f21015b9e8b03f96ed0cbb/1478006e20e54b359889483512791d9e.html?version=16.1.1.0))
	- SAP IQ Web Drivers
	- SAP IQ ODBC Driver
	- SAP jConnect for JDBC


## Database
[Before you create a database](https://help.sap.com/docs/SAP_IQ/a8937bea84f21015a80bc776cf758d50/a6fc27ef84f21015bb99a329a7118b34.html?version=16.1.1.0)

Možnosti vytvoření databáze:


[CREATE DATABASE Statement](https://help.sap.com/saphelp_iq1610_iqrefso/helpdata/en/a6/16791184f210158207cc6972cf879d/frameset.htm)
[CREATE DATABASE Defaults](https://help.sap.com/docs/SAP_IQ/a8937bea84f21015a80bc776cf758d50/a6fe2d0884f210158733eba14e7e0dee.html?version=16.1.1.0)
[IQ database Options - SAP IQ - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBIQ/IQ+database+Options)


## Tables


## Views


## Procedures



```
call sa_eng_properties;

call sa_server_option('parameter_name', 'value');

select * from sa_db_properties();

select * from SYS.SYSINFO;

sp_iqstatus;

sp_iqlmconfig;
```