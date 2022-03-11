#!bin/bash
isql -U${USERNAME} -P${PASSWORD} -S${SQL_SERVER} -w1000 << ! > ${LOG_FILE}
     exit
     !
   if [[ $? != 0 ]]
   then
       msg="`date` ${SQL_SERVER} problem. ${SQL_SERVER} on ${HOST} is down or cannot be accessed"
   cat ${LOG_FILE}|/usr/bin/mailx -s "${msg}" ${SUPPORT}
   }
   exit 1
   fi 
