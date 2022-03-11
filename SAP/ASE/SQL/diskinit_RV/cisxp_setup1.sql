/*
 * CISXP_SETUP1.SQL
 *
 * Some server setups for CIS & XP. This will work only in ASE version 
 * 11.5 or later.
 * 
 * Note that you should first change this script: do a global change of 
 * the string "YOUR_SERVER_NAME" to your actual SQL server name; ensure 
 * this is identical to the change in script CISXP_SETUP2.SQL.
 *
 * Note that there's a server shutdown at the end.
 * After restarting the server, run script CISXP_SETUP2.SQL.
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
 * (c) 1999 Copyright Rob Verschoor
 *                    Sypron B.V.
 *                    P.O.Box 10695
 *                    2501 HR Den Haag
 *                    The Netherlands
 *
 *                    Email: rob@sypron.nl
 *                    WWW  : http://www.euronet.nl/~syp_rob
 *----------------------------------------------------------------------------- 
 */

use master
go

/*
 * Check we're on ASE 11.5 at least
 */
    if substring(@@version, 1, 26) != "Adaptive Server Enterprise"
    begin
       print "***" 
       print "***" 
       print "*** You can only use CIS and/or XP features on ASE version 11.5 or later." 
       print "*** These features do not exist in your current version of ASE, sorry..." 
       print "***" 
       print "***" 
    end
go

/*
 * Fix bug in definition of @@servername on ASE 11.5 
 * 
 * (If you created your server with the default Sybase 
 * 'srvbuild' or 'srvbuildres' tools, this will have 
 * been set up wrong. For an alternative, check out 
 * the free tool "sybinit4ever" at
 * http://www.euronet.nl/~syp_rob/si4evr.html)
 */
if exists( select * from master..sysservers 
           where srvname="local" )
  exec sp_dropserver local
go

if not exists( select * from master..sysservers 
               where srvid=0 )
  exec sp_addserver YOUR_SERVER_NAME, local
go

/*
 * add XP servername if not there yet
 * Note that the interfaces file should also contain an entry
 * for this XP server
 */
if not exists( select * from master..sysservers 
               where srvname="YOUR_SERVER_NAME_XP" )
  exec sp_addserver YOUR_SERVER_NAME_XP, null, YOUR_SERVER_NAME_XP
go

/*
 * some config options to set up CIS & XP
 */
sp_configure "enable cis", 1 
go
sp_configure "max cis remote connections", 5
go

/*
 * now restart the server for these changes to take effect:
 */
shutdown
go

/* 
 * restart the server now, and run the script "CISXP_SETUP2.SQL"
 */
