#data server settings
sybinit.release_directory: USE_DEFAULT
sybinit.product: sqlsrv
sqlsrv.server_name: sybsol_ds
sqlsrv.sa_password: sybase
sqlsrv.new_config: yes
sqlsrv.do_add_server: yes
sqlsrv.network_protocol_list: tcp
sqlsrv.network_hostname_list: SybSol11
sqlsrv.network_port_list: 2025
sqlsrv.application_type: USE_DEFAULT
sqlsrv.server_page_size: USE_DEFAULT
sqlsrv.force_buildmaster: no
sqlsrv.master_device_physical_name: /opt/sybase/data/sybsol_master.dat
sqlsrv.master_device_size: 100
sqlsrv.master_database_size: 24
sqlsrv.errorlog: USE_DEFAULT
sqlsrv.do_upgrade: no
sqlsrv.sybsystemprocs_device_physical_name: /opt/sybase/data/sybsol_sysproc.dat
sqlsrv.sybsystemprocs_device_size: USE_DEFAULT
sqlsrv.sybsystemprocs_database_size: USE_DEFAULT
sqlsrv.sybsystemdb_device_physical_name: /opt/sybase/data/sybsol_sybsyst.dat
sqlsrv.sybsystemdb_device_size: USE_DEFAULT
sqlsrv.sybsystemdb_database_size: USE_DEFAULT
sqlsrv.tempdb_device_physical_name: /opt/sybase/data/sybsol_temp.dat
sqlsrv.tempdb_device_size: 100
sqlsrv.tempdb_database_size: USE_DEFAULT
sqlsrv.default_backup_server: sybsol_bs
#sqlsrv.addl_cmdline_parameters: PUT_ANY_ADDITIONAL_COMMAND_LINE_PARAMETERS_HERE
sqlsrv.do_configure_pci: no
#sqlsrv.sybpcidb_device_physical_name: PUT_THE_PATH_OF_YOUR_SYBPCIDB_DATA_DEVICE_HERE
#sqlsrv.sybpcidb_device_size: USE_DEFAULT
#sqlsrv.sybpcidb_database_size: USE_DEFAULT
# If sqlsrv.do_optimize_config is set to yes, both sqlsrv.avail_physical_memory and sqlsrv.avail_cpu_num need to be set.
sqlsrv.do_optimize_config: no
#sqlsrv.avail_physical_memory: PUT_THE_AVAILABLE_PHYSICAL_MEMORY_FOR_ASE_IN_OPTIMIZATION
#sqlsrv.avail_cpu_num: PUT_THE_AVAILABLE_NUMBER_CPU_FOR_ASE_IN_OPTIMIZATION

#backup server settings
sybinit.release_directory: USE_DEFAULT
sybinit.product: bsrv
bsrv.server_name: sybsol_bs
bsrv.new_config: yes
bsrv.do_add_backup_server: yes
bsrv.do_upgrade: no
bsrv.network_protocol_list: tcp
bsrv.network_hostname_list: SybSol11
bsrv.network_port_list: 2025
bsrv.language: USE_DEFAULT
bsrv.character_set: USE_DEFAULT
bsrv.tape_config_file: USE_DEFAULT
bsrv.errorlog: USE_DEFAULT
sqlsrv.related_sqlsrvr: sybsol_ds
sqlsrv.sa_login: sa
sqlsrv.sa_password: USE_DEFAULT
#bsrv.addl_cmdline_parameters: PUT_ANY_ADDITIONAL_COMMAND_LINE_PARAMETERS_HERE

