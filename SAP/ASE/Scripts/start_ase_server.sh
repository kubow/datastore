#!/bin/bash
. /opt/sap_ase/SYBASE.sh
servername=SapMint_ds
inst_path=${SYBASE}/${SYBASE_ASE}/install/

[ -e ${SYBASE}/${SYBASE_ASE}/install/startserver ] && vsn=15 || vsn=16
[ ${vsn} -le 15 ] && bin_path=${SYBASE}/${SYBASE_ASE}/install/ || bin_path=${SYBASE}/${SYBASE_ASE}/bin/

echo "ASE "${vsn}" :"${bin_path}" - "${servername}

#determine if server running
if ps -eaf | grep dataserver 'sybase'; then
#if showserver 'sybase'; then
	echo "server is running"
else
	echo "starting sever" 
	${bin_path}startserver -f ${inst_path}RUN_${servername}
fi
 
#if ps -eaf | grep dataserver 'sybase'; then
#	echo "server is running"
#else
#	echo "need to start sever"
#	echo ${bin_path}startserver -f ${inst_path}RUN_${servername}
#fi
