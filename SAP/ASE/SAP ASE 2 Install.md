# ASE Installation and Licensing

1. [Pre-Installation](#pre-installation)
2. [Installation](#installation)
3. [Post-installation](#post-installation)
4. [Editions](#editions)
5. [Licensing](#licensing)
6. [Versions](#versions)
7. [Upgrading](#upgrading)

## Pre-installation

- Prepare operating system
	- Disk space: approx. 1.5Gb, 4Gb enough to handle upgrades
	- Security concerns: prepared users, rights and directories
	- Performance: increase deafult value for shared memory (kernel.shmmax=4294967296)
- Installing additional libraries:
	- JVM (version 8 + [prerequisities](https://launchpad.support.sap.com/#/notes/1367498)) must be installed in order to run GUI installation.
		- Windows reuires:
			- Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package ([source 32/64bit](https://www.microsoft.com/en-us/download/details.aspx?id=26999))
			- Microsoft Visual C++ 2013 Redistributable Package ([source 32/64bit](https://www.microsoft.com/en-us/download/details.aspx?id=40784))
			- Microsoft Visual C++ 2015 Redistributable Package (for latest versions SP04)
		- Linux requires ([Certification information](https://launchpad.support.sap.com/#/notes/1941500)):
			- libncurses5
			- ksh can be switched to sh
			- csh (for running installation scripts)
			- libXext-devel.i686 & libXtst-devel.i686 (RedHat 6 specifically)
			- install libaio1 libaio1-dev (OpenSUSE) 
- Create Raw devices from operating system defined partitions
	- change ownership of these devices

https://dreamsbythelake.com/articles/AWS_EC2_setup_for_Sybase_ASE.html


## Installation

```
su - sybase
./installation_media/setup.bin


```

Installation variables

| Purpose | Unix / Linux | Windows |
| --- | --- | --- |
| ASE release directory | $SYBASE | %SYBASE% |
| ASE binaries | $SYBASE_ASE | %SYBASE_ASE% |
| ASE libraries | $SYBASE_OCS | %SYBASE_OCS% |
| ASE specialized libraries | $LD_LIBRARY_PATH | %CLASSPATH% |
| Server name | $DSLISTEN <br/> $DSQUERY | %DSLISTEN% <br/> %DSQUERY% |

![[ASE_DirStructure.png]]



## Post-installation

after installation finished continue:

```sh
. /opt/ase_path/SYBASE.sh >> $HOME/.profile #or /etc/profile.d/SYBASE.sh
cd $SYBASE/$SYBASE_ASE/bin  
srvbuildres -r $SYBASE/$SYBASE_ASE/init/sample_resource_files/ASE.rs
export LC_ALL=en_US.UTF-8 >> $HOME/.profile #for system locale  
export JAVA_HOME=${SAP_JRE} >> $HOME/.profile #for java use
cd /opt/sybase/ASE-15_0/install/ #run directory  
./startserver -f ./RUN_sybsol_ds  
ps -eaf | grep dataserver #verification server run  
netstat -na | grep 2025 #verification port listen  
isql -Usa -Ssybsol_ds #connect   
$SYBASE/DBISQL/dbisql #gui
```


New connections

- linux $SYBASE/interfaces
- windows %SYBASE%ini/sqli.ini

## Editions
Currently there are 6 different SAP ASE editions. they are:

- SAP Adaptive Server Platform Edition
- SAP Adaptive Server Enterprise Edition
- SAP Adaptive Server Cluster Edition
- SAP Adaptive Server Runtime
- SAP Adaptive Server Express Edition
- SAP Adaptive Server Edge Edition

## Licensing

Options

- ASE_HA
- ASE_ASM
- ASE_EJB
- ASE_EFTS
- ASE_DIRS
- ASE_XRAY
- ASE_ENCRYPTION
- ASE_CORE - basic core license
- ASE_PARTITIONS
- ASE_RLAC
- ASE_MESSAGING_TIBJMS
- ASE_MESSAGING_IBMMQ
- ASE_MESSAGING_EASJMS
- ASE_TSM
- ASE_IMDB - In-Memory DataBase
- ASE_RDDB - Relaxed Durability DataBase
- ASE_DTU
- ASE_COMPRESSION
- ASE_PRIVACY
- ASE_WORKLOADANALYZER
- ASE_ALWAYS_ON
- ASE_MEMSCALE


## Versions
[[SAP ASE Release Builletins]]
[A Deeper Look At Sybase: History of ASE | SAP Blogs](https://blogs.sap.com/2011/04/15/a-deeper-look-at-sybase-history-of-ase/)

[Targeted ASE 15.x Release Schedule and CR list Information - SAP ASE - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBASE/Targeted+ASE+15.x+Release+Schedule+and+CR+list+Information)
[Targeted ASE 16.0 Release Schedule and CR list Information - SAP ASE - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBASE/Targeted+ASE+16.0+Release+Schedule+and+CR+list+Information)

[ASE 16.0 New Features](http://smooth1.co.uk/ase/ase16.html)

## Upgrading

[1590719 - SYB: Updates for SAP Adaptive Server Enterprise (SAP ASE) - SAP ONE Support Launchpad](https://launchpad.support.sap.com/#/notes/0001590719)
