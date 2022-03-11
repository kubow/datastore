/*
 * CISXP_SETUP2.SQL
 *
 * Some server setups for CIS & XP. This will work only in ASE version 
 * 11.5 or later.
 *
 * First run script SETUP1.SQL and restart the server.
 * Then, run this script.
 *
 * Note that you should first change this script: do a global change of 
 * the string "YOUR_SERVER_NAME" to your actual SQL server name; ensure 
 * this is identical to the change in script CISXP_SETUP1.SQL.
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
sp_configure "xp_cmdshell context", 0
go

/*
 * define a remote server which is actually pointing to yourself
 */
if not exists (select * from master.dbo.sysservers
               where srvname = "YOUR_SERVER_NAME_MYSELF")
   exec sp_addserver YOUR_SERVER_NAME_MYSELF, null, YOUR_SERVER_NAME
go

/*
 * set up remote access authorisation
 * There's various ways of doing this. The proper one would be to
 * do "sp_addexternlogin YOUR_SERVER_NAME_MYSELF, sa, sa, <sa-password>".
 * Easier would be "sp_addremotelogin YOUR_SERVER_NAME_MYSELF", but there's 
 * a built-in check that doesn't allow this for local servers. So either
 * remove that check, or manually insert a row in master..sysremotelogins
 * as happens below. In the below case, this will allows all logins to 
 * do remote access. If you want only a specific login (say 'zzz') to 
 * be enabled, insert the values (0,'zzz',suser_id('zzz'),0).
 */
sp_configure 'allow updates', 1
go

if not exists (select * from master.dbo.sysremotelogins
               where remoteserverid = 0
                 and remoteusername = NULL
                 and suid = -1
                 and status = 0)
    insert master.dbo.sysremotelogins values (0,null,-1,0) 
go

sp_configure 'allow updates', 0
go

/* 
 * end
 */
