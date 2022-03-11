/*
 * This script creates a procedure sp_disk_init which performs a "disk init"
 * to create a new database device. Before doing this, it performs a few
 * checks, like ensuring there is actually enough free disk space available.
 * This makes use of a CIS-related trick, because the main purpose of this 
 * procedure is to demonstrate some of the XP Server and CIS capabilities. 
 * However, even if you're running ASE 11.0, or if you're not using CIS, 
 * it's still a good idea to use this stored procedure. Even though it won't 
 * do a check on the free space, it's still a lot more convenient than using 
 * the plain "disk init" command, for the following reasons:
 * 
 * - you can specify the device size in pages, Kbytes, Mbytes or Gbytes; DISK  
 *   INIT only allows you to specify pages;
 * 
 * - if you don't specify a 'vdevno', the first one that's free will be used.
 * 
 * These two features should hopefully make a DBA's life a bit easier.
 *
 *
 * Installation:
 * 1. First perform some server-level setups for CIS to work correctly. 
 *    These setups are in two scripts that can be downloaded from 
 *    http://www.euronet.nl/~syp_rob/diskinit.html;
 *
 * 2. Next, run this script;
 *
 * 3. Finally, you should be able to execute "sp_disk_init". Without any
 *    parameters, this will display a list of the available options.
 *
 * This procedure was succesfully tested on Windows NT and Solaris. On Unix, 
 * it tries to be clever about the difference between a file system file and 
 * a raw partition: it assumes that anything starting with "/dev/..." is a raw
 * partition. If not, you may want to modify the code to your needs.
 *
 *
 * Copyright note & Disclaimer :
 * =============================
 * This software is provided "as is" -- no warranty.
 * This software is for demonstration purposes only. It may not work correctly 
 * and/or reliably in a production environment. 
 * You can use this software free of charge for your own professional, 
 * non-commercial purposes. 
 * You are not allowed to sell this software or use it for any commercial 
 * purpose. You may (re)distribute only unaltered copies of this software, which
 * must include this copyright note.
 *
 * Please send any comments, bugs, suggestions etc. to the below email address.
 *
 * (c) 1998 Copyright Rob Verschoor
 *                    Sypron B.V.
 *                    P.O.Box 10695
 *                    2501 HR Den Haag
 *                    The Netherlands
 *
 *                    Email: rob@sypron.nl
 *                    WWW  : http://www.euronet.nl/~syp_rob
 *----------------------------------------------------------------------------- 
 */

use sybsystemprocs
go

/*
 * This table and the following procedure are 
 * used to easily pass commands to
 * be executed, to xp_cmdshell
 * This version only works for a single user at a time.
 */
if object_id("xp_cmd_tab") <> NULL
   drop table xp_cmd_tab
go

create table xp_cmd_tab 
             (cmd varchar(100))
go
grant all on xp_cmd_tab to public
go

/*
 * procedure to set up the command to be executed by XP server 
 */
if object_id("sp_setup_xp") <> NULL
   drop proc sp_setup_xp
go

create procedure sp_setup_xp
/* Copyright (c) 1998 Rob Verschoor/Sypron B.V. */
   @cmd varchar(100)
as
begin
   delete sybsystemprocs..xp_cmd_tab

   insert sybsystemprocs..xp_cmd_tab values (@cmd)
end
go
grant execute on sp_setup_xp to public
go

/*
 * This procedure executes a command
 * (previously set up) through XP server
 */
if object_id("sp_run_xp") <> NULL
   drop proc sp_run_xp
go

create procedure sp_run_xp
/* Copyright (c) 1998 Rob Verschoor/Sypron B.V. */
as
begin
   declare @cmd varchar(100)

   select @cmd = cmd 
   from sybsystemprocs..xp_cmd_tab

   exec xp_cmdshell @cmd
end
go
grant execute on sp_run_xp to public
go

/*
 * set up the proxy table
 */
if object_id("proxy_tab") <> NULL
   drop table proxy_tab 
go

sp_dropobjectdef proxy_tab
go

