# Tue Nov 05 15:40:00 CET 2019
# Replay feature output
# ---------------------
# This file was built by the Replay feature of InstallAnywhere.
# It contains variables that were set by Panels, Consoles or Custom Code.



#Validate Response File
#----------------------
RUN_SILENT=true

#Choose Install Folder
#---------------------
USER_INSTALL_DIR=C:\\SAP_ASE

#Choose Install Set
#------------------
CHOSEN_FEATURE_LIST=fase_srv,fopen_client,fdblib,fjconnect160,fodbcw,fado,fdbisql,fqptune,fsysam_util,fase_cagent,fconn_python,fconn_perl,fconn_php,fscc_server,fasecmap
CHOSEN_INSTALL_FEATURE_LIST=fase_srv,fopen_client,fdblib,fjconnect160,fodbcw,fado,fdbisql,fqptune,fsysam_util,fase_cagent,fconn_python,fconn_perl,fconn_php,fscc_server,fasecmap
CHOSEN_INSTALL_SET=Typical

#Choose Product License Type
#---------------------------
SYBASE_PRODUCT_LICENSE_TYPE=evaluate

#Install
#-------
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\uninstall.lax=Yes
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\resource\\iawin64_x64.dll=Yes
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\resource\\iawin32.dll=Yes
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\resource\\win64_32_x64.exe=Yes
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\resource\\remove.exe=Yes
-fileOverwrite_C\:\\SAP_ASE\\sybuninstall\\ASESuite\\resource\\invoker.exe=Yes

#Configure New Servers
#---------------------
SY_CONFIG_ASE_SERVER=true
SY_CONFIG_HADR_SERVER=false
SY_CONFIG_BS_SERVER=true
SY_CONFIG_JS_SERVER=false
SY_CONFIG_BALDR_OPTION=false
SY_CONFIG_SM_SERVER=false
SY_CONFIG_WS_SERVER=false
SY_CONFIG_SCC_SERVER=true
SY_CONFIG_TXT_SERVER=false

#Configure Servers with Different User Account
#---------------------------------------------
SY_CFG_SERVICE_ACCOUNT_CHANGE=no
SY_CFG_SERVICE_ACCOUNT_NAME=
SY_CFG_SERVICE_ACCOUNT_PASSWORD=
SY_CFG_SERVICE_ACCOUNT_CONFIRM_PASSWORD=

#User Configuration Data Directory
#---------------------------------
SY_CFG_USER_DATA_DIRECTORY=C:\\SAP_ASE

#Configure New SAP ASE
#---------------------
SY_CFG_ASE_SERVER_NAME=W7ASE_DS
SY_CFG_ASE_HOST_NAME=127.0.0.1
SY_CFG_ASE_PORT_NUMBER=2025
SY_CFG_ASE_APPL_TYPE=MIXED
SY_CFG_ASE_PAGESIZE=4k
SY_CFG_ASE_PASSWORD=
SY_CFG_ASE_MASTER_DEV_NAME=C:\\SAP_ASE\\data\\master.dat
SY_CFG_ASE_MASTER_DEV_SIZE=52
SY_CFG_ASE_MASTER_DB_SIZE=26
SY_CFG_ASE_SYBPROC_DEV_NAME=C:\\SAP_ASE\\data\\sysprocs.dat
SY_CFG_ASE_SYBPROC_DEV_SIZE=196
SY_CFG_ASE_SYBPROC_DB_SIZE=196
SY_CFG_ASE_SYBTEMP_DEV_NAME=C:\\SAP_ASE\\data\\sybsysdb.dat
SY_CFG_ASE_SYBTEMP_DEV_SIZE=6
SY_CFG_ASE_SYBTEMP_DB_SIZE=6
SY_CFG_ASE_ERROR_LOG=C:\\SAP_ASE\\ASE-16_0\\install\\W7ASE_DS.log
CFG_REMOTE_AND_CONTROL_AGENT=false
ENABLE_COCKPIT_MONITORING=true
COCKPIT_TECH_USER=tech_user
COCKPIT_TECH_USER_PASSWORD=
SY_CFG_ASE_PCI_ENABLE=false
SY_CFG_ASE_PCI_DEV_NAME=$NULL$
SY_CFG_ASE_PCI_DEV_SIZE=$NULL$
SY_CFG_ASE_PCI_DB_SIZE=$NULL$
SY_CFG_ASE_TEMP_DEV_NAME=C:\\SAP_ASE\\data\\tempdbdev.dat
SY_CFG_ASE_TEMP_DEV_SIZE=100
SY_CFG_ASE_TEMP_DB_SIZE=100
SY_CFG_ASE_OPT_ENABLE=true
SY_CFG_ASE_CPU_NUMBER=1
SY_CFG_ASE_MEMORY=1800
SY_CFG_ASE_LANG=us_english
SY_CFG_ASE_CHARSET=cp850
SY_CFG_ASE_SORTORDER=bin_cp850
SY_CFG_ASE_SAMPLE_DB=false

#Configure New Backup Server
#---------------------------
SY_CFG_BS_SERVER_NAME=W7ASE_BS
SY_CFG_BS_PORT_NUMBER=2026
SY_CFG_BS_ERROR_LOG=C:\\SAP_ASE\\ASE-16_0\\install\\W7ASE_BS.log
SY_CFG_BS_ALLOW_HOSTS=

#Configure New XP Server
#-----------------------
SY_CFG_XP_SERVER_NAME=W7ASE_DS_XP
SY_CFG_XP_PORT_NUMBER=2027
SY_CFG_XP_ERROR_LOG=C:\\SAP_ASE\\ASE-16_0\\install\\W7ASE_DS_XP.log

#Cockpit Host and Ports
#----------------------
CONFIG_SCC_HTTP_PORT=4282
CONFIG_SCC_HTTPS_PORT=4283
SCC_TDS_PORT_NUMBER=4998
SCC_RMI_PORT_NUMBER=4992

#Cockpit Users and Passwords
#---------------------------
CONFIG_SCC_CSI_SCCADMIN_USER=sccadmin
CONFIG_SCC_CSI_SCCADMIN_PWD=
CONFIG_SCC_CSI_UAFADMIN_USER=uafadmin
CONFIG_SCC_CSI_UAFADMIN_PWD=
CONFIG_SCC_REPOSITORY_PWD=

#Cockpit - Configure a Windows Service
#-------------------------------------
INSTALL_SCC_SERVICE=TRUE
