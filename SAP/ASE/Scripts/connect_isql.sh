#!/usr/bin/sh
LOGFILE=/home/sybase/auto_sybase.log
SYBPAT=/sybase/ase157/ASE-15_0/install/
SUPPORT="jakub.vajda@mdsaptech.cz"
USERNAME="sa"
PASSWORD=$(<.fdsk)
SERVER="t2k_ds"

# export transaction log
#bcp master..syslogs out transaction_log.trn -S${SERVER} -U${USERNAME}<< EOF
#${PASSWORD}

echo Starting new script > ${LOGFILE}

#isql -U${USERNAME} -P${PASSWORD} -S${SERVER} -w1000 >> ${LOGFILE}
#exit

results=`isql -Usa -St2k_ds <<-EOF

select name from sysobjects where type = "U"
go
exit
EOF
`


echo ${results}
exit
${results} >> ${LOGFILE}
echo done...
