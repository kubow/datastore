#!/bin/sh
#
# Startup script for Sybase ASE
# 
# description: Sybase Adaptive Server Enterprise
# is a SQL database server.
# processname: dataserver
  

SYBASE=/opt/sybase
SERVER=JAVIERATMAC
  

# Source environment variables.
. $SYBASE/SYBASE.sh
  

# Find the name of the script
NAME=`basename $0`
  

# For SELinux we need to use 'runuser' not 'su'
if [ -x /sbin/runuser ]
then
    SU=runuser
else
    SU=su
fi
  

start() {
    SYBASE_START="Starting ${NAME} service: "
    $SU sybase -c ". $SYBASE/SYBASE.sh; $SYBASE/$SYBASE_ASE/install/startserver \
-f $SYBASE/$SYBASE_ASE/install/RUN_${SERVER} > /dev/null"
    ret=$? 
    if [ $ret -eq 0 ]
    then
        echo "$SYBASE_START Success."
    else
        echo "$SYBASE_START Failed!"
              exit 1
    fi
}
  

stop() {
    echo -n "Stopping ${NAME} service: "
    $SU sybase -c ". $SYBASE/SYBASE.sh; isql -S $SERVER -U sa -P '' < \
$SYBASE/$SYBASE_ASE/upgrade/shutdown.sql > /dev/null"
    ret=$?
    if [ $ret -eq 0 ]
    then
        echo "Success."
    else
        echo "Failed!"
        exit 1
    fi
}
  

restart() {
    stop
    start
}

status() {
    SYBASE_STATUS="Status: "
    $SU sybase -c ". $SYBASE/SYBASE.sh; $SYBASE/$SYBASE_ASE/install/showserver"
    echo

    ret=$?
    if [ $ret -ne 0 ]
    then
        echo "${SYBASE_STATUS} Failed!"
        exit 1
    fi
}
  

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart}"
        exit 1
esac
exit 0