#!/bin/sh
#
# Rcs_ID="$RCSfile: syback.sh,v $"
# Rcs_ID="$Revision: 1.3 $ $Date: 1998/03/23 06:00:44 $"
#
# Copyright (c) 1998 Curtis Preston curtis@colltech.com
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# For a copy of the license, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139
#
##############################################################################
# TITLE:      Sybase Backup Script
# AUTHOR(S):  R. Neill Carter
# CREATE DATE:  03/20/98
# DESCRIPTION: syback.sh will perform either full dumps or transaction dumps
#              against all databases specified.  If a database is not given,
#              all databases will be affected. These dumps will be output to
#              either the disk or tape device specified. The logfile created
#              by this script is also determined by the user.
# DEPENDENCIES: config.guess
#               localpath.sh
#               syback.conf
#
##############################################################################

##############################################################################
#
# TOP LEVEL DESCRIPTION OF LOGICAL FLOW
#
##############################################################################
#
#       1) User defined variables. (52)
#	2) System defined variables. (60)
#	3) Check arguments and assign values. (155)
#         3-1) Time evlauation. (165)
#         3-2) Backup class value assignments. (256)
#         3-3) Dump device value assignments. (321)
#	4) Check argument settings for validity. (422)
#         4-1) Validate SYBASE_DIR. (471)
#         4-2) Validate INTERFACES. (515)
#         4-3) Validate SYBASE_SERVER. (551)
#         4-4) Validate LOG_FILE_NAME. (599)
#         4-5) Validate SYBASE_USER. (628)
#         4-6) Validate SYBASE_PASSWORD. (640)
#         4-7) Validate SYBASE_USER/SYBASE_PASSWORD login. (653)
#         4-8) Validate DEVICE_TYPE. (674)
#         4-9) Validate DUMP_TYPE. (739)
#         4-10) Validate DATABASE_NAME (775)
#         4-11) Print Message Logs. (788)
#         4-12) Compose Mail if Validation Failure (825)
#	5) Generate list of databases. (848)
#       6) Build the SQL Query. (937)
#	7) Backup databases. (1246)
#       8) Compose Mail if Backup Failure (1279)
#	9) Exit.
#
##############################################################################

##############################################################################
#
#                          User Defined Variables
#
##############################################################################

CONFIG_FILE=./syback.conf

##############################################################################
#
#                         System Defined Variables
#
##############################################################################

BACKUP_CLASS_LINE=`egrep "\-c" $CONFIG_FILE | grep -v "#"`
TAPE_CLASS_LINE=`egrep "\-t" $CONFIG_FILE | grep -v "#"`
DIRECTORY_CLASS_LINE=`egrep "\-d" $CONFIG_FILE | grep -v "#"`
INFORMATION_MESSAGES_LOG=/tmp/INFORMATION_MESSAGES_LOG
BINDIR=`egrep "BINDIR=" $CONFIG_FILE | awk -F"=" '{print $2}'`
ADMIN=`egrep "ADMIN=" $CONFIG_FILE | awk -F"=" '{print $2}'`
SUCCESSMAIL=`egrep "SUCCESSMAIL=" $CONFIG_FILE | awk -F"=" '{print $2}'`
FAILMAIL=`egrep "FAILMAIL=" $CONFIG_FILE | awk -F"=" '{print $2}'`
FATAL_MESSAGES_LOG=/tmp/FATAL_MESSAGES_LOG
CONFIG_COUNTER=0
SCRIPT=`basename $0`
TMP=/usr/tmp
X=$$
ARGS=$*
CURRENT_LOG_FILE=/tmp/current_log_file
HOSTNAME=`uname -n 2>/dev/null|awk -F. '{print $1}'`
 [ -n "$HOSTNAME" ] || HOSTNAME=`hostname|awk -F. '{print $1}'`
 if [ -n "$HOSTNAME" ] || ; then
  echo "Could not determine hostname!" ; exit 1
 fi

if [ -s $BINDIR/config.guess ] ; then
 SERVER_OSnR=`$BINDIR/config.guess|awk -F'-' '{print $3}'`
 export SERVER_OSnR
else
 echo $BINDIR"/config.guess not found!"
 echo "Check BINDIR in syback.conf and re-execute."
 exit 1
fi


PATH=/bin:/usr/bin:/etc:/bin:/usr/ucb:/usr/sbin:/sbin:/usr/bsd:/usr/local/bin
export PATH

if [ -s $BINDIR/localpath.sh ] ; then
 . $BINDIR/localpath.sh
else
 echo $BINDIR"/localpath.sh not found!"
 echo "Check BINDIR in syback.conf and re-execute."
 exit 1
fi

export SERVER_OSnR ADMINS SUCCESSMAIL SCRIPT X ARGS TMP DAY TMPDF DEVSHORT
export BACKUP_CLASS_LINE TAPE_CLASS_LINE DIRECTORY_CLASS_LINE
export INFORMATION_MESSAGES_LOG BINDIR ADMIN SUCCESSMAIL FATAL_MESSAGES_LOG
export CONFIG_COUNTER FAILMAIL

CURRENT_MINUTE=`date '+%M'`
CURRENT_HOUR=`date '+%H'`
CURRENT_DOM=`date '+%d'`
CURRENT_MONTH=`date '+%m'`
CURRENT_DOW=`date|awk '{print $1}'`

case $CURRENT_MINUTE in
 00 ) CURRENT_MINUTE=0;;
 01 ) CURRENT_MINUTE=1;;
 02 ) CURRENT_MINUTE=2;;
 03 ) CURRENT_MINUTE=3;;
 04 ) CURRENT_MINUTE=4;;
 05 ) CURRENT_MINUTE=5;;
 06 ) CURRENT_MINUTE=6;;
 07 ) CURRENT_MINUTE=7;;
 08 ) CURRENT_MINUTE=8;;
 09 ) CURRENT_MINUTE=9;;
esac

case $CURRENT_HOUR in
 00 ) CURRENT_HOUR=0;;
 01 ) CURRENT_HOUR=1;;
 02 ) CURRENT_HOUR=2;;
 03 ) CURRENT_HOUR=3;;
 04 ) CURRENT_HOUR=4;;
 05 ) CURRENT_HOUR=5;;
 06 ) CURRENT_HOUR=6;;
 07 ) CURRENT_HOUR=7;;
 08 ) CURRENT_HOUR=8;;
 09 ) CURRENT_HOUR=9;;
esac

case $CURRENT_DOW in
 Sun ) CURRENT_DOW=0;;
 Mon ) CURRENT_DOW=1;;
 Tue ) CURRENT_DOW=2;;
 Wed ) CURRENT_DOW=3;;
 Thu ) CURRENT_DOW=4;;
 Fri ) CURRENT_DOW=5;;
 Sat ) CURRENT_DOW=6;;
esac

export CURRENT_MINUTE CURRENT_HOUR CURRENT_DOM CURRENT_MONTH CURRENT_DOW

##############################################################################
#
#                     Check Arguments and Assign Values
#
##############################################################################

##############################################################################
#
# This section evaluates the time attributes for each class and determines if
# they match the current datetime.
#
# Variables Used : C_MINUTE        = minute specified in class line
#                  C_HOUR          = hour specified in class line
#                  C_DOM           = day of month specified in class line
#                  C_MONTH         = month specified in class line
#                  C_DOW           = day of week specified in class line
#                  NOTE : C values are transfered to CONFIG values due to
#                         the fact that C values can be a numeric or a '*'
#                  CONFIG_MINUTE   = transfered value of C_MINUTE
#                  CONFIG_HOUR     = transfered value of C_HOUR
#                  CONFIG_DOM      = transfered value of C_DOM
#                  CONFIG_MONTH    = transfered value of C_MONTH
#                  CONFIG_DOW      = transfered value of C_DOW
#                  CURRENT_MINUTE  = current minute
#                  CURRENT_HOUR    = current hour
#                  CURRENT_DOM     = current day of month
#                  CURRENT_MONTH   = current month
#                  CURRENT_DOW     = current day of week
#
##############################################################################

