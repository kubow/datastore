# ASE Installation and Licensing


## Pre-installation
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




## Post-installation

add sourcing to .profile:

```
. /opt/sap_ase/SYBASE.sh
```