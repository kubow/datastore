$db_file = "C:\_Run\Script\H808E_tab.db"
$dump_file = "C:\_Run\H808E.sql"
$work_path="C:\_Run\"
$PASSWORD = "Aaa123456"
$port = "5432"
$drop_db = "DROP DATABASE H808E;"
$create_db = "CREATE DATABASE H808E WITH ENCODING='UTF8';"
$seq_db = "CREATE TABLE IF NOT EXISTS sqlite_sequence (name TEXT,seq INTEGER);"
$psql = "C:\_Run\App\Database\PostgreSQL\10\bin\psql.exe"

C:\_Run\App\Database\SQLite\sqlite3.exe $db_file .dump > $dump_file

# Replace
# INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT -> SERIAL
(Get-Content $dump_file).replace('INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE', 'SERIAL') | Set-Content $dump_file
(Get-Content $dump_file).replace('INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT', 'SERIAL') | Set-Content $dump_file
# DATETIME -> TIMESTAMP
(Get-Content $dump_file).replace('DATETIME', 'TIMESTAMP') | Set-Content $dump_file
# '' -> NULL
(Get-Content $dump_file).replace("''", 'NULL') | Set-Content $dump_file
# ` -> 
(Get-Content $dump_file).replace('`', '') | Set-Content $dump_file
# NUM -> TEXT
(Get-Content $dump_file).replace('NUM,', 'TEXT,') | Set-Content $dump_file
# remove first pragma line
(Get-Content $dump_file).replace('PRAGMA foreign_keys=OFF;', '') | Set-Content $dump_file

#psql -U postgres -h localhost -d postgres -c "DROP DATABASE H808E;" <<-EOF
#$PASSWORD
#EOF
Write-Host "SQL prepared, begin to import to postgres"

Set PGPASSWORD=$PASSWORD 
#Start-process $psql -ArgumentList "-h localhost", "-U postgres", "-d postgres", "-P $port", "-c '$drop_db'"
Write-Host "-h localhost -U postgres -d postgres -p $port -c '$drop_db'"
Start-process -Wait $psql -ArgumentList "-h localhost -U postgres -d postgres -p $port -c ""$drop_db" -RedirectStandardOutput $work_path+output.txt -RedirectStandardError $work_path+err.txt
Write-Host "postgres database h808e deleted"
#Start-process $psql -ArgumentList "-h localhost", "-U postgres", "-d postgres", "-P $port", "-c '$create_db'"
Start-process -Wait $psql -ArgumentList "-h localhost -U postgres -d postgres -p $port -c ""$create_db" -RedirectStandardOutput $work_path+output.txt -RedirectStandardError $work_path+err.txt
Write-Host "postgres database h808e created"
#Start-process $psql -ArgumentList "-h localhost", "-U postgres", "-d h808e", "-P $port", "-c '$seq_db'"
Start-process -Wait $psql -ArgumentList "-h localhost -U postgres -d h808e -p $port -c ""$seq_db" -RedirectStandardOutput $work_path+output.txt -RedirectStandardError $work_path+err.txt
Write-Host "postgres table sequence in database h808e created"
#Start-process $psql -ArgumentList "-h localhost", "-U postgres", "-d h808e", "-P $port", "-f $dump_file"
Start-process -Wait $psql -ArgumentList "-h localhost -U postgres -d h808e -p $port -f $dump_file" -RedirectStandardOutput $work_path+output.txt -RedirectStandardError $work_path+err.txt
Write-Host "postgres data imported to database h808e"