for BACKUP_OPTION in $BACKUP_CLASS_LINE
do
 if [ $BACKUP_OPTION != "-c" ] ; then

  C_MINUTE=`echo $BACKUP_OPTION|awk -F":" '{print $1}'|sed 's/,/ /g'`
  if [ "$C_MINUTE" = \* ] ; then
   CONFIG_MINUTE="$C_MINUTE"
  else
   for X in $C_MINUTE
   do
    if [ "$X" = $CURRENT_MINUTE ] ; then
     CONFIG_MINUTE=$X
    fi
   done
  fi

  C_HOUR=`echo $BACKUP_OPTION|awk -F":" '{print $2}'|sed 's/,/ /g'`
  if [ "$C_HOUR" = \* ] ; then
   CONFIG_HOUR="$C_HOUR"
  else
   for X in $C_HOUR
   do
    if [ "$X" = $CURRENT_HOUR ] ; then
     CONFIG_HOUR=$X
    fi
   done
  fi

  C_DOM=`echo $BACKUP_OPTION|awk -F":" '{print $3}'|sed 's/,/ /g'`
  if [ "$C_DOM" = \* ] ; then
   CONFIG_DOM="$C_DOM"
  else
   for X in $C_DOM
   do
    if [ "$X" = $CURRENT_DOM ] ; then
     CONFIG_DOM=$X
    fi
   done
  fi

  C_MONTH=`echo $BACKUP_OPTION|awk -F":" '{print $4}'|sed 's/,/ /g'`
  if [ "$C_MONTH" = \* ] ; then
   CONFIG_MONTH="$C_MONTH"
  else
   for X in $C_MONTH
   do
    if [ "$X" = $CURRENT_MONTH ] ; then
     CONFIG_MONTH=$X
    fi
   done
  fi

  C_DOW=`echo $BACKUP_OPTION|awk -F":" '{print $5}'|sed 's/,/ /g'`
  if [ "$C_DOW" = \* ] ; then
   CONFIG_DOW="$C_DOW"
  else
   for X in $C_DOW
   do
    if [ "$X" = $CURRENT_DOW ] ; then
     CONFIG_DOW=$X
    fi
   done
  fi


##############################################################################
#
# Completed evaluating datetime information.  If there is a match, the
# following section will print out the class information.
#
# Variables Used : SYBASE_SERVER            = name of Sybase server
#                  DUMP_TYPE                = type of dump {Full | Tran }
#                  SYBASE_USER              = Sybase user
#                  SYBASE_PASSWORD          = Sybase user password
#                  SYBASE_DIR               = Sybase product directory
#                  INTERFACES               = directory with interfaces file
#                  LOG_FILE_NAME            = filename of logfile
#                  DATABASE_NAME            = name(s) of databases to backup
#                  EXCLUDE_NAME             = name(s) of databases to exclude
#                  DEVICE_TYPE              = type of device {Disk | Tape}
#                  DUMP_DEVICE              = logical name of dump device
#                  UNLOAD                   = specified unload option
#                  RETAINDAYS               = specifies retaindays option
#                  INIT                     = specifies init option
#
##############################################################################

  if [ "$CONFIG_MINUTE" = "$CURRENT_MINUTE" -o "$CONFIG_MINUTE" = "*" ] ; then
   if [ "$CONFIG_HOUR" = "$CURRENT_HOUR" -o "$CONFIG_HOUR" = "*" ]      ; then
    if [ "$CONFIG_DOM" = "$CURRENT_DOM" -o "$CONFIG_DOM" = "*" ]        ; then
     if [ "$CONFIG_MONTH" = "$CURRENT_MONTH" -o "$CONFIG_MONTH" = "*" ] ; then
      if [ "$CONFIG_DOW" = "$CURRENT_DOW" -o "$CONFIG_DOW" = "*" ]      ; then

       SYBASE_SERVER=`echo $BACKUP_OPTION|awk -F":" '{print $6}'`
       DUMP_TYPE=`echo $BACKUP_OPTION|awk -F":" '{print $7}'`
       SYBASE_USER=`echo $BACKUP_OPTION|awk -F":" '{print $8}'`
       SYBASE_PASSWORD=`echo $BACKUP_OPTION|awk -F":" '{print $9}'`
       SYBASE_DIR=`echo $BACKUP_OPTION|awk -F":" '{print $10}'`
       INTERFACES=`echo $BACKUP_OPTION|awk -F":" '{print $11}'`
       LOG_FILE_NAME=`echo $BACKUP_OPTION|awk -F":" '{print $12}'`
       DATABASE_NAME=`echo $BACKUP_OPTION|awk -F":" '{print $13}'\
        |sed 's/,/ /g'`
       EXCLUDE_NAME=`echo $BACKUP_OPTION|awk -F":" '{print $14}' \
        |sed 's/,/ /g'`
       DEVICE_TYPE=`echo $BACKUP_OPTION|awk -F":" '{print $15}'`
       DUMP_DEVICE=`echo $BACKUP_OPTION|awk -F":" '{print $16}' \
        |sed 's/,/ /g'`
       UNLOAD=`echo $BACKUP_OPTION|awk -F":" '{print $17}'`
       RETAINDAYS=`echo $BACKUP_OPTION|awk -F":" '{print $18}'`
       INIT=`echo $BACKUP_OPTION|awk -F":" '{print $19}'`

       [ -s $CURRENT_LOG_FILE ] && rm $CURRENT_LOG_FILE

       echo " "                                     |tee -a $CURRENT_LOG_FILE
       echo "**************************************************************"\
        |tee -a $CURRENT_LOG_FILE
       echo "*                 "`date '+DATE: %m/%d/%y TIME: %H:%M:%S'` \
        |tee -a $CURRENT_LOG_FILE
       echo "*          Beginning backup using the following class values"  \
        |tee -a $CURRENT_LOG_FILE
       echo "* "                                    |tee -a $CURRENT_LOG_FILE
       echo "* SYBASE_SERVER       = "$SYBASE_SERVER|tee -a $CURRENT_LOG_FILE
       echo "* DUMP_TYPE           = "$DUMP_TYPE    |tee -a $CURRENT_LOG_FILE
       echo "* SYBASE_USER         = "$SYBASE_USER  |tee -a $CURRENT_LOG_FILE
       echo "* SYBASE_PASSWORD     = "$SYBASE_PASSWORD\
        |tee -a $CURRENT_LOG_FILE
       echo "* SYBASE_DIR          = "$SYBASE_DIR   |tee -a $CURRENT_LOG_FILE
       echo "* INTERFACES          = "$INTERFACES   |tee -a $CURRENT_LOG_FILE
       echo "* LOG_FILE_NAME       = "$LOG_FILE_NAME|tee -a $CURRENT_LOG_FILE
       echo "* DATABASES TO BACKUP = "$DATABASE_NAME|tee -a $CURRENT_LOG_FILE
       echo "* DATABASES TO EXCLUDE= "$EXCLUDE_NAME |tee -a $CURRENT_LOG_FILE
       echo "* DEVICE_TYPE         = "$DEVICE_TYPE  |tee -a $CURRENT_LOG_FILE
       echo "* DUMP_DEVICE         = "$DUMP_DEVICE  |tee -a $CURRENT_LOG_FILE
       echo "* UNLOAD              = "$UNLOAD       |tee -a $CURRENT_LOG_FILE
       echo "* RETAINDAYS          = "$RETAINDAYS   |tee -a $CURRENT_LOG_FILE
       echo "* INIT                = "$INIT         |tee -a $CURRENT_LOG_FILE
       echo "* "                                    |tee -a $CURRENT_LOG_FILE
       echo "* "                                    |tee -a $CURRENT_LOG_FILE

##############################################################################
#
# After printing the class information, the DUMP_DEVICE arguement for that
# class will be parsed and printed.
#
# Variables Used : LOGICAL_DEVICE_NAME_HEADER = logical name of dump device
#                  TAPE_SERVER_HEADER         = Sybase server of tape
#                  TAPE_BACKUP_SERVER_HEADER  = Backup server of tape
#                  DUMP_DEVICE_HEADER         = physical name of tape device
#                  BLOCKSIZE_HEADER           = blocksize of device
#                  CAPACITY_HEADER            = capacity of device
#                  DISK_SERVER_HEADER         = Sybase server of disk
#                  DISK_BACKUP_SERVER_HEADER  = Backup server of disk
#                  DISK_DIRECTORY_HEADER      = directory of disk dump
#                  DEVICE_OPTION_HEADER_COUNT = number of devices
#
##############################################################################

       if [ "$DEVICE_TYPE" = "Tape" -o "$DEVICE_TYPE" = "Disk" ] ; then
        echo "*                 Using the following dump device values"  \
         |tee -a $CURRENT_LOG_FILE
        echo "* "                                   |tee -a $CURRENT_LOG_FILE
       fi

       if [ "$DEVICE_TYPE" = "Tape" ] ; then
        for tape_option_header in $TAPE_CLASS_LINE
        do
         if [ $tape_option_header != "-t" ] ; then
          LOGICAL_DEVICE_NAME_HEADER=`echo $tape_option_header \
           |awk -F":" '{print $1}'`
          TAPE_SERVER_HEADER=`echo $tape_option_header
           |awk -F":"  '{print $2}'`
          TAPE_BACKUP_SERVER_HEADER=`echo $tape_option_header
           |awk -F":" '{print $3}'`
          DUMP_DEVICE_HEADER=`echo $tape_option_header|awk -F":" '{print $4}'`
          BLOCKSIZE_HEADER=`echo $tape_option_header|awk -F":" '{print $5}'`
          CAPACITY_HEADER=`echo $tape_option_header|awk -F":" '{print $6}'`
          DEVICE_OPTION_HEADER_COUNT=0
          for DEVICE_OPTION_HEADER in $DUMP_DEVICE
          do
           if [ "$LOGICAL_DEVICE_NAME_HEADER" = "$DEVICE_OPTION_HEADER" -a \
            $DEVICE_OPTION_HEADER_COUNT -eq 0 ] ; then
            DEVICE_OPTION_HEADER_COUNT=1
            echo "* LOGICAL_NAME         = "$LOGICAL_DEVICE_NAME_HEADER    \
             |tee -a $CURRENT_LOG_FILE
            echo "* SQL_SERVER           = "$TAPE_SERVER_HEADER            \
             |tee -a $CURRENT_LOG_FILE
            echo "* BACKUP_SERVER        = "$TAPE_BACKUP_SERVER_HEADER     \
             |tee -a $CURRENT_LOG_FILE
            echo "* DUMP_DEVICE          = "$DUMP_DEVICE_HEADER            \
             |tee -a $CURRENT_LOG_FILE
            echo "* BLOCKSIZE            = "$BLOCKSIZE_HEADER              \
             |tee -a $CURRENT_LOG_FILE
            echo "* CAPACITY             = "$CAPACITY_HEADER               \
             |tee -a $CURRENT_LOG_FILE
            echo "* "      |tee -a $CURRENT_LOG_FILE
           fi
          done
         fi
        done
       elif [ "$DEVICE_TYPE" = "Disk" ] ; then
        for disk_option_header in $DIRECTORY_CLASS_LINE
        do
         if [ $disk_option_header != "-d" ] ; then
          LOGICAL_DEVICE_NAME_HEADER=`echo $disk_option_header \
           |awk -F":" '{print $1}'`
          DISK_SERVER_HEADER=`echo $disk_option_header|awk -F":" '{print $2}'`
          DISK_BACKUP_SERVER_HEADER=`echo $disk_option_header \
           |awk -F":" '{print $3}'`
          DISK_DIRECTORY_HEADER=`echo $disk_option_header \
           |awk -F":" '{print $4}'`
          DEVICE_OPTION_HEADER_COUNT=0
          for DEVICE_OPTION_HEADER in $DUMP_DEVICE
          do

           if [ "$LOGICAL_DEVICE_NAME_HEADER" = "$DEVICE_OPTION_HEADER" -a \
            $DEVICE_OPTION_HEADER_COUNT -eq 0 ] ; then
            DEVICE_OPTION_HEADER_COUNT=1
            echo "* LOGICAL_NAME          = "$LOGICAL_DEVICE_NAME_HEADER   \
             |tee -a $CURRENT_LOG_FILE
            echo "* SQL_SERVER            = "$DISK_SERVER_HEADER           \
            |tee -a $CURRENT_LOG_FILE
            echo "* BACKUP_SERVER         = "$DISK_BACKUP_SERVER_HEADER    \
            |tee -a $CURRENT_LOG_FILE
            echo "* DIRECTORY             = "$DISK_DIRECTORY_HEADER        \
            |tee -a $CURRENT_LOG_FILE
            echo "* "     |tee -a $CURRENT_LOG_FILE
           fi
          done
         fi
        done
       fi

       echo "**************************************************************"\
        |tee -a $CURRENT_LOG_FILE


##############################################################################
#
#              Validate the variables assigned by the user.
#
# After printing all dump and device class information, the arguements will
# be validated.  As each is evaluated, messages will be sent to an information
# log or a fatal log where appropriate.  After all arguements are validated,
# the information log will be printed and, if it exists, the fatal log as well
# If the fatal log has any entries, this script will skip to the next backup
# class.
#
# Variables Used : INFORMATION_MESSAGES_LOG   = information messages log
#                  FATAL_MESSAGES_LOG         = fatal messages log
#                  SYBASE_DIR_FATAL           = set if SYBASE_DIR invalid
#                  INTERFACES_FATAL           = set if INTERFACES invalid
#                  SYBASE_SERVER_FATAL        = set if SERVER invalid
#                  USER_CHECK_FATAL           = set if USER/PASSWORD invalid
#                  FATAL_FLAG                 = set if any arg is invalid
#                  SYBASE_DIR                 = Sybase product directory
#                  SYBASE                     = taken from user environment
#                  INTERFACES                 = location of interfaces file
#                  SYBASE_SERVER              = Sybase server
#                  DSQUERY                    = taken from user environment
#                  LOG_FILE_NAME              = filename of log file
#                  SYBASE_USER                = Sybase user
#                  SYBASE_PASSWORD            = Sybase user password
#                  USER_CHECK                 = user/password fail or pass
#                  DIRECTORY_OPTION_VALID     = set if disk device invalid
#                  TAPE_OPTION_VALID          = set if tape device invalid
#                  DUMP_TYPE                    = type of dump {Full | Tran}
#                  SYBASE_DUMP_TYPE             = dump prefix {D | T}
#
##############################################################################

       if [ -f $INFORMATION_MESSAGES_LOG ] ; then
        rm $INFORMATION_MESSAGES_LOG
        touch $INFORMATION_MESSAGES_LOG
       else
        touch $INFORMATION_MESSAGES_LOG
       fi

       if [ -f $FATAL_MESSAGES_LOG ] ; then
        rm $FATAL_MESSAGES_LOG
        touch $FATAL_MESSAGES_LOG
       else
        touch $FATAL_MESSAGES_LOG
       fi

       SYBASE_DIR_FATAL=0
       INTERFACES_FATAL=0
       SYBASE_SERVER_FATAL=0
       USER_CHECK_FATAL=0
       FATAL_FLAG=0

##############################################################################
#                           Validate SYBASE_DIR
##############################################################################

       if [ -z "$SYBASE_DIR" ] ; then
        if [ $SYBASE ] ; then
         SYBASE_DIR="$SYBASE"
         if [ ! -d $SYBASE_DIR ] ; then
          echo "* " >> $FATAL_MESSAGES_LOG
          echo $N "* The location of the Sybase directory was not $C" \
           >>$FATAL_MESSAGES_LOG
          echo "specified for this class." >> $FATAL_MESSAGES_LOG
          echo $N "* When not specified, the value comes from \$SYBASE.$C"\
           >> $FATAL_MESSAGES_LOG
          echo "However, the directory taken from \$SYBASE does not exist."\
           >> $FATAL_MESSAGES_LOG
          echo "Please review this value." >> $FATAL_MESSAGES_LOG
          SYBASE_DIR_FATAL=1
          FATAL_FLAG=1
         else
          echo "* " >> $INFORMATION_MESSAGES_LOG
          echo $N "* The location of the Sybase directory was not $C" \
           >>$FATAL_MESSAGES_LOG
          echo "specified for this class." >> $FATAL_MESSAGES_LOG
          echo "* Using value from \$SYBASE - "$SYBASE \
           >> $INFORMATION_MESSAGES_LOG
         fi
        else
         echo "* " >> $FATAL_MESSAGES_LOG
         echo $N "* The location of the Sybase directory was not $C" \
          >>$FATAL_MESSAGES_LOG
         echo "specified for this class." >> $FATAL_MESSAGES_LOG
         echo $N "* When not specified, the value comes from \$SYBASE.$C"\
          >> $FATAL_MESSAGES_LOG
         echo "* \$SYBASE was not found, either.  Please review this value."\
          >> $FATAL_MESSAGES_LOG
         SYBASE_DIR_FATAL=1
         FATAL_FLAG=1
        fi
       elif [ ! -d $SYBASE_DIR ] ; then
        echo "* " >> $FATAL_MESSAGES_LOG
        echo "* The Sybase directory, "$SYBASE_DIR", does not exist."\
         >> $FATAL_MESSAGES_LOG
        echo "* Please review this value." >> $FATAL_MESSAGES_LOG
        SYBASE_DIR_FATAL=1
        FATAL_FLAG=1
       fi

##############################################################################
#                           Validate INTERFACES
##############################################################################

       if [ -z "$INTERFACES" ] ; then
        if [ $SYBASE ] ; then
         INTERFACES="$SYBASE/interfaces"
         if [ -f $INTERFACES ] ; then
          echo "* " >> $INFORMATION_MESSAGES_LOG
          echo "* The location of the interfaces file was not specified for"\
           >> $INFORMATION_MESSAGES_LOG
          echo "* this class.  Using value from \$SYBASE - "$INTERFACES >> \
           $INFORMATION_MESSAGES_LOG
         else
          echo "* " >> $FATAL_MESSAGES_LOG
          echo $N "* The location of the interfaces file was not $C" \
          >> $FATAL_MESSAGES_LOG
          echo "specified for this class." >> $FATAL_MESSAGES_LOG
          echo "* When not specified, this value is taken from \$SYBASE.  "\
           >> $FATAL_MESSAGES_LOG
          echo "* However, $INTERFACES was not found, either.  " \
           $FATAL_MESSAGES_LOG
          echo "Please review this value." >> $FATAL_MESSAGES_LOG
          INTERFACES_FATAL=1
          FATAL_FLAG=1
         fi
        else
         echo "* " >> $FATAL_MESSAGES_LOG
         echo "* The location of the interfaces file was not specified for "\
          >> $FATAL_MESSAGES_LOG
         echo "* this class.  The interfaces file was not found in \$SYBASE,"\
          >> $FATAL_MESSAGES_LOG
         echo "* either.  Please review this class definition." \
          >> $FATAL_MESSAGES_LOG
         INTERFACES_FATAL=1
         FATAL_FLAG=1
        fi
       fi

##############################################################################
#                           Validate SYBASE_SERVER
##############################################################################

       if [ -z "$SYBASE_SERVER" ] ; then
        if [ $DSQUERY ] ; then
         SYBASE_SERVER="$DSQUERY"
         egrep $SYBASE_SERVER $INTERFACES 1>/dev/null 2>&1
         if [ $? -gt 0 ] ; then
          echo "* " >> $FATAL_MESSAGES_LOG
          echo "* The Sybase servername was not specified for this class."\
           >> $FATAL_MESSAGES_LOG
          echo "* When not specified, this value is taken from \$DSQUERY."\
          >>$FATAL_MESSAGES_LOG
          echo "* However, the value in \$DSQUERY - $DSQUERY "\
           >> $FATAL_MESSAGES_LOG
          echo "* was not found in "$INTERFACES".  Please review this value."\
           >> $FATAL_MESSAGES_LOG
          SYBASE_SERVER_FATAL=1
          FATAL_FLAG=1
         else
          echo "* " >> $INFORMATION_MESSAGES_LOG
          echo "* The Sybase servername was not specified for this class." \
           >> $INFORMATION_MESSAGES_LOG
          echo "* Using value from \$DSQUERY - "$DSQUERY \
           >> $INFORMATION_MESSAGES_LOG
         fi
        else
         echo "* " >> $FATAL_MESSAGES_LOG
         echo "* The Sybase servername was not specified for this class." \
          >>$FATAL_MESSAGES_LOG
         echo "* When not specified, this value is taken from \$DSQUERY." \
          >>$FATAL_MESSAGES_LOG
         echo "*  However, \$DSQUERY was not found," >> $FATAL_MESSAGES_LOG
         echo "* either.  Please review this value." >> $FATAL_MESSAGES_LOG
         SYBASE_SERVER_FATAL=1
         FATAL_FLAG=1
        fi
       else
        egrep $SYBASE_SERVER $INTERFACES 1>/dev/null 2>&1
        if [ $? -gt 0 ] ; then
         echo "* " >> $FATAL_MESSAGES_LOG
         echo "* The Sybase servername, "$SYBASE_SERVER", was not found in" \
          >> $FATAL_MESSAGES_LOG
         echo "* "$INTERFACES".  Please review this class definition." \
          >> $FATAL_MESSAGES_LOG
         SYBASE_SERVER_FATAL=1
         FATAL_FLAG=1
        fi
       fi

##############################################################################
#                           Validate LOG_FILE_NAME
##############################################################################

       LOG_FILE_NAME_FATAL=0
       if [ -z "$LOG_FILE_NAME" ] ; then
        echo "* " >> $FATAL_MESSAGES_LOG
        echo "* The logfile for this class has not been specified." \
         >>$FATAL_MESSAGES_LOG
        echo "* Please specify a valid filename." >> $FATAL_MESSAGES_LOG
        FATAL_FLAG=1
        LOG_FILE_NAME_FATAL=1
       else
        ls $LOG_FILE_NAME 1>/dev/null 2>&1
        if [ $? -gt 0 ] ; then
         cp /dev/null $LOG_FILE_NAME 1>/dev/null 2>&1
         if [ $? -gt 0 ] ; then
          echo "* " >> $FATAL_MESSAGES_LOG
          echo "* The logfile specified for this class is invalid. Please "\
           >> $FATAL_MESSAGES_LOG
          echo "* specify a valid filename." >> $FATAL_MESSAGES_LOG
          FATAL_FLAG=1
          LOG_FILE_NAME_FATAL=1
         else
          rm $LOG_FILE_NAME
         fi
        fi
       fi

##############################################################################
#                          Validate SYBASE_USER
##############################################################################

       if [ -z "$SYBASE_USER" ] ; then
        echo "* " >> $INFORMATION_MESSAGES_LOG
        echo "* The Sybase user was not specified for this class.  When not"\
         >> $INFORMATION_MESSAGES_LOG
        echo "* specified, this value is assumed to be 'backup'." \
         >> $INFORMATION_MESSAGES_LOG
        SYBASE_USER=backup
       fi

##############################################################################
#                         Validate SYBASE_PASSWORD
##############################################################################

       if [ -z "$SYBASE_PASSWORD" ] ; then
        echo "* " >> $INFORMATION_MESSAGES_LOG
        echo "* The Sybase user password was not specified for this class."\
         >> $INFORMATION_MESSAGES_LOG
        echo "* When not specified, this value is assumed to be 'backup'." \
         >> $INFORMATION_MESSAGES_LOG
        SYBASE_PASSWORD=backup
       fi

##############################################################################
#                 Validate SYBASE_USER/SYBASE_PASSWORD login
##############################################################################

       if [ $SYBASE_DIR_FATAL -eq 0 -a $INTERFACES_FATAL -eq 0 -a \
        $SYBASE_SERVER_FATAL -eq 0 ] ; then
        USER_CHECK=`${SYBASE_DIR}/bin/isql -I${INTERFACES}  -U${SYBASE_USER}\
        -S${SYBASE_SERVER} << EOF
${SYBASE_PASSWORD}
EOF
`
        if [ $? -gt 0 ] ; then
         echo "* " >> $FATAL_MESSAGES_LOG
         echo "* Either the Sybase user or Sybase password specified were "\
          >> $FATAL_MESSAGES_LOG
         echo "* incorrect.  Please review these values." \
          >> $FATAL_MESSAGES_LOG
         FATAL_FLAG=1
         USER_CHECK_FATAL=1
        fi
       fi

##############################################################################
#                           Validate DEVICE_TYPE
##############################################################################

       if [ -z "$DEVICE_TYPE" ] ; then
        echo "* " >> $FATAL_MESSAGES_LOG
        echo "* The device type was not specified for this class.  Please "\
         >> $FATAL_MESSAGES_LOG
        echo "* specify either Tape or Disk." >> $FATAL_MESSAGES_LOG
        FATAL_FLAG=1
       fi

       case $DEVICE_TYPE in
        "Disk" ) for DEVICES in $DUMP_DEVICE
                 do
                  DIRECTORY_OPTION_VALID=0
                  for DIRECTORY_OPTION in $DIRECTORY_CLASS_LINE
                  do
                   if [ $DIRECTORY_OPTION != "-d" ] ; then
                    DIRECTORY_OPTION=`echo $DIRECTORY_OPTION\
                     |awk -F":" '{print $1}'`
                    [ $DIRECTORY_OPTION = $DEVICES ] \
                     && DIRECTORY_OPTION_VALID=1
                   fi
                  done
                 if [ $DIRECTORY_OPTION_VALID -eq 0 ] ; then
                  echo "* " >> $FATAL_MESSAGES_LOG
                  echo "* The dump device, "$DEVICES", is not valid." \
                   >> $FATAL_MESSAGES_LOG
                  echo "* Please specify a device defined with either -d" \
                   >> $FATAL_MESSAGES_LOG
                  echo "* (where dump type = Disk) or -t (where dump" \
                   >> $FATAL_MESSAGES_LOG
                  echo "* type = Tape.)" >> $FATAL_MESSAGES_LOG
                  FATAL_FLAG=1
                 fi
                done
                if [ -n "$UNLOAD" ] ; then
                 echo "* " >> $FATAL_MESSAGES_LOG
                 echo $N "* The UNLOAD option is invalid when the $C" \
                  >> $FATAL_MESSAGES_LOG
                 echo "$DUMP_TYPE is set to 'Disk'." >> $FATAL_MESSAGES_LOG
                 FATAL_FLAG=1
                fi
                if [ -n "$INIT" ] ; then
                 echo "* " >> $FATAL_MESSAGES_LOG
                 echo $N "* The INIT option is invalid when the DUMP_TYPE $C"\
                 echo "is set to 'Disk'." >> $FATAL_MESSAGES_LOG
                 FATAL_FLAG=1
                fi ;;
        "Tape" ) for TAPES in $DUMP_DEVICE
                 do
                  TAPE_OPTION_VALID=0
                  for TAPE_OPTION in $TAPE_CLASS_LINE
                  do
                   if [ $TAPE_OPTION != "-t" ] ; then
                    TAPE_OPTION=`echo $TAPE_OPTION|awk -F":" '{print $1}'`
                    [ $TAPE_OPTION = $TAPES ] && TAPE_OPTION_VALID=1
                   fi
                  done
                  if [ $TAPE_OPTION_VALID -eq 0 ] ; then
                   echo "* " >> $FATAL_MESSAGES_LOG
                   echo "* The dump device, "$TAPES", is not valid.  Please"\
                    >> $FATAL_MESSAGES_LOG
                   echo "* specify a device defined with either -d "
                    >> $FATAL_MESSAGES_LOG
                   echo "* (where dump type = Disk or -t (where dump " \
                    >> $FATAL_MESSAGES_LOG
                   echo "* type = Tape.)" >> $FATAL_MESSAGES_LOG
                   FATAL_FLAG=1
                  fi
                 done ;;
        * ) echo "* "
            echo "* The device type for this class is invalid.  Please "\
             >> $FATAL_MESSAGES_LOG
            echo "* specify either Tape or Disk." >> $FATAL_MESSAGES_LOG
            FATAL_FLAG=1 ;;
       esac

##############################################################################
#                           Validate DUMP_TYPE
##############################################################################

       if [ -z "$DUMP_TYPE" ] ; then
        echo "* " >> $INFORMATION_MESSAGES_LOG
        echo "* The dump type was not specified for this class.  When not "\
         >> $INFORMATION_MESSAGES_LOG
        echo "* specified, this value is assumed to be 'Full'." \
         >> $INFORMATION_MESSAGES_LOG
        DUMP_TYPE=DATABASE
        SYBASE_DUMP_TYPE=D
       else
        case $DUMP_TYPE in
         "Full" ) DUMP_TYPE=DATABASE
                  SYBASE_DUMP_TYPE=D ;;
         "Tran" ) DUMP_TYPE=TRANSACTION
                  SYBASE_DUMP_TYPE=T ;;
         * )
             echo "* " >> $FATAL_MESSAGES_LOG
             echo "* The dump type specified for this class, "$DUMP_TYPE" $C"\
              >> $FATAL_MESSAGES_LOG
             echo ", is invalid.  " >> $FATAL_MESSAGES_LOG
             echo "* Please specify either 'Full' or 'Tran'." \
              >> $FATAL_MESSAGES_LOG
             FATAL_FLAG=1 ;;
        esac
       fi

##############################################################################
#                         Validate DATABASE_NAME
##############################################################################

       if [ -z "$DATABASE_NAME" ] ; then
        echo "* " >> $INFORMATION_MESSAGES_LOG
        echo "* No databases were specified for backup for this class.  When"\
         >> $INFORMATION_MESSAGES_LOG
        echo "* none are specified, all databases from the specified server" \
         >> $INFORMATION_MESSAGES_LOG
        echo "* (minus any marked for exclusion) will be backed up." \
         >> $INFORMATION_MESSAGES_LOG
       fi

##############################################################################
#                           Print Message Logs
##############################################################################

       if [ -s $INFORMATION_MESSAGES_LOG ] ; then
        echo " "                            |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo "*                        --- Information Messages ---        "\
         |tee -a $CURRENT_LOG_FILE
        cat $INFORMATION_MESSAGES_LOG  |tee -a $CURRENT_LOG_FILE
        echo "*"                       |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
       fi

       if [ -s $FATAL_MESSAGES_LOG ] ; then
        echo " "                                  |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo "*                            --- Fatal Messages ---          "\
         |tee -a $CURRENT_LOG_FILE
        cat $FATAL_MESSAGES_LOG                   |tee -a $CURRENT_LOG_FILE
        echo "*"                                  |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
       fi

##############################################################################
#
#                  Compose Mail if Validation Failure
#
# Check $CURRENT_LOG_FILE for any errors that were generated during the
# backups.  If any are detected, mail contents of $CURRENT_LOG_FILE to $ADMIN
# and then move contents of $CURRENT_LOG_FILE to $LOG_FILE_NAME and remove
# $CURRENT_LOG_FILE.  If none are detected, simply move $CURRENT_LOG_FILE to
# $LOG_FILE_NAME, and then remove $CURRENT_LOG_FILE.
#
##############################################################################

       if [ $FATAL_FLAG -gt 0 ] ; then
        if [ "$FAILMAIL" = "yes" -a -n "$ADMIN" ] ; then
         cat $CURRENT_LOG_FILE | $L_MAIL -s "BACKUP ERRORS" $ADMIN
        fi
        if [ $LOG_FILE_NAME_FATAL -eq 0 ] ; then
         cat $CURRENT_LOG_FILE >>  $LOG_FILE_NAME
        fi
        rm $CURRENT_LOG_FILE
        continue
       fi

##############################################################################
#
#                       Generate A List Of Databases
#
# If the user has provided a list of databases, load that list into $DATABASES
# If the user has not provided a list of databases, generate a list from the
# SYBASE_SERVER provided (all databases, including system).  In either case,
# if the user has provided a list of databases to exclude, the list in
# $DATABASES will be modified to reflect this.  If, after excluding listed
# databases, none are left, a message will be printed saying so.
#
# Variables Used : DATABASE_NAME          = List of database(s)
#                  EXCLUDE_NAME           = List of excluded database(s)
#                  REVISED_DATABASE_NAME  = List of database(s) minus excluded
#                  REVISED_FLAG           = Set if include and exclude match
#
##############################################################################

       if [ -z "$DATABASE_NAME" ] ; then

DATABASE_NAME=`${SYBASE}/bin/isql -I${INTERFACES}  -U${SYBASE_USER} \
-S${SYBASE_SERVER} << EOF
${SYBASE_PASSWORD}

use master
go

declare database_name_cursor cursor
for
select name from sysdatabases
order by dbid
for read only
go

set nocount on
declare @database_name varchar(40)
open database_name_cursor
fetch database_name_cursor into @database_name

while ( @@sqlstatus = 0)
begin
print @database_name
fetch database_name_cursor into @database_name
end

return
go

EOF
`
        DATABASE_NAME=`echo $DATABASE_NAME|sed 's/Password\: //g'`
       fi

       TIME_STAMP=`date '+%m-%d-%y.%H.%M'`
       REVISED_DATABASE_NAME=""
       if [ -n "$EXCLUDE_NAME" ] ; then
        for DATABASE in $DATABASE_NAME
        do
         REVISED_FLAG=0
          for EXCLUDE in $EXCLUDE_NAME
          do
           [ $DATABASE = $EXCLUDE ] && REVISED_FLAG=1
          done
         if [ $REVISED_FLAG -eq 0 ] ; then
          REVISED_DATABASE_NAME=$REVISED_DATABASE_NAME" "$DATABASE
         fi
        done
       else
        REVISED_DATABASE_NAME=$DATABASE_NAME
       fi

       if [ -z "$REVISED_DATABASE_NAME" ] ; then
        echo " "                          |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo "*              No databases were marked for backup."          \
         |tee -a $CURRENT_LOG_FILE
        echo "*                 "`date '+DATE: %m/%d/%y TIME: %H:%M:%S'`    \
         |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo " "                          |tee -a $CURRENT_LOG_FILE
        cat $CURRENT_LOG_FILE >> $LOG_FILE_NAME
        rm $CURRENT_LOG_FILE
        continue
       fi

##############################################################################
#
#                           Build The SQL Query
#
# The class attributes and dump device attributes will now be combined to form
# an ad-hoc query to be run against the database.
#
# Variables Used :
#             REVISED_DATABASE_NAME_COUNT = Number of databases to backup
#                                                for each class.
#                  DATABASE_LOOP_COUNT    = Tracks number of databases
#                                            have been backed up for each
#                                            class.  Used to determine
#                                            placement of UNLOAD and INIT
#                                            options.
#                  DUMP_DEVICE_COUNT      = Number of devices for this class.
#                  REVISED_DATABASE_NAME  = List of database(s) minus
#                                           excluded ones.
#                  db_name                = Assigned database name one at
#                                           a time.
#                  DATABASE_SANITY_CHECK  = Holds results of a quick
#                                           to see if Sybase user has
#                                           correct permissions and if
#                                           database in $db_name exists.
#                 TIMESTAMP               = Datetime stamp YYMMDDHHMM
#                 SQL_CMD_FILE            = Filename holding sql query
#                 FIRST_DUMP_DEVICE       = Incremented if more than one.
#                 DIRECTORY_CLASS_LINE    = List of all directory classes.
#                 disk_option             = Elements of $DIRECTORY_CLASS_LINE
#                 DISK_LOGICAL_NAME       = Logical name of disk device.
#                 dt_name                 = Elements of $disk_option.
#                 DISK_SERVER             = Disk SQL Server.
#                 DISK_BACKUP_SERVER      = Disk Backup Server.
#                 DISK_DIRECTORY          = Disk directory.
#                 TAPE_CLASS_LINE         = List of all tape classes.
#                 tape_option             = Elements of $TAPE_CLASS_LINE.
#                 TAPE_LOGICAL_NAME       = Logical name of tape device.
#                 dt_name                 = Elements of $tape_option.
#                 TAPE_SERVER             = Tape SQL Server.
#                 TAPE_BACKUP_SERVER      = Tape Backup Server.
#                 TAPE_DEVICE             = Physical name of tape.
#                 TAPE_BLOCKSIZE          = Blocksize of tape.
#                 TAPE_CAPACITY           = Capacity of tape.
#                 UNLOAD                  = Unload option.
#                 RETAINDAYS              = Retaindays option.
#                 INIT                    = Init option.
#
##############################################################################

       REVISED_DATABASE_NAME_COUNT=0
       DATABASE_LOOP_COUNT=0
       DUMP_DEVICE_COUNT=0
       for db_count in $REVISED_DATABASE_NAME
       do
        REVISED_DATABASE_NAME_COUNT=`expr $REVISED_DATABASE_NAME_COUNT + 1`
       done

       for dev_count in $DUMP_DEVICE
       do
        DUMP_DEVICE_COUNT=`expr $DUMP_DEVICE_COUNT + 1`
       done

       for db_name in $REVISED_DATABASE_NAME
       do

        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo "*         ${DUMP_TYPE} DUMP OF DATABASE ${db_name} STARTED"   \
         |tee -a $CURRENT_LOG_FILE
        echo "*                  "`date '+DATE: %m/%d/%y TIME: %H:%M:%S'`   \
         |tee -a $CURRENT_LOG_FILE
        echo "*************************************************************"\
         |tee -a $CURRENT_LOG_FILE
        echo " "                                  |tee -a $CURRENT_LOG_FILE

        TIME_STAMP=`date '+%y%m%d%H%M'`

        [ -f /tmp/DATABASE_SANITY_CHECK ] && rm /tmp/DATABASE_SANITY_CHECK

DATABASE_SANITY_CHECK=`${SYBASE}/bin/isql -I${INTERFACES}  -U${SYBASE_USER} \
-S${SYBASE_SERVER} -o/tmp/DATABASE_SANITY_CHECK << EOF
${SYBASE_PASSWORD}

SET NOCOUNT ON

IF EXISTS (SELECT 1 FROM master..sysdatabases WHERE name = "${db_name}")
 BEGIN
 IF proc_role("sa_role") = 1
 OR
 proc_role("oper_role") = 1
 OR
 EXISTS ( select 1 from master..sysdatabases where name = "${db_name}" and suid = suser_id() )

 /* * *  DUMP DATABASE  * * */

  BEGIN
  PRINT "PASSED SANITY CHECK"
  END

 ELSE

 /* * *  IF LOGIN DOES NOT HAVE NECESSARY PERMISSIONS, ABORT  * * */

  BEGIN
  DECLARE @suser_name varchar(30)
  SELECT  @suser_name = suser_name()
  PRINT "                     >>> SCRIPT ABORTING! <<<"
  PRINT ""
  PRINT 'REASON:  The current login, %1!, does not have the necessary permission to', @suser_name
  PRINT 'successfully execute DUMP ${DUMP_TYPE} for database ${db_name}.  Either the'
  PRINT '"SA_ROLE", "OPER_ROLE", or "dbo" permissions are required.  Please see your'
  PRINT 'administrator for assistance.'
  PRINT ""
  PRINT ""
  END
 END
ELSE

/* * *  IF DATABASE DOES NOT EXIST, ABORT  * * */

 BEGIN
 PRINT ""
 PRINT "                       >>> SCRIPT ABORTING! <<<"
 PRINT ""
 PRINT "REASON:  A database named ${db_name} does not exist on this SQL Server ($SYBASE_SERVER)."
 PRINT ""
 PRINT ""
 END
GO

EOF`

        egrep "PASSED" /tmp/DATABASE_SANITY_CHECK 1>/dev/null 2>&1
        if [ $? -gt 0 ] ; then
         cat /tmp/DATABASE_SANITY_CHECK |tee -a $CURRENT_LOG_FILE
         echo " "                                                           \
          |tee -a $CURRENT_LOG_FILE
         echo "************************************************************"\
          |tee -a $CURRENT_LOG_FILE
         echo "*         ${DUMP_TYPE} DUMP OF DATABASE ${db_name} COMPLETED"\
          |tee -a $CURRENT_LOG_FILE
         echo "*                  "`date '+DATE: %m/%d/%y TIME: %H:%M:%S'`  \
          |tee -a $CURRENT_LOG_FILE
         echo "************************************************************"\
          |tee -a $CURRENT_LOG_FILE
        else
         [ -f /tmp/${db_name}_dump.sql ] && rm /tmp/${db_name}_dump.sql
         SQL_CMD_FILE=/tmp/${db_name}_dump.sql
         echo "DUMP "$DUMP_TYPE" "$db_name > $SQL_CMD_FILE
         FIRST_DUMP_DEVICE=0
         DATABASE_LOOP_COUNT=`expr $DATABASE_LOOP_COUNT + 1`
         STRIPE_NUMBER=0

         if [ $DEVICE_TYPE = "Disk" ] ; then
          for disk_option in $DIRECTORY_CLASS_LINE
          do
           if [ $disk_option != "-d" ] ; then
            DISK_LOGICAL_NAME=`echo $disk_option|awk -F":" '{print $1}'`
            for dt_name in $DUMP_DEVICE
            do
             if [ $DISK_LOGICAL_NAME = $dt_name ] ; then
              DISK_SERVER=`echo $disk_option|awk -F":" '{print $2}'`
              DISK_BACKUP_SERVER=`echo $disk_option|awk -F":" '{print $3}'`
              STRIPE_NUMBER=`expr $STRIPE_NUMBER + 1`
              DISK_DIRECTORY=`echo $disk_option\
               |awk -F":" '{print $4}'`\
               "/"$SYBASE_SERVER"."$db_name"."$SYBASE_DUMP_TYPE"."$STRIPE_NUMBER"-"$DUMP_DEVICE_COUNT"."$TIME_STAMP
               if [ $DISK_SERVER = $SYBASE_SERVER ] ; then
                if [ $FIRST_DUMP_DEVICE -eq 0 ] ; then
                 echo "TO '"$DISK_DIRECTORY"'" >> $SQL_CMD_FILE
                 FIRST_DUMP_DEVICE=1
                else
                 echo "STRIPE ON '"$DISK_DIRECTORY"'" >> $SQL_CMD_FILE
                fi
               else
                if [ $FIRST_DUMP_DEVICE -eq 0 ] ; then
                 echo "TO '"$DISK_DIRECTORY"' AT "$DISK_BACKUP_SERVER \
                  >> $SQL_CMD_FILE
                 FIRST_DUMP_DEVICE=1
                else
                 echo "STRIPE ON '"$DISK_DIRECTORY"' AT "$DISK_BACKUP_SERVER\
                  >> $SQL_CMD_FILE
                fi
               fi
              fi
             done
            fi
           done
         else
          for tape_option in $TAPE_CLASS_LINE
          do
           if [ $tape_option != "-t" ] ; then
            TAPE_LOGICAL_NAME=`echo $tape_option|awk -F":" '{print $1}'`
            for dt_name in $DUMP_DEVICE
            do
             if [ $TAPE_LOGICAL_NAME = $dt_name ] ; then
              TAPE_SERVER=`echo $tape_option|awk -F":" '{print $2}'`
              TAPE_BACKUP_SERVER=`echo $tape_option|awk -F":" '{print $3}'`
              TAPE_DEVICE=`echo $tape_option|awk -F":" '{print $4}'`
              TAPE_BLOCKSIZE=`echo $tape_option|awk -F":" '{print $5}'`
              TAPE_CAPACITY=`echo $tape_option|awk -F":" '{print $6}'`
              if [ $TAPE_SERVER = $SYBASE_SERVER ] ; then
               if [ $FIRST_DUMP_DEVICE -eq 0 ] ; then
                echo "TO '"$TAPE_DEVICE"'" >> $SQL_CMD_FILE
                FIRST_DUMP_DEVICE=1
                if [ -n "$TAPE_BLOCKSIZE" ] ; then
                 if [ -n "$TAPE_CAPACITY" ] ; then
                  echo "BLOCKSIZE = "$TAPE_BLOCKSIZE"," >> $SQL_CMD_FILE
                  echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                 else
                  echo "BLOCKSIZE = "$TAPE_BLOCKSIZE >> $SQL_CMD_FILE
                 fi
                elif [ -n "$TAPE_CAPACITY" ] ; then
                 echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                fi
               else
                echo "STRIPE ON '"$TAPE_DEVICE"'" >> $SQL_CMD_FILE
                if [ -n "$TAPE_BLOCKSIZE" ] ; then
                 if [ -n "$TAPE_CAPACITY" ] ; then
                  echo "BLOCKSIZE = "$TAPE_BLOCKSIZE"," >> $SQL_CMD_FILE
                  echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                 else
                  echo "BLOCKSIZE = "$TAPE_BLOCKSIZE >> $SQL_CMD_FILE
                 fi
                elif [ -n "$TAPE_CAPACITY" ] ; then
                 echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                fi
               fi
              else
               if [ $FIRST_DUMP_DEVICE -eq 0 ] ; then
                echo "TO '"$TAPE_DEVICE"' AT "$TAPE_BACKUP_SERVER \
                 >> $SQL_CMD_FILE
                FIRST_DUMP_DEVICE=1
                 if [ -n "$TAPE_BLOCKSIZE" ] ; then
                  if [ -n "$TAPE_CAPACITY" ] ; then
                   echo "BLOCKSIZE = "$TAPE_BLOCKSIZE"," >> $SQL_CMD_FILE
                   echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                  else
                   echo "BLOCKSIZE = "$TAPE_BLOCKSIZE >> $SQL_CMD_FILE
                  fi
                 elif [ -n "$TAPE_CAPACITY" ] ; then
                  echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                 fi
                else
                 echo "STRIPE ON '"$TAPE_DEVICE"' at "$TAPE_BACKUP_SERVER \
                  >> $SQL_CMD_FILE
                 if [ -n "$TAPE_BLOCKSIZE" ] ; then
                  if [ -n "$TAPE_CAPACITY" ] ; then
                   echo "BLOCKSIZE = "$TAPE_BLOCKSIZE"," >> $SQL_CMD_FILE
                   echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                  else
                   echo "BLOCKSIZE = "$TAPE_BLOCKSIZE >> $SQL_CMD_FILE
                  fi
                 elif [ -n "$TAPE_CAPACITY" ] ; then
                  echo "CAPACITY = "$TAPE_CAPACITY >> $SQL_CMD_FILE
                 fi
                fi
               fi
              fi
             done
            fi
           done
          fi

          if [ -n "$UNLOAD" -o -n "$RETAINDAYS" -o -n "$INIT" ] ; then
           if [ -n "$UNLOAD" ] ; then
            if [ -n "$RETAINDAYS" ] ; then
              if [ -n "$INIT" ] ; then
               if [ $DATABASE_LOOP_COUNT -eq $REVISED_DATABASE_NAME_COUNT ]
               then
                echo "WITH UNLOAD," >> $SQL_CMD_FILE
               fi
               if [ $DATABASE_LOOP_COUNT -eq 1 ] ; then
                echo "RETAINDAYS = "$RETAINDAYS"," >> $SQL_CMD_FILE
                echo "INIT" >> $SQL_CMD_FILE
               else
                echo "RETAINDAYS = "$RETAINDAYS >> $SQL_CMD_FILE
               fi
              else
               if [ $DATABASE_LOOP_COUNT -eq $REVISED_DATABASE_NAME_COUNT ]
               then
                echo "WITH UNLOAD," >> $SQL_CMD_FILE
               fi
               echo "RETAINDAYS = "$RETAINDAYS >> $SQL_CMD_FILE
              fi
             else
              echo "WITH UNLOAD" >> $SQL_CMD_FILE
             fi
            elif [ -n "$RETAINDAYS" ] ; then
             if [ -n "$INIT" ] ; then
              if [ $DATABASE_LOOP_COUNT -eq 1 ] ; then
               echo "WITH RETAINDAYS = "$RETAINDAYS"," >> $SQL_CMD_FILE
               echo "INIT" >> $SQL_CMD_FILE
              else
               echo "WITH RETAINDAYS = "$RETAINDAYS >> $SQL_CMD_FILE
              fi
             else
              echo "WITH RETAINDAYS = "$RETAINDAYS >> $SQL_CMD_FILE
             fi
            else
             if [ $DATABASE_LOOP_COUNT -eq 1 ] ; then
              echo "WITH INIT" >> $SQL_CMD_FILE
             fi
            fi
           fi
           echo "go" >> $SQL_CMD_FILE
           echo "if ( @@error != 0 )" >> $SQL_CMD_FILE
           echo "print \"WARNING: WARNING: WARNING: ERROR DETECTED!\"" \
            >> $SQL_CMD_FILE
           echo "go" >> $SQL_CMD_FILE

##############################################################################
#
#                             Backup Database(s)
#
# Backup the list of affected databases using the SQL query build above.  Once
# completed, display a finishing statement with database name and time.
#
# Variables Used : SQL_CMD_FILE            = Filename holding sql query
#
##############################################################################

${SYBASE}/bin/isql -I${INTERFACES}  -U${SYBASE_USER} -S${SYBASE_SERVER} \
-P${SYBASE_PASSWORD} -i${SQL_CMD_FILE} |tee -a $CURRENT_LOG_FILE
#           cat $SQL_CMD_FILE |tee -a $CURRENT_LOG_FILE
           echo " "                                 |tee -a $CURRENT_LOG_FILE
           echo "**********************************************************"\
            |tee -a $CURRENT_LOG_FILE
           echo "*       ${DUMP_TYPE} DUMP OF DATABASE ${db_name} COMPLETED"\
            |tee -a $CURRENT_LOG_FILE
           echo "*                "`date '+DATE: %m/%d/%y TIME: %H:%M:%S'`  \
            |tee -a $CURRENT_LOG_FILE
           echo "**********************************************************"\
            |tee -a $CURRENT_LOG_FILE

           rm $SQL_CMD_FILE
          fi
          echo " "

          [ -f /tmp/DATABASE_SANITY_CHECK ] && rm /tmp/DATABASE_SANITY_CHECK

         done

##############################################################################
#
#                     Compose Mail if Backup Failure
#
# Check $CURRENT_LOG_FILE for any errors that were generated during the
# backups.  If any are detected, mail contents of $CURRENT_LOG_FILE to $ADMIN
# and then move contents of $CURRENT_LOG_FILE to $LOG_FILE_NAME and remove
# $CURRENT_LOG_FILE.  If none are detected, simply move $CURRENT_LOG_FILE to
# $LOG_FILE_NAME, and then remove $CURRENT_LOG_FILE.
#
##############################################################################

         egrep "SCRIPT ABORTING|WARNING: WARNING: WARNING:" $CURRENT_LOG_FILE\
          1>/dev/null 2>&1
         if [ $? -gt 0 ] ; then
          if [ "$SUCCESSMAIL" = "yes" -a -n "$ADMIN" ] ; then
           cat $CURRENT_LOG_FILE | $L_MAIL -s "BACKUP SUCCESS" $ADMIN
          fi
          cat $CURRENT_LOG_FILE >> $LOG_FILE_NAME
          rm $CURRENT_LOG_FILE
         else
          if [ "$FAILMAIL" = "yes" -a -n "$ADMIN" ] ; then
           cat $CURRENT_LOG_FILE | $L_MAIL -s "BACKUP ERRORS" $ADMIN
          fi
          cat $CURRENT_LOG_FILE >> $LOG_FILE_NAME
          rm $CURRENT_LOG_FILE
         fi

         echo " "
         echo " "
      fi
     fi
    fi
   fi
  fi
 fi
done



#############################################################################
#                                                                            #
#      EEEEEE    X   X    III    TTTTTTT
#      E          X X      I        T
#      EEE         X       I        T
#      E          X X      I        T
#      EEEEEE    X   X    III       T
#
##############################################################################

exit 0
