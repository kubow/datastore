@ECHO ON
Common\Chngset.exe Common\settings.txt
REM The script sets environment variables helpful for PostgreSQL
cd "%~dp0\Postgres\9.3"
@SET PATH="%~dp0\Postgres\9.3\bin";%PATH%
@SET PGDATA=%~dp0\Postgres\9.3\data
@SET PGDATABASE=postgres
@SET PGUSER=postgres
@SET PGPORT=5439
@SET PGLOCALEDIR=%~dp0\share\locale
REM "%~dp0\bin\initdb" -U postgres -A trust
"%~dp0\Postgres\9.3\bin\pg_ctl" -D "%~dp0/Postgres/9.3/data" -l logfile -o "-p 5439" start
ECHO "Click enter to stop"
pause
"%~dp0\Postgres\9.3\bin\pg_ctl" -D "%~dp0/Postgres/9.3/data" -o "-p 5439" stop
cd ..
cd ..
Common\Restset.exe Common\settings.txt
