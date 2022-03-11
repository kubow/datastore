# Below is a code snippet as example of Internal IP monitor with Email Alerting Enabled.

VAR_PING=`ping -c4 $HOST_PRVIATE_IP | grep loss | cut -d',' -f3 | cut -d'%' -f1 | cut -d' ' -f2`
if [ $VAR -gt 0 ]
then
echo "PING: Packets Loss $VAR_PING%" > /monitor_log.txt
fi

Value=`ls -ltrh /monitor_log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /ping_monitor_log.txt | mail -s "Email Alert: Private IP Ping" ${SYS_ADMIN_EMAIL}
fi

rm -rf /$monitor_log.txt
exit 0

# Below is a code snippet as example of Disk Space Usage monitor with Email Alerting Enabled.

DISK=`ssh ${HOST_USER}@${HOST_PUBLIC_IP} "df -h /Path_to_Disk | tail -1" | awk '{print $4}' | cut -d'%' -f1`

if [[ "$DISK" > 80 ]]
then
echo "Disk Space is almost full : $DISK %" >> /Path_To_Result_Log.txt
fi

Value=`ls -ltrh /Path_To_Result_Log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Path_To_Result_Log.txt | mail -s "Email Alert: Disk " ${SYS_ADMIN_EMAIL}
fi

rm -rf /Path_To_Result_Log.txt
exit 0
    
# Below is a code snippet as example of Physical Memory Usage monitor with Email Alerting Enabled.

VAR_TOTAL=`ssh ${HOST_USER}@${HOST_PUBLIC_IP} "free -g | grep Mem | cut -d' ' -f13"`
VAR_USED=`ssh ${HOST_USER}@${HOST_PUBLIC_IP} "free -g | grep buffers | cut -d' ' -f11 | tail -1"`
VAR_RESULT=` echo "( ( $VAR_USED / $VAR_TOTAL ) * 100 )" | bc -l | cut -d'.' -f1`

if [[ "$VAR_RESULT" -ge 89 ]]
then
echo "Physical Memory Utilization is high : $RESULT %" > /Path_To_Result_Log.txt
fi

Value=`ls -ltrh /Path_To_Result_Log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Path_To_Result_Log.txt | mail -s "Email Alert: Memory" ${SYS_ADMIN_EMAIL}
fi

rm -rf /Path_To_Result_Log.txt
exit 0

# Below is a code snippet as example of CPU Top Load monitor with Email Alerting Enabled.

VAR_CPU=`ssh -t ${HOST_USER}@${HOST_PUBLIC_IP} "top | head -n3 | grep Cpu | cut -d":" -f2 | cut -d',' -f1 | cut -d' ' -f3 | cut -d'.' -f1" 2> /dev/null`
if [[ "$VAR_CPU" > 70 ]]
then
echo "CPU Utilization is high : $VAR_CPU %" > /Path_To_Result_Log.txt
fi

Value=`ls -ltrh /Path_To_Result_Log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Path_To_Result_Log.txt  | mail -s "Email Alert:CPU" ${SYS_ADMIN_EMAIL}
fi

rm -rf /Path_To_Result_Log.txt
exit 0

# Below is a code snippet as example of Tomcat Process Availability monitor with Email Alerting Enabled.

VAR=`ssh ${HOST_USER}@${HOST_PUBLIC_IP} "ps -ef | grep -v grep | grep tomcat"`
if [ -z "$VAR" ]
then
echo "Tomcat Service isn't available" > /Path_to_Result_Log.txt
fi

Value=`ls -ltrh /Path_To_Result_Log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Path_To_Result_Log.txt | mail -s "Email Alert: Process" ${SYS_ADMIN_EMAIL}
fi

rm -rf /Path_To_Result_Log.txt
exit 0

# Below is a code snippet as example of Tomcat Port Availability monitor with Email Alerting Enabled.

VAR=`nmap -p <Incorta_Port> -n 1.2.3.4 | grep <Incorta_Port>`
if [  -z "$VAR" ]
then
echo "Incorta Port is Down" > /Path_To_Result_Log.txt
fi

Value=`ls -ltrh /Path_To_Result_Log.txt  | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Path_To_Result_Log.txt | mail -s "Email Alert: Port" ${SYS_ADMIN_EMAIL}
fi


rm -rf /Path_To_Result_Log.txt
exit 0

# Below is a code snippet as example of Catalina Error Codes monitor with Email Alerting Enabled. The scrpiot us designed with a simple algorithm to avoid the repeat of same error capture.

ssh ${HOST_USER}@${HOST_PUBLIC_IP} "grep -e 'INC_003002001\|INC_003003001\|INC_003007001\|INC_003004001\|INC_003005001\|INC_004004001\|INC_004005004\|INC_004006001\|INC_004008001\|INC_004009001' /Target_server_catalina.out" > /Result_mon1.txt
diff /Result_mon1.txt /Result_mon2.txt > /Final_result.txt
cp /Reuslt_mon1.txt /Result_mon2.txt

Value=`ls -ltrh /Final_result.txt   | awk '{print $5}'`
if [[ "$Value" > 0 ]]
then
cat /Final_result.txt  | mail -s "Email Alert: Error codes" ${SYS_ADMIN_EMAIL}
fi

exit 0