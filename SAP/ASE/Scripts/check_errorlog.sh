#!/bin/sh
#---------------------------------------------------------------------------
# CHECK_ERRORLOG.SH - script to check an ASE errorlog for error messages
# 
#
# Description
# ===========
# This script to check an ASE errorlog for certain strings indicating errors
# and other issues a DBA should know about, and mails the results to a list 
# of recipients. When the server is running, the script will figure out the 
# errorlog filename itself, though you can also specify the file name 
# explicitly.
# This script can be run as a daily 'cron' job, so that the DBA receives a 
# list of all new suspect errorlog messages by email every day.
# For a description of the background of this tool, and the techniques 
# used, go to http://www.sypron.nl/chklog.html . 
#
#
# Parameters
# ==========
#  $1 - the server name
#  $2 - login name (which must have sa_role and sybase_ts_role). If $4 or $5 
#       are specified, specify "".
#  $3 - login password. If $4 or $5 are specified, or for a blank 
#       password, specify "".
#  $4 - (optional) the server errorlog pathname. When the server is running, the 
#       script will figure out the errorlog filename itself. However, this 
#       parameter allows you to secify the file name explicitly.
#  $5 - (optional) If any non-blank string is specified here, the entire file
#       will be scanned (the markers will be ignored) 
#
#
# Installation
# ============
# Installation is simple: 
# - make this file executable (using "chmod +x check_errorlog.sh")
# - you must define the variables MAILPROG and DBA_MAIL in the script below;
#   these must be set to the command-line mail program available on your system
#   (like 'mail', 'mailx' etc.), and to the list of email adresses to which
#    the results should be sent, respectively.
#
# Best make it a 'cron' job so that you have an email with all
# the new error messages every morning when coming into work.
#
#
# Notes
# =====
# - By default, errorlog checking is done incrementally: after scanning the 
#   errorlog, a marker is written in the errorlog to indicate how far we got,
#   so the next time only the latest part is searched for (this is not done  
#   when $4 or $5 are specified -- see below). This is to avoid finding
#   the same old error messages again and again.
#
# - this script must run on the same host as where the ASE server runs 
#   (because it needs to access the server errorlog file).
#
# - In case the server is not running, but you still want to check its 
#   errorlog, specify the pathname explicitly through $4
#
# - $1 (the server name) is used only for accessing the server, but this
#   server name is also included in the report which is mailed. You can
#   also specificy an explicit errorlog pathname through $4, but note there is 
#   no check whether that errorlog is indeed corresponding to the server name
#   specified in $1. So, don't mess up the parameters or you'll get confused !
#
# - the login specified must have both sa_role and sybase_ts_role.
#
# - when you're not happy with specifying the login password on the command
#   line (for security reasons for example), feel free to modify this code
#   and handle the password differently so that it suits your requirements.
#
# - By default, an email will always be sent after each run of this script, 
#   even when no error messages have been found. If you would like to 
#   suppress sending email in this case, set the environment variable 
#   SKIP_WHEN_EMPTY to YES in the script below.
#
# - This script was tested on Unix; it also runs on Windows NT, provided 
#   you have a shell emulator such as CygWin (free download available 
#   at http://www.cygwin.com/ -- Cygwin is not available from RedHat anymore)
#
#
# Revision History
# ================
# Nov. 1997 - First version 
# Oct. 2000 - Cleaned up; added @@errorlog comment; made more robust
# Apr. 2001 - Added additional comments and checks.
# Mar. 2002 - Removed loop to improve performance (thanks to Jean Loesch)
#             (this also minimises the risk of missing error messages  
#              written while this script runs -- thanks to Graeme McCormack)
# Sep. 2002 - Added some clarifying comments
# Oct. 2002 - Made 'awk'/'gawk' configurable
# 
#
# Copyright Note & Disclaimer :
# =============================
# This software is provided "as is"; there is no warranty of any kind.
# While this software is believed to work accurately, it may not work 
# correctly and/or reliably in a production environment. In no event shall  
# Rob Verschoor and/or Sypron B.V. be liable for any damages resulting 
# from the use of this software. 
# You are allowed to use this software free of charge for your own 
# professional, non-commercial purposes. 
# You are not allowed to sell or bundle this software or use it for any 
# other commercial purpose without prior written permission from 
# Rob Verschoor/Sypron B.V.
# You may (re)distribute only unaltered copies of this software, which 
# must include this copyright note, as well as the copyright note in 
# the header of each stored procedure.
#
# Note: All trademarks are acknowledged.
#
# Please send any comments, bugs, suggestions etc. to the below email
# address.
#
# Copyright (c) 1997-2002 Rob Verschoor/Sypron B.V.
#
#                         Email: rob@sypron.nl
#                         WWW  : http://www.sypron.nl
#---------------------------------------------------------------------------
#
THISPROG=`basename $0`
#
USAGE()
{
  echo "Usage:"
  echo " $THISPROG <servername> <login> <passwd> [<errorlog-pathname> [\"all\"]]"
}
#
#---------------------------------------------------------------------------
#
# Check parameters
#
if [ $# -lt 3 ] || [ $# -gt 5 ]
then
  USAGE
  exit 1
fi
#
#
SRV=$1
LOGIN=$2
PASSWD=$3
LOGFILE=$4
LOGFILE_PARAM=$4
OPT=$5
#
#---------------------------------------------------------------------------
#
# Temp files
#
TMP=/tmp/srvlogchk.$$
LOGFILE_COPY=$TMP.errlog
rm -f $TMP.*
#
#---------------------------------------------------------------------------
#
# Some contants; do NOT change these !
#
DFT_MAILPROG="your_mail_program" #DO NOT CHANGE -- go to the next section
DFT_DBA_MAIL="you@yourcompany.com yourcollege@yourcompany.com" #DO NOT CHANGE
#                                                   -- go to the next section
#
#---------------------------------------------------------------------------
#
# Some definitions
#
# MAILPROG must be set to your command-line mail program, like 'mail', 'mailx',
# etc. Later in this script, it is assumed that this mail program supports 
# specifying the mail subject on the command line with the "-s" option.
# Should you use 'sendmail', you'll have to modify the script, or do without
# the mail subject, as 'sendmail' does not have this "-s" option.
# NT users may want to use 'ssmtp' (part of CygWin) as their mail 
# program (also see comment below).
#
MAILPROG="$DFT_MAILPROG"  # define your own setting here
#
#
# Define a list of people receiving results by email:
#
DBA_MAIL="$DFT_DBA_MAIL"  # define your own setting here
#
#
SKIP_WHEN_EMPTY=NO # if YES, will not send mail when no errors were found
#
#---------------------------------------------------------------------------
# The marker strings below can be set to any arbitrary string, as long 
# as this is unique and does not appear in the errorlog as part of any
# error message.
# These strings should not be changed anymore once you've started using 
# this script.
#
MARKER="_Marker_For_Checking_Errorlog_"		#do not change this !
MARKER2="_Marker_End_"				#do not change this !
#
#--------------------------------------------------------------------------
#
# Change the below to 'gawk' (or 'nawk') if desired... This may be needed 
# when hitting built-in max. string length limits in 'awk'. 'gawk' etc.
# tend to be more flexible.
#
AWK=awk   # awk|gawk
#
#---------------------------------------------------------------------
#
# Check the mail program and email adresses have been defined
#
if [ "$MAILPROG" = "$DFT_MAILPROG" ]
then
   echo ""
   echo "You must first define the variable 'MAILPROG' in this script;"
   echo "please set it to the name of your command-line mail program,"
   echo "like 'mail', 'mailx', etc."
   echo ""
   exit 1
fi
#
if [ "$DBA_MAIL" = "$DFT_DBA_MAIL" ]
then
   echo ""
   echo "You must first define the variable 'DBA_MAIL' in this script;"
   echo "please set it to a list of recipients."
   echo ""
   exit 1
fi
#
#--------------------------------------------------------------------------
#
# First locate the server errorlog
#
rm -f $LOGFILE_COPY
#
if [ "$LOGFILE" = "" ]
then
#
# Pick up the server errorlog pathname; first check if this is 12.0 
# or later to determine the method for doing this
#
cat << --EOF-- > $TMP.vchk.sql
select name from sysobjects  -- used for ASE version check
where name = "sysqueryplans"
go
dbcc traceon(3604)
go
dbcc resource -- contains errorlog pathname
go
--EOF--
#
# The below isql session also doubles as an ASE access and
# privilege check. 
# Using 'cat' and piping the SQL to isql is done to make it run on 
# Windows NT as well ('cos the NT version of 'isql' won't understand 
# Unix-style pathnames)
#
touch $TMP.vchk
cat $TMP.vchk.sql | isql -S$SRV -U$LOGIN -P$PASSWD -w500 >> $TMP.vchk
#
if [ `grep -c "CT-LIBRARY error" $TMP.vchk` -gt 0 ]
then
   cat $TMP.vchk
   rm -f $TMP.*
   echo ""
   echo "*** Note: in case you cannot connect because the ASE server is down,"
   echo "*** you can also specify the errorlog pathname explicitly."
   echo ""
   USAGE
   exit 1
fi
#
if [ `grep -c "You must have the following role(s) to" $TMP.vchk` -gt 0 ]
then
   grep "You must have the following role(s) to" $TMP.vchk
   rm -f $TMP.*
   exit 1
fi
#
# 18-Sep-2001 Corrected the test below: it said "-ne 1" instead of "-eq 1",
# causing it to not to identify version pre-12.0 correctly 
# (thanks to Jean Loesch)
#
if [ `grep -c "sysqueryplans" $TMP.vchk` -eq 1 ]
then
#--------------------------------------------------------------------------
#
# This is ASE 12.0+, so locate the errorlog through @@errorlog (this isn't
# really necessary, as dbcc resource would still work fine), but let's do
# it anyway for educational purposes ...
#
cat << --EOF-- > $TMP.ataterrlog.sql
print @@errorlog
go
--EOF--
#
cat $TMP.ataterrlog.sql | isql -S$SRV -U$LOGIN -P$PASSWD > $TMP.ataterrlog
#
LOGFILE=`${AWK} '{print $1}' $TMP.ataterrlog`
#
#--------------------------------------------------------------------------
else # not 12.0+
#
# This is ASE pre-12.0, so locate the errorlog through dbcc resource (already 
# executed above)
#
LOGFILE=`grep rerrfile $TMP.vchk | sed -e's/.*rerrfile=//' | ${AWK} '{print $1}'`
#
fi
#
fi # if $LOGFILE = ""
#
#--------------------------------------------------------------------------
#
# Errorlog file name known now, check if it's there
#
if [ ! -f "$LOGFILE" ]
then
  echo "Error accessing server errorlog file [$LOGFILE] - file not found"
  echo "Note: this script must be run on the same host where the "
  echo "ASE errorlog file is located."
  rm -f $TMP.*
  exit 1
fi
#
cp $LOGFILE $LOGFILE_COPY
#
#--------------------------------------------------------------------------
# Check option parameter
#
if [ "$OPT" = "" ]
then
  SCAN_ALL=N
else
  SCAN_ALL=Y
  echo "Scanning the entire ASE errorlog."
fi
#
#--------------------------------------------------------------------------
#
if [ "$SCAN_ALL" = "N" ]
then
#
# Skip the part of the errorlog until the last marker
#
# Note: if the next line gives an error message, either use
# different shell, or rewrite it with backquotes as follows:
#  LAST_MARKER=`${AWK} '/'$MARKER'/ { a=NR } END { print a }' $LOGFILE_COPY`
#
#
   LAST_MARKER=$(${AWK} '/'$MARKER'/ { a=NR } END { print a }' $LOGFILE_COPY)
   if [ ! "$LAST_MARKER" = "" ]
   then
      sed "1,${LAST_MARKER}d" $LOGFILE_COPY > $TMP.x
      cp $TMP.x $LOGFILE_COPY
   fi
#
fi
#
#--------------------------------------------------------------------------
#
# Create output file 
#
touch $TMP.out
echo "Checking ASE errorlog" >> $TMP.out
date >> $TMP.out
echo "Server=$SRV" >> $TMP.out
echo "Errorlog=$LOGFILE" >> $TMP.out
echo "" >> $TMP.out
#
#--------------------------------------------------------------------------
# 
# Finally... search for errors in the log file. The below set of search 
# strings catches pretty much everything, but you can add any string here 
# which you would also like to search for...
#
# Note that these strings indicate the presence of messages that should
# be investigated. Still, this may require further inspection of the 
# errorlog, as more messages may be present which contain additional 
# information.
#
egrep -i '(warning|severity|fail|unmirror|mirror exit|not enough|error|suspect|corrupt|correct|deadlock|critical|allow|infect|error|full|problem|unable|not found|threshold|couldn|not valid|invalid|NO_LOG|logsegment|syslogs|stacktrace)' $LOGFILE_COPY | egrep -vi '(successfull|_Marker_|(Suspect Granularity))' > $TMP.out2
#
NRLINES=`wc -l $TMP.out2 | ${AWK} '{print $1}'`
#
cat $TMP.out2 >> $TMP.out
#
#--------------------------------------------------------------------------
#
echo "$NRLINES error lines found in errorlog for ASE server '$SRV'"
#
echo "" >> $TMP.out
echo "$NRLINES error lines found in errorlog for ASE server '$SRV'" >> $TMP.out
echo "" >> $TMP.out
echo "(end)" >> $TMP.out
#
if [ "$SKIP_WHEN_EMPTY" = "NO" ] && [ $NRLINES -eq 0 ]
then
NRLINES=1  # to force it into mailing anyway
fi
#
if [ $NRLINES -gt 0 ]
then
#
#
# Mail any error messages found to the list of recipients
# (note: assumption is that the -s "subject" option is available for
# your email program. Should you use "sendmail", it may not be 
# available, and you'd have to remove this option; when you're familiar 
# with 'sendmail', you can add the subject line yourself by inserting
# header lines into the message file)
#
# Note for NT users: if you need a command-line mail program on NT, 
# consider 'ssmtp'. This is part of the CygWin package, which you need
# anyway to run this script on NT. The download location for CygWin 
# is in the file header above.
#
SUBJ="Results of ASE errorlog check for '$SRV'"
$MAILPROG -s "$SUBJ" $DBA_MAIL < $TMP.out
#
#
fi
#
#--------------------------------------------------------------------------
#
if [ "$SCAN_ALL" = "N" ]
then
#
# Write a new marker to the server errorlog to indicate we got till here
# Only do this when (i) no explicit errorlog pathname was specified and 
# (ii) only the last part of the log was scanned.
#
cat << --EOF-- > $TMP.logprint.sql
dbcc logprint ("$MARKER")
dbcc logprint ("$MARKER2") -- need a second line to avoid missing the last line
if @@error = 0 print "Writing marker to ASE errorlog."
-- note: in ASE 12.0, we could the more tidy "dbcc printolog(string)" instead
go
--EOF--
#
cat $TMP.logprint.sql | isql -S$SRV -U$LOGIN -P$PASSWD | egrep -v '(DBCC execution compl|(SA))'
#
fi
#
#--------------------------------------------------------------------------
#
# clean up
#
rm -f $TMP.*
#
#--------------------------------------------------------------------------
# end
#