/*
** NOTE: change "SYB" on the next line to the name of 
** your server
*/
sp_addobjectdef proxy_tab, "SYB_MYSELF.sybsystemprocs..sp_run_xp", rpc
go

create existing table proxy_tab (a varchar(100))
go
grant all on proxy_tab to public
go

/*
 * procedure that does a "disk init" plus some useful checks
 */
if object_id("sp_disk_init") <> NULL
   drop proc sp_disk_init
go

create procedure sp_disk_init
/* Copyright (c) 1998 Rob Verschoor/Sypron B.V. */
  @p_name varchar(32) = NULL,
  @p_physname varchar(128) = NULL,
  @p_size varchar(15) = NULL,
  @p_vdevno int = NULL
as
begin
declare @line varchar(80)
declare @cmd varchar(100)
declare @unix_dev varchar(80)
declare @numstr varchar(20)
declare @numbytesfree numeric(15)
declare @numkbfree int
declare @numpagesfree int

declare @numbytesneed numeric(15)
declare @numpagesneed int
declare @numkbneed int
declare @nt int
declare @nr_dev int
declare @return_stat int
declare @use_vdevno int
declare @v115 tinyint
declare @spacecheck tinyint

   /* 
    * suppress rubbish 
    */
   set nocount on

   /* 
    * do free space check unless it's not possible 
    */
   select @spacecheck = 1

   /* 
    * check if it's 11.5 or later
    */
   select @v115 = 0
   if substring(@@version, 1, 26) = "Adaptive Server Enterprise"
   begin
      select @v115 = 1
   end
   else
   begin
      select @spacecheck = 0 /* check not possible 'cos this is ASE 11.0 or earlier */
   end

   /* 
    * figure out if we're on NT or Unix
    */
   select @nt = charindex("/NT/", @@version)

   /* 
    * don't do spacecheck unless it's possible 
    */
   if @p_name = NULL
   begin
      print "Usage: "
      print "====== "
      print "   sp_disk_init"
      print "      ==> displays this messages & list of free vdevno's"
      print " " 
      print '   sp_disk_init "<name>", "<pathname>", "<size>{P|K|M|G}" ' 
      print "      ==> creates a new device using the first free 'vdevno' available."
      print " " 
      print '   sp_disk_init "<name>", "<pathname>", "<size>{P|K|M|G}", <vdevno> '
      print "      ==> creates a new device using the specified 'vdevno'"
      print " " 
      if @nt != 0
      print 'Example: sp_disk_init "mydev", "C:\SYBASE\DATA\MYDEV.DAT", "10M" '
      else
      print 'Example: sp_disk_init "mydev", "/usr/sybase/data/mydev.dat", "10M" '
      print " " 
      print "NB: note the differences with DISK INIT: 'vdevno' is optional, and"
      print "comes last. You should also indicate the unit of size explicitly."
      print "Also, if possible, the amount of free disk space will be checked before the" 
      print "device is created." 
   end

   /* 
    * Generate list of free vdevno's
    * First retrieve "number of devices" config option value
    */
      select @nr_dev = cc.value - 1
        from master..sysconfigures co,
             master..syscurconfigs cc
        where co.name = "number of devices"
          and co.config = cc.config

      select vdevno = identity(3) 
      into #free_vdevno
      where 0 = 1

      while @@identity < @nr_dev
          insert #free_vdevno values()

      delete #free_vdevno
      from master..sysdevices sd, #free_vdevno t
      where sd.cntrltype = 0
        and (sd.low/16777216) = t.vdevno

   /* display list of free vdevno's */
   if @p_name = NULL
   begin
      print " "
      select vdevno "Free 'vdevno' values :"
      from #free_vdevno 
      order by 1

      print "NB: Note that some of these 'vdevno' values may actually still be in use "
      print "until the next server restart."

      drop table #free_vdevno 

      return(0)
   end

   if @v115 = 1
   begin
   /* 
    * check server name have been defined for CIS trick (only for 11.5 or later)
    */
   if @@servername = NULL or 
      (not exists (select * from 
                   master..sysservers 
                   where srvname like "%_MYSELF")
      )
   begin
      print "Both the @@servername and the 'remote' server (xxx_MYSELF) must be defined."
      print "You should first run the scripts SETUP1.SQL and SETUP2.SQL for this."

      select @spacecheck = 0
   end

   /* 
    * check "xp_cmdshell context" config option value (only for 11.5 or later)
    */
   if (select cc.value 
        from master..sysconfigures co,
             master..syscurconfigs cc
        where co.name = "xp_cmdshell context"
          and co.config = cc.config ) != 0
   begin
      select @line = "You must first modify the ""xp_cmdshell context"" configuration"
      print @line 
      print "parameter using the following command:"
      print " sp_configure ""xp_cmdshell context"", 0 "

      select @spacecheck = 0
   end

   /* 
    * check "enable cis" config option value (only for 11.5 or later)
    */
   if (select cc.value 
        from master..sysconfigures co,
             master..syscurconfigs cc
        where co.name = "enable cis"
          and co.config = cc.config ) != 1
   begin
      select @line = "You must first modify the ""enable cis"" configuration"
      print @line 
      print "parameter using the following command:"
      print " sp_configure ""enable cis"", 1 "

      select @spacecheck = 0
   end
   end /* if @v115 = 1 */

   /* 
    * If no vdevno was specified, use the first one that seems to be free
    * There no 100% guarantee that this is right though, because of devices that have
    * just been dropped...
    */
   if @p_vdevno = NULL
   begin
      select @use_vdevno = min(vdevno) 
      from #free_vdevno
   end
   else
   begin
   /* 
    * Figure out if vdevno may be too high or already in use
    */
      if @p_vdevno > @nr_dev
      begin
         print "The value you specified for 'vdevno' (%1!) exceeds the configured maximum (%2!)",
               @p_vdevno, @nr_dev
         drop table #free_vdevno 
         return (-1)
      end

      if not exists
        (select vdevno from #free_vdevno
         where vdevno = @p_vdevno)
      begin
        print "The value you specified for 'vdevno' (%1!) is already in use.", @p_vdevno
        print "Execute sp_disk_init without parameters for a list of free 'vdevno' values."
        drop table #free_vdevno 
        return (-1)
      end

      /* 
       * Value seems OK at first sight, so use it. If it doesn't work, user should specify
       * a free value explicitly and/or reboot the server.
       */
      select @use_vdevno = @p_vdevno
   end 
   drop table #free_vdevno 

   /* 
    * figure out specified size using Sybase's sp_aux_getsize SP
    */
   exec @return_stat = sp_aux_getsize @p_size, @numkbneed output

   if @return_stat = 0
   begin
      print "The specified size is invalid."
	return(-1)
   end

   if @p_size not like "%[KkPpMmGg]%"
   begin
      print "Please specify a valid unit (P,K,M or G) for the size of the device."
      print "Examples: 5120P, 20M, 2048K."
	return(-1)
   end

   if @numkbneed < 1024
   begin
      print "Minimum device size is 1 Mb."
	return(-1)
   end

   if (@numkbneed%1024) != 0
   begin
      print "The device size should be an exact multiple of 1 Mb (or 512 pages)."
	return(-1)
   end

   /* convert device size to pages */
   select @numpagesneed = @numkbneed / 2
   
   /* 
    * informational message to user 
    */
   if @p_vdevno = NULL
   begin
      print "Using value %1! for 'vdevno'.", @use_vdevno
      print "(NB: if this value is still in use, you should restart the server "
      print " or specify a different 'vdevno' value)"
   end

   /* 
    * Determine the amount of free space on target disk, but only if this is possible:
    * CIS & XP should be enabled and we should be on 11.5 or later
    */
   if @spacecheck = 0
   begin
      print "Free disk space will not be checked."
   end
   else
   begin

   if @nt != 0
   begin
      /* we're on NT */
      if @p_physname not like "[a-zA-Z]:\%"
      begin
         print "You should specify a full pathname on a local disk, "
         print "for example C:\SYBASE\DATA\MYDEVICE.DAT"
         return(-1)
      end

      select @cmd = 'dir ' + substring(@p_physname,1,2) + ' | findstr /c:"bytes free"'
    end
   else
   begin
      /* we're on Unix */
      if @p_physname not like "/_%/_%"
      begin
         print "You should specify a full pathname on a local disk, "
         print "for example /usr/sybase/data/mydevice.dat"
         return(-1)
      end

      /*
       * Determine device name; this may need to be improved for raw partitions
       * Next, figure out free space left on this device. You may need to tweak
       * this a bit to make it work on your flavour of Unix...
       */
      if @p_physname like "/dev/%"
      begin
        -- looks like a raw partition ...
        select @cmd = "df -k " + @p_physname + "| awk '{print $4 ""QQQ""}' " 
      end
      else
      begin
         select @unix_dev = reverse(
                              substring(reverse(@p_physname),
                                 charindex("/", reverse(@p_physname))+1, 999) 
                            )
     
         select @cmd = "df -k " + @unix_dev + "| awk '{print $4 ""QQQ""}' " 
      end
   end

   /*
    * Pick up the output from the SP, which contains the disk information.
    * Note that every time you select from a proxy table, the associated 
    * procedure is executed again. Therefore, you should immediately 
    * store the data in another table using SELECT...INTO.
    * Another trick is to put an identity column in this table, so 
    * that you get line numbers; handy when multiple lines are returned.
    */
   exec sp_setup_xp @cmd

   select line=identity(4), a
   into #temptab_1
   from sybsystemprocs..proxy_tab 

   if @nt != 0
   begin
      /* we're on NT */
      -- select * from #temptab_1

      select @numstr = ltrim(substring(a,1,charindex(" bytes", a)))
      from #temptab_1 
      where a like "%bytes free%"

      while @numstr like "%.%"
      begin
         select @numstr = substring(@numstr,1,charindex(".", @numstr)-1) +
                          substring(@numstr,charindex(".", @numstr)+1,99)
      end

      select @numbytesfree = convert(numeric(15), @numstr) 

      if @numbytesfree = NULL
      begin
          print " "
          print "The specified device does not exist or is not accessible."
          return(-1)
      end
      else
      begin
          select @numkbfree = @numbytesfree / 1024
          -- select @numbytesfree "Number of bytes free"
      end
   end
   else
   begin
      /* we're on Unix */
      -- select * from #temptab_1

      /* 
       * Pick up the line that matters. The "QQQ" marker is for avoiding problems
       * with carriage-return characters
       */
      select @numstr = substring(a,1,charindex("QQQ",a)-1)
      from #temptab_1 
      where a like "%[0-9]QQQ%" 

      select @numkbfree = convert(int, @numstr)

      if @numkbfree = NULL
      begin
          print " "
          print "The specified device does not exist or is not accessible."
          return(-1)
      end
   end

   /* clean up */
   drop table #temptab_1

   /* 
    * Tell user if there's not enough disk space
    */
   select @numkbneed = @numpagesneed*2
   select @numpagesfree = @numkbfree/2

   if @numpagesneed > @numpagesfree
   begin
       print " "
       print "There is not enough free disk space available for this device: you specified "
       print "a device size of %1! Kbytes, but only %2! Kbytes are available.",
             @numkbneed, @numkbfree
       return(-1)
   end

   end  /* if @spacecheck = 0 */

   /* 
    * Finally, issue the "DISK INIT" command...
    */
   print "Running DISK INIT command now..."

   disk init 
      name = @p_name,
      physname = @p_physname,
      vdevno = @use_vdevno,
      size = @numpagesneed

   /*
    * Check for success. In fact, if there's anything wrong, the batch will often
    * be aborted so that this code is not executed anymore.
    */
   if not exists 
      (select * from master..sysdevices
       where name = @p_name)
   begin
      print "*** device was not created. Check server errorlog for details ***"
   end
   else
   begin
      print "DISK INIT ready."
   end

   /* 
    * Ready...
    */
   return (0)
end
go
grant execute on sp_disk_init to public
go

/* 
 * End of file
 */

