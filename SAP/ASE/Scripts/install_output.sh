mkdir ~/cd
cd ~/cd
gunzip -dc /hgfs/SybaseSW/ASE15.7/ASE157SP062_Solx64-20011147.tgz | tar -xvf -
cd ~/cd/ebf22600/
./setup.bin
cp /sybase/ase157/ASE-15_0/init/sample_resource_files/srvbuild.adaptive_server.rs t2k_ds.rs
cp /sybase/ase157/ASE-15_0/init/sample_resource_files/srvbuild.backup_server.rs t2k_bs.rs
vi *.rs
mkdir /sybase/data
. $SYBASE/SYBASE.sh
/sybase/ase157/ASE-15_0/bin/srvbuildres -r t2k_ds.rs
/sybase/ase157/ASE-15_0/bin/srvbuildres -r t2k_bs.rs
isql -U sa -S t2k_ds -w 9999 <<-EOF
        sybase
        sp_configure "minimum password length", 0
        go
        sp_password sybase, NULL
        go
        disk init name="dsk01", physname="/sybase/data/t2k_dsk01.dat", vdevno=4,
          size=512000
        go
        disk init name="dsk02", physname="/sybase/data/t2k_dsk02.dat", vdevno=5,
          size=256000
        go
        create database pubtune_db
          on dsk01=50 log on dsk02=10
        go
        exit
        EOF

cp t2k_ds.rs t8k_ds.rs
vi t8k_ds.rs
/sybase/ase157/ASE-15_0/bin/srvbuildres -r t8k_ds.rs
isql -U sa -S t8k_ds -w 9999 <<-EOF
        sybase
        sp_configure "minimum password length", 0
        go
        sp_password sybase, NULL
        go
        disk init name="dsk01", physname="/sybase/data/t8k_dsk01.dat", vdevno=4,
          size=128000
        go
        disk init name="dsk02", physname="/sybase/data/t8k_dsk02.dat", vdevno=5,
          size=64000
        go
        create database pubtune_db
          on dsk01=50 log on dsk02=10
        go
        exit
        EOF
cp /hgfs/edb634/scripts/unix/create_pubtune_db.sql pubtune.ddl
vi pubtune.ddl
isql -U sa -S t2k_ds -w 9999 -i pubtune.ddl -o pubtune.ddl.out