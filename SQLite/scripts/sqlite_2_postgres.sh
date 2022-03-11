db_file=/home/kubow/Documents/Script/H808E_tab.db
dump_file=/home/kubow/Documents/H808E.sql
PASSWORD=Aaa123456
drop_db="DROP DATABASE H808E;"
create_db="CREATE DATABASE H808E WITH ENCODING='UTF8';"
seq_db="CREATE TABLE IF NOT EXISTS sqlite_sequence (name TEXT,seq INTEGER);"


sqlite3 ${db_file} .dump > ${dump_file}

# Replace
# INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT -> SERIAL
sed 's/INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE/SERIAL/g' ${dump_file} > ${dump_file}
sed 's/INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT/SERIAL/g' ${dump_file} > ${dump_file}
# DATETIME -> TIMESTAMP
sed 's/DATETIME/TIMESTAMP/g' ${dump_file} > ${dump_file}
# '' -> NULL
sed "s/''/NULL/g" ${dump_file} > ${dump_file}
# ` -> 
sed 's/`//g' ${dump_file} > ${dump_file}
# NUM -> TEXT
sed 's/NUM/TEXT/g' ${dump_file} > ${dump_file}
# remove pragma line
sed 's/PRAGMA foreign_keys=OFF;//g' ${dump_file} > ${dump_file}

#psql -U postgres -h localhost -d postgres -c "DROP DATABASE H808E;" <<-EOF
#$PASSWORD
#EOF

PGPASSWORD=${PASSWORD} psql -U postgres -h localhost -d postgres -c "${drop_db}"

PGPASSWORD=${PASSWORD} psql -U postgres -h localhost -d postgres -c "${create_db}"

PGPASSWORD=${PASSWORD} psql -U postgres -h localhost -d postgres -c "${seq_db}"

PGPASSWORD=${PASSWORD} psql -U postgres -d h808e -W < ${dump_file}
