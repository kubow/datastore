# IQ Installation and Licensing
[Topics related with SAP IQ installations, upgrade and configurations - SAP IQ - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBIQ/Topics+related+with+SAP+IQ+installations%2C+upgrade+and+configurations)
[SAP IQ Best Practices and Hardware Sizing Guide - SAP IQ - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBIQ/SAP+IQ+Best+Practices+and+Hardware+Sizing+Guide)

## Pre-installation
Pre-Installation Tasks:

- Check for OS patches
- Increase Swap space
- License server requirements
- Verify network functionality

JVM (version 8) must be installed in order to run GUI installation.
[1367498 - SAP JVM installation prerequisites - SAP ONE Support Launchpad](https://launchpad.support.sap.com/#/notes/1367498)
### Windows additionally reuires:

- Microsoft Visual C++ 2010 Redistributable Package
- Microsoft Visual C++ 2013 Redistributable Package
- Microsoft Visual C++ 2015 Redistributable Package (for latest versions SP04)

### Linux additionally requires:
- libncurses5
- ksh can be switched to sh
- csh (for running installation scripts)
- libXext-devel.i686 & libXtst-devel.i686 (RedHat 6 specifically)

## Licensing
[Topics related to IQ licensing - SAP IQ - Support Wiki](https://wiki.scn.sap.com/wiki/display/SYBIQ/Topics+related+to+IQ+licensing)
[Sybase IQ license approach | SAP Community](https://answers.sap.com/questions/10522350/sybase-iq-license-approach.html)
[SAP IQ Guide to Licensed Options | SAP Help Portal](https://help.sap.com/docs/SAP_IQ/a89994a284f21015972db21085ce7508/2cbf3cfd92f04045b9d84f5ee6599a5d.html)

**Orderable License (Actual License)** - Description:

- **CPU(IQ_CORE)** - Restricts the number of cores (not CPUs) the server can use.
- **VLDB MO(IQ_VLDBMGMT)** - Lets you create multiple tablespaces and dbspaces beyond the defaults. Each VLDB license allows for 1 TB of storage. Additional licenses are required for each additional TB of storage in the main store. Also supports table partitioning.
- **ASO(IQ_SECURITY)** - Enables column, ECC Kerberos and FIPS encryption options. The number of ASO licenses must match the number of cores.
- **MPXO(IQ_MPXNODE)** - Allows you to starts secondary multiplex nodes (readers/writers). The number of nodes must always be less than cores, as each multiplex server must have at least one core.
- **IDBA-PSO(IQ_UDF)** - Lets you define and run high-performance scalar and aggregate user-defined functions. Available with approved third-party libraries only.
- **IDBA-PSO(IQ_IDA)** - Allows you to build, deploy and run C/C++ V4 User-Defined Functions (UDF). The IQ_IDA license will function as both the InDatabase Analytics Option and Partner Solutions license.
- **UDA(IQ_UDA)** - Applies to TEXT indexes and enables the IQ text search functionality, which lets search unstructured and semi-structured data. An IQ_UDA also includes an IQ_LOB license.

- [Unstructured Data Analytics](https://help.sap.com/viewer/a89994a284f21015972db21085ce7508/16.1.3.0/en-US/a865984584f21015991a9b711a98455d.html): The Unstructured Data Analytics Option (IQ_UDA) supports binary large object (BLOB) and character large object (CLOB) storage and retrieval.
- [Advanced Security](https://help.sap.com/viewer/a89994a284f21015972db21085ce7508/16.1.3.0/en-US/a865ccca84f210158619a0b60bfbd468.html): The Advanced Security Option (IQ_SECURITY) protects your environment against unauthorized access.
- [Multiplex Grid](https://help.sap.com/viewer/a89994a284f21015972db21085ce7508/16.1.3.0/en-US/a865fe5b84f210158286c30631873ac9.html): The Multiplex Grid Option lets you add nodes to a multiplex environment, enabling a highly scalable shared disk grid technology.
- [Very Large Database Management](https://help.sap.com/viewer/a89994a284f21015972db21085ce7508/16.1.3.0/en-US/a8662f9384f210158530892a1ace3e42.html): The Very Large Database Management Option (IQ_VLDBMGMT) lets you logically partition very large data sets into smaller subsets.
- [In-Database Analytics Option](https://help.sap.com/viewer/a89994a284f21015972db21085ce7508/16.1.3.0/en-US/a86f210a84f2101599b7b602ec97d607.html): The In-Database Analytics Option enables customers to build, deploy and run their own C/C++ User-Defined Functions (UDFs).

## Post-installation
[Postinstallation Tasks | SAP Help Portal](https://help.sap.com/docs/SAP_IQ/8214756b4d314d09a86fef212e2036d1/710501e9aadd4f8c900e42f84a996c90.html?version=16.1.3.0)
add sourcing to .profile:

```
. /opt/sap_iq/SYBASE.sh
```


## Upgrading
[1902753 - Sybase IQ upgrade from 12.7 to 15.x - schema unload mode - basic steps - SAP ONE Support Launchpad](https://launchpad.support.sap.com/#/notes/1902753)

[Issues after upgrading to IQ 16.0 SP3 | SAP Community](https://answers.sap.com/questions/10674103/issues-after-upgrading-to-iq-160-sp3.html)
