@echo off
SET pg_folder="C:\Program Files (x86)\PostgreSQL\9.3\bin\"
set host=localhost

IF /I '%1%'=='r' GOTO reindex
IF /I '%1%'=='s' GOTO SQL
IF /I '%1%'=='v' GOTO vacuum
IF /I '%1%'=='b' GOTO backup
IF /I '%1%'=='h' GOTO help

GOTO MENU

:MENU
echo Proceed with postgre SQL task
echo 1st parameter: run type
echo   r - reindex
echo   s - run SQL query
echo   v - vacuum database
echo   b - backup database
echo   h - show help
echo 2nd parameter: optional (db name)
echo 3rd parameter: optional (script name)
GOTO QUIT

:reindex
SET db_name=%2
if [%2]==[] SET db_name=postgres
%pg_folder%reindexdb.exe --host=%host% --dbname=%db_name% --username=postgres
echo done reindex
GOTO QUIT

:SQL
SET db_name=%2
if [%2]==[] SET db_name=postgres
SET sql_file=%3
if [%3]==[] SET sql_file=import.sql
%pg_folder%psql.exe --host=%host% --dbname=%db_name% --username=postgres --file=%sql_file% --output=>>logfile.log
echo done run SQL file
GOTO QUIT

:vacuum
SET db_name=%2
if [%2]==[] SET db_name=postgres
%pg_folder%VACUUMdb.exe --host=%host% --dbname=%db_name% --username=postgres
echo done vacuum
GOTO QUIT

:backup
SET db_name=%2
if [%2]==[] SET db_name=postgres
SET bck_file=%3
if [%3]==[] SET bck_file=backup.dmp
%pg_folder%pg_dump.exe --host=%host% --dbname=%db_name% --username=postgres --port=5432 --no-password --format=custome --blobs --file=%sql_file% --output=>>logfile.log
echo done backup
GOTO QUIT

:help
%pg_folder%psql.exe --help
GOTO QUIT

:QUIT
echo PG_PATH:%pg_folder%
echo 1ST:%1
echo 2ND:%2
echo 3RD:%3
REM EXIT
