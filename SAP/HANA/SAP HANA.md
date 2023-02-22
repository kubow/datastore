[SAP HANA Cloud](https://www.sap.com/products/technology-platform/hana.html)
[SAP HANA Platform | SAP Help Portal](https://help.sap.com/docs/SAP_HANA_PLATFORM)
[SAP HANA on-premises and cloud databases | SAP Community](https://community.sap.com/topics/hana)

[Comparison between SAP HANA with SAP Sybase IQ – first impressions | SAP Blogs](https://blogs.sap.com/2013/09/25/comparison-between-sap-hana-with-sap-sybase-iq-first-impressions/)
[Comparing SAP HANA and Sybase IQ – real world performance tests | SAP Blogs](https://blogs.sap.com/2013/11/25/comparing-sap-hana-and-sybase-iq-real-world-performance-tests/)

A Look Inside the SAP HANA Data Management Suite https://blogs.saphana.com/2018/06/05/a-look-inside-the-sap-hana-data-management-suite/
Continuous and Customer-Driven Innovation with SAP HANA https://blogs.saphana.com/2018/06/05/continuous-and-customer-driven-innovation-with-sap-hana/
Transforming Our World for the Better with Data https://blogs.saphana.com/2018/05/30/transforming-our-world-for-the-better-with-data/
Intelligent Container – powered by SAP HANA https://blogs.saphana.com/2018/09/27/intelligent-container-powered-sap-hana/
https://blogs.sap.com/2019/11/12/introduction-to-the-relational-data-lake-service-dat106-sapteched-recap/



# System

Each host holds instance, which joins into system:

- Host
- Instance
- System
	- Single-Host
	- Multiple-Host (Distributed)

MDC - Multitenant Database Container (since HANA 2.0 SP01 the only option)

[SAP HANA Tutorials, Tcodes, Tables (testingbrain.com)](https://www.testingbrain.com/sap/help/sap-hana-tutorial.html)
[SAP HANA platform lifecycle management – by the SAP HANA Academy | SAP Blogs](https://blogs.sap.com/2018/01/30/sap-hana-platform-lifecycle-management-by-the-sap-hana-academy/)

HANA supports replication:
-   SLT trigger based 
-   SAP RepSrv log based 
-   SAP HANA remote data sync session based


# Installation

[2235581 - SAP HANA: Supported Operating Systems - SAP ONE Support Launchpad](https://launchpad.support.sap.com/#/notes/2235581)

[Certified and Supported SAP HANA® Hardware Directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=v:deCertified)

Installation types:

- Installation Modes (Interactive/Batch)
- Parameter Specification Methods (Interactively, Command Line Options)
- Configuration File

Vesrioning 

Releases
[SAP HANA Database 2.0 - SAP HANA - Support Wiki](https://wiki.scn.sap.com/wiki/display/SAPHANA/SAP+HANA+Database+2.0)


GCP worklist

```sh
ssh machine
su - hanaadm
# prepare disk storage
sudo lsblk
sudo fdisk /dev/sdb
sudo mkfs.xfs /dev/vgdata/hana_shared
df –Th
sudo cat /etc/fstab
# inside GCP
gsutil -m cp -r gs://hana_2_platform_june_2020/ /hana/log/install/
# after install finished, run as root
sudo ./hdblcm --configfile=/home/user/hana_log/hdblcm.cfg --install_execution_mode=optimized
```


### Versions

What’s New in SAP HANA Cockpit SP 07 + Webcast https://blogs.saphana.com/2018/08/09/whats-new-sap-hana-cockpit-sp-07-webcast/


# Maintain

[Introduction to SAP HANA Administration | SAP Help Portal](https://help.sap.com/docs/SAP_HANA_PLATFORM/6b94445c94ae495c83a19646e7c3fd56/bd394568bb571014a11fd729973e9843.html?version=2.0.00)

[SAP HANA System Down, HANA not starting - SAP HANA - Support Wiki](https://wiki.scn.sap.com/wiki/display/SAPHANA/SAP+HANA+System+Down%2C+HANA+not+starting)

SAP HANA Expert Webinar Series – September/October 2018 https://blogs.saphana.com/2018/08/22/sap-hana-expert-webinar-series-september-october-2018/
SAP HANA iFG Expert Webinar Series – November/December 2018 https://blogs.saphana.com/2018/10/29/draft-sap-hana-expert-webinar-series-november-december-2018/

```sh
HDB info #show running services  
HDB stop && HDB start #restart database  
/sbin/ifconfig #get IP address  
#add IP address to hosts (win C:\Windows\System32\drivers\etc\hosts)  
cd /usr/sap/HXE/HDB90 #dir with env settings  
cd /usr/sap/HXE/home #dir with home  
xs login -u XSA_ADMIN -p "Prdel123" -s SAP  
xs apps # show running apps
```


| port | address |  description  | 
| --- | --- | --- |
|  1129 | /lmsl/HDBLCM/HOP/index.html | HDBLCM |
| 53075 | /login/callback | main login page |
| 30030 |  | xsa main site |


### Backup & Recovery

[SAP HANA Backup and Recovery - SAP HANA - Support Wiki](https://wiki.scn.sap.com/wiki/display/SAPHANA/SAP+HANA+Backup+and+Recovery)

- Concept of Backup & Recovery
- Data Area Backup
- Log Area Backup
- Additional Backup Topics
- Recovery
- Backup & Recovery using Storage Snapshot


### HADR

High Availibility
- [SAP HANA System Replication videos now available on the SAP HANA Academy | SAP Blogs](https://blogs.sap.com/2015/05/19/sap-hana-system-replication/)
- [How To Perform System Replication for SAP HANA](https://www.sap.com/documents/2013/10/26c02b58-5a7c-0010-82c7-eda71af511fa.html)
SAP HANA Scale Out


Extra
[SAP S/4 HANA – S/4 HANA Export (saphanadb.com)](http://saphanadb.com/?lang=en)
