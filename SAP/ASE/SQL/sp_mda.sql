/*
 * SP_MDA.SQL
 *
 * Description
 * ===========
 * This file contains various stored procedures related to the so-called
 * "MDA tables". These tables provide low-level monitoring information. They
 * were introduced in ASE 12.5.0.3.
 *
 * This version is for ASE 15.0.2 and later.
 * On ASE 12.5, use www.sypron.nl/sp_mda.125.sql.
 *
 * This script installs the following procedures:
 *    sp_mda_help - for searching through MDA table/columns names
 *    sp_mda_io   - monitors logical I/O by currently running T-SQL statements
 *    sp_mda_wait - displays wait event info
 *    sp_mda_monOpenObjectActivity - calculates deltas for monOpenObjectActivity for the session
 *    sp_mda_diskIO - calculates average disk I/O completion time
 *
 * For usage information, specify '?' as the first parameter
 * to these procedures.
 *
 *
 * Installation
 * ============
 * Execute this script using "isql", using a login having 'sa_role'.
 * The stored procedures will be created in the sybsystemprocs database.
 *
 *
 * Notes
 * =====
 * For more information about the MDA tables, check www.sypron.nl/mda .
 *
 *
 * Revision History
 * ================
 * Version 1.0    Jun-2003  First version
 * Version 1.1    Aug-2004  Added sp_mda_wait; various improvements
 * Version 1.2    Jan-2005  Adapted for case-insensitive sort order
 * Version 1.3    May-2010  Added sp_mda_monOpenObjectActivity
 * Version 1.4    Sep-2010  Added sp_mda_diskIO
 * Version 1.5    Nov-2010  Show rowcount+size in sp_mda_monOpenObjectActivity
 *                          Also created a separate version for 12.5
 * Version 1.6    Mar-2013  Fixed integer overflow in sp_mda_diskIO
 *
 *
 * Copyright Note & Disclaimer :
 * =============================
 * This software is provided "as is"; there is no warranty of any kind.
 * While this software is believed to work accurately, it may not work
 * correctly and/or reliably in a production environment. In no event shall
 * Rob Verschoor and/or Sypron B.V. be liable for any damages resulting
 * from the use of this software.
 * You are allowed to use this software free of charge for your own
 * professional, non-commercial purposes.
 * You are not allowed to sell or bundle this software or use it for any
 * other commercial purpose without prior written permission from
 * Rob Verschoor/Sypron B.V.
 * You may (re)distribute only unaltered copies of this software, which
 * must include this copyright note, as well as the copyright note in
 * the header of each stored procedure.
 *
 * Note: All trademarks are acknowledged.
 *
 * Please send any comments, bugs, suggestions etc. to the below email
 * address.
 *
 * Copyright (c) 2003-2013 Rob Verschoor/Sypron B.V.
 *                         The Netherlands
 *
 *                         Email: sypron@sypron.nl
 *                         WWW  : http://www.sypron.nl/
 *----------------------------------------------------------------------------
 */

set nocount on
go
set flushmessage on
go

-- check we have sa_role
if charindex("sa_role", show_role()) = 0
begin
   print ""
   print ""
   print " This script requires 'sa_role'."
   print " Aborting..."
   print " "
   print " "
   print ""
   set background on  -- terminate this script now
end
go

-- We need to be in 12.5.0.3+
-- First test for 12.0 to avoid a syntax error on license_enabled()
if isnull(object_id("master.dbo.sysqueryplans"),99) >= 99
begin
   print ""
   print ""
   print " This script requires ASE 12.5.0.3 or later."
   print " Aborting..."
   print " "
   print " "
   print ""
   set background on  -- terminate this script now
end
go

-- if we're in ASE pre-15 refer to the 12.5 version
if isnull(object_id("master.dbo.syspartitionkeys"),99) >= 99
begin
   print ""
   print ""
   print " For ASE pre-15, use www.sypron.nl/sp_mda.125.sql instead."
   print " Aborting..."
   print " "
   print " "
   print ""
   select syb_quit()  -- terminate this script now
end
go

-- Now test for 15.0.2... this is needed because we call the 'index_name()' built-in
if @@version_number/10 < 1502
begin
   print ""
   print ""
   print " This script requires ASE 15.0.2 or later."
   print " Aborting..."
   print " "
   print " "
   print ""
   select syb_quit()  -- terminate this script now
end
go

-- Check whether the user has already installed the MDA tables
if object_id('master..monTables') = NULL
begin
   print ""
   print ""
   print " This script requires the MDA tables to be installed."
   print " Among other things, this involves executing the 'installmontables'"
   print " script."
   print " See the ASE documentation, or www.sypron.nl/mda, for more "
   print " information."
   print " "
   print " Aborting..."
   print " "
   print " "
   print ""
   select syb_quit()  -- terminate this script now
end
go

use sybsystemprocs
go

print ""
print " Installing 'sp_mda_help' ..."
go

if object_id('sp_mda_help') <> NULL
    drop proc sp_mda_help
go

create proc sp_mda_help
/* Copyright (c) 2003-2010 Rob Verschoor/Sypron B.V. */
   @tab varchar(30) = NULL,
   @col varchar(30) = NULL
as
begin
  declare @n int, @match varchar(40), @TabID int

  if @tab = '?'
  or (@tab = NULL and @col = NULL)
  begin
      print " "
      print " Usage: sp_mda_help { table_name_pattern | column_name_pattern }"
      print ""
      print " This procedure displays information about MDA tables and/or columns"
      print " "
      print " Arguments:"
      print "   table_name_pattern   - pattern matching MDA table names"
      print "   tcolumn_name_pattern - pattern matching MDA column names"
      print ""
      print  "Examples:"
      print "   Find all tables with cache information:"
      print "      sp_mda_help 'cache' "
      print ""
      print "  Find all columns related to SQL text or statements:"
      print "      sp_mda_help null, 'sql' "
      print ""
      print " Copyright (c) 2003-2010 Rob Verschoor/Sypron B.V."
      print " Visit www.sypron.nl/mda"
      print " "
      return 0
  end

  if @tab = NULL select @tab = "%"
  if @col = NULL select @col = "%"

  if @tab != "%"
  begin
     select @match = upper(@tab)

     select @n = count(*)
     from master..monTables
     where upper(TableName) like @match

     if @n = 0
     begin
        select @match = "%"+upper(@tab)+"%"

		select @n = count(*)
		from master..monTables
		where upper(TableName) like @match
     end

     if @n = 1
     begin
		select @TabID = TableID
		from master..monTables
		where upper(TableName) like @match

		select TableName, Description
		from master..monTables
		where upper(TableName) like @match

		select ColumnName + "    "  + substring(TypeName,1,9)  + "   " + Description
		from master..monTableColumns
		where TableID = @TabID

		select ParameterName + "    "  + substring(TypeName,1,9)  + "   " + Description
		from master..monTableParameters
		where TableID = @TabID
     end

     if @n > 1
     begin
		select TableName = TableName + "     " + Description
		from master..monTables
		where upper(TableName) like "%"+upper(@tab)+"%"
		order by TableName
     end
  end

  if @col != "%"
  begin
     select TableName, ColumnName, substring(TypeName,1,9) TypeName
     from master..monTableColumns
     where upper(ColumnName) like "%"+upper(@col)+"%"
     order by 1,2
  end
end
go

grant execute on sp_mda_help to public  -- mon_role is needed anyway
go
dump tran sybsystemprocs with truncate_only
go

----------------------------------------------------------------------------

if object_id('sp_mda_io') <> NULL
    drop proc sp_mda_io
go

print ""
print " Installing 'sp_mda_io' ..."
go

create procedure sp_mda_io
/* Copyright (c) 2003-2005 Rob Verschoor/Sypron B.V. */
    @p_cmd varchar(16384) = NULL,
    @debug int = 0
as
begin
   declare @cmd varchar(1000)
   declare @tabname varchar(60), @kpid_this int, @init int

   set nocount on
   select @init = 0

   if @p_cmd = '?'
   begin
      print " "
      print " Usage: sp_mda_io '<T-SQL command>' [, debug ] "
      print ""
      print " This procedure displays information about logical/physical I/Os used by currently running T-SQL statements"
      print " "
      print " Arguments:"
      print "   '<T-SQL command>' - a T-SQL command batch "
      print "   debug - when set to 1, print debugging info for this procedure"
      print ""
      print " Copyright (c) 2003-2005 Rob Verschoor/Sypron B.V."
      print " Visit www.sypron.nl/mda"
      print " "
      return 0
   end

   --
   -- Determine name for temp table.
   -- We cannot use a #temp table since this cannot be created from
   -- within exec-immediate (well, it can, but it'd  be dropped
   -- immediately again when exiting the exec-imm scope)
   --
   select @tabname = db_name(@@tempdbid) + ".guest.tab_mda_io_" +
                     convert(varchar,@@spid)

   -- We need the kpid to verify the table is this session
   select @kpid_this = kpid
   from master.dbo.sysprocesses
   where spid = @@spid

   -- debug
   if @debug != 0
   begin
      print "Tabname= %1! ; kpid= %2!", @tabname, @kpid_this
   end

   if object_id(@tabname) = NULL
   begin
      select @init = 1
      exec("select kpid = 0, dt = getdate(), " +
           "LogicalReads = 0, PhysicalReads = 0, PhysicalWrites = 0 into " +
	   @tabname
	  )
   end

   select @cmd =
   "declare @kpid_mda int declare @lio int, @pio int, @pwr int, @init int, @secs int select @init = 0" +
   "select @kpid_mda = kpid from " + @tabname + " " +
   "if @kpid_mda != " + convert(varchar,@kpid_this) + " " +
   "begin select @init = 1 print 'Initialised I/O monitoring for this session' end " +
   "update " + @tabname + " " +
   "set kpid = " + convert(varchar,@kpid_this)  + " " +
   "  , dt = getdate() " +
   "  , LogicalReads = m.LogicalReads " +
   "  , PhysicalReads = m.PhysicalReads " +
   "  , PhysicalWrites = m.PhysicalWrites " +
   "  , @secs = ceiling(datediff(ms, t.dt, getdate())/1000.0)" +
   "  , @lio = m.LogicalReads - t.LogicalReads" +
   "  , @pio = m.PhysicalReads - t.PhysicalReads " +
   "  , @pwr = m.PhysicalWrites - t.PhysicalWrites " +
   "from " + @tabname + " t, master.dbo.monProcessActivity m where SPID=@@spid " +
   "if @init = 0 begin print '' print '[spid=%1!] #secs=%2!   #Log.Reads= %3!    #Phys.Reads= %4!    #Phys.Writes= %5!', @@spid, @secs, @lio, @pio, @pwr  end"

   if @debug != 0
   begin
      print "cmd=[%1!]", @cmd
   end
   exec(@cmd)

   if @p_cmd = NULL
   begin
       return (0)
   end

   exec(@p_cmd)

   exec(@cmd)

   return (0)
end
go
grant execute on sp_mda_io to public  -- mon_role is needed anyway
go
dump tran sybsystemprocs with truncate_only
go

----------------------------------------------------------------------------

if object_id ('sp_mda_wait') != NULL
   drop procedure sp_mda_wait
go

print ""
print " Installing 'sp_mda_wait' ..."
go

create procedure sp_mda_wait
/* Copyright (c) 2005 Rob Verschoor/Sypron B.V. */
   @p1 varchar(20) = NULL,
   @interval char(8) = "00:00:10",
   @top_n int = 20,
   @debug int = 0   -- if <> 0, prints raw sampling data
as
begin
    declare @dt1 datetime, @dt2 datetime
    declare @c varchar(100), @suid int, @kpid int, @kpid2 int
	declare @v varchar(30), @groupwait int, @delta_secs int
	declare @tot_spids int, @sys_spids int, @user_spids int
	declare @spid int

	set nocount on

    select @p1 = lower(ltrim(rtrim(@p1)))

	if isnull(@p1, '?') = '?'
	   or
	   ((@p1 not in ('all', 'server')) and (@p1 not like "[0-9]%"))
	begin
	    print ""
	    print " Usage:  sp_mda_wait { 'server' | '<spid_no>' | 'all' } [, 'hh:mm:ss' [, top_N ]]"
		print " Displays wait event details over a certain interval (default = 10 seconds)."
		print " top_N applies only to the 'server' and '<spid_no>' parameters and shows only the"
		print " top N (default = 20) wait events. "
		print " "
		print " Notes:"
		print "    sp_mda_wait 'server' -  displays cumulative wait event info for the entire ASE server"
	    print ""
		print "    sp_mda_wait '<spid_no>' - displays wait event info for the specified spid"
 	    print ""
		print "    sp_mda_wait 'all' - displays wait event info for all spids, including session details"
		print "                        such as currently executing SQL"
 	    print ""
 	    print ""
        print " Copyright (c) 2005 Rob Verschoor/Sypron B.V."
        print " Visit www.sypron.nl/mda"
	    return 0
	end

    if @p1 like "[0-9]%"
	begin
	    select @spid = convert(int, @p1)

		select @suid = suid, @kpid = kpid
		from master.dbo.sysprocesses
		where spid = @spid
		if @@rowcount = 0
		begin
		   print "Spid %1! not found", @spid
		   return -1
		end
	end

    -- prepare #temp tables
	select WaitTime, Waits, WaitEventID, SPID = 0, KPID = 0
	into #t
	from master.dbo.monSysWaits
	where 1 = 0

	select WaitTime, Waits, WaitEventID, SPID = 0, KPID = 0
	into #t2
	from master.dbo.monSysWaits
	where 0 = 1

	-- take snapshot
	if @p1 = 'server'
	begin
       -- get wait cumulative event details for the entire server
	   insert #t
	   select WaitTime, Waits, WaitEventID, 0, 0
	   from master.dbo.monSysWaits
	end
	else
	begin
       -- get wait event detail per process
	   insert #t
	   select WaitTime, Waits, WaitEventID, SPID, KPID
	   from master.dbo.monProcessWaits
	end
	if @debug != 0 select * from #t

    -- wait ...
	select @dt1 = getdate()
	waitfor delay @interval
	select @dt2 = getdate()

    -- ready waiting, take snapshot again
	if @p1 = 'server'
	begin
	   insert #t2
	   select WaitTime, Waits, WaitEventID, 0, 0
	   from master.dbo.monSysWaits
	end
	else
	begin
	    if @spid > 0
		begin
			select @kpid2 = kpid
			from master.dbo.sysprocesses
			where spid = @spid
			if @kpid2 != @kpid
			begin
			   print "Spid %1! has changed during the waiting interval. Sorry...", @spid
			   return -1
			end
		end

       -- get wait event details per process
	   insert #t2
	   select WaitTime, Waits, WaitEventID, SPID, KPID
	   from master.dbo.monProcessWaits

       -- get some details about each process
	   select *
	   into #sp
	   from master..sysprocesses

	   -- get details about the SQL currently being executed
	   select * into #st from master.dbo.monProcessStatement
	   select * into #sq from master.dbo.monSysSQLText
	end
	if @debug != 0 select * from #t2

	-- Calculate the wait event time deltas
	-- Note: we're only including wait events that existed both at the start
	-- and the end of the wait interval.
	--
	select #t.SPID, #t.KPID,
		   WaitTime = #t2.WaitTime - #t.WaitTime,
	       Waits = #t2.Waits - #t.Waits,
	       WaitEventID = #t.WaitEventID,
		   sortid = identity(9)
	into #t3
	from #t, #t2
	where #t.WaitEventID = #t2.WaitEventID
	  and #t.SPID = #t2.SPID
	  and #t.KPID = #t2.KPID
    order by SPID, (#t2.WaitTime - #t.WaitTime) desc, (#t2.Waits - #t.Waits) desc

    -- if taken from monProcessWaits, convert the milliseconds to seconds
	if @p1 != 'server'
	begin
	   update #t3
	   set WaitTime = (WaitTime + 500) / 1000
	end

	if @debug != 0 select * from #t3

	-- report results
	select @delta_secs = floor((datediff(ms, @dt1, @dt2)+100)/1000.0)
	--select convert(varchar,@dt1,109) dt1, convert(varchar,@dt2,109) dt2
	print ""
	select @v = "(" + substring(substring(@@version,28,50), 1, charindex("/", substring(@@version,38,20))+9) + ")"
	select @c = "ASE server: " + @@servername + " " + @v
	print @c
	select @c = "Sampling period: " + str_replace(convert(varchar,@dt1,106),' ','-') + " " + convert(varchar,@dt1,108) + " - " + convert(varchar,@dt2,108) + " (" + convert(varchar,@delta_secs)  + " seconds)"
	print @c

	if @p1 = 'server'
	begin
	    select @c = "Wait event times for: entire ASE server"
	end
	else
	begin
	    if @p1 = 'all'
		begin
			select @c = "Wait event times for: all spids"
		end
		else
		begin
			select @c = "Wait event times for: spid " + convert(varchar, @spid) + " (" + suser_name(@suid) + ")"
		end
	end
	print @c

	if @p1 != 'server'
	begin
		print "Spid of current session: %1!", @@spid
	end
	print ""

	if @p1 != 'all'
	begin
	    -- report wait event info for a single spid or for overall ASE server
		if @spid > 0
		begin
			delete #t3
			where SPID != @spid
		end

		-- report detailed wait events
		set rowcount @top_n
		select
			WaitSecs = sw.WaitTime,
			--str((sw.WaitTime*100.0/@delta_secs),3) "  %",
			NrWaits = sw.Waits,
			WaitEvent = wei.Description
			, sw.WaitEventID
			--, wei.WaitClassID
		from #t3 sw,
			 master.dbo.monWaitEventInfo wei,
			 master.dbo.monWaitClassInfo wci
		where sw.WaitEventID = wei.WaitEventID
		and wci.WaitClassID = wei.WaitClassID
		and (sw.Waits > 0 or sw.WaitTime > 0)
		order by sw.WaitTime desc, sw.Waits desc
		set rowcount 0
	end
	else
	begin
		-- report detailed wait events for all spids
		-- set rowcount @top_n
		select
		    sortcol = convert(numeric(30), (SPID * 100000) + 10 + sw.sortid),
			SPID = -1,
			SPIDstr = space(5),
			Info = right(space(10) + convert(varchar,sw.WaitTime),10) + ' / ' + right(space(5) + convert(varchar, sw.Waits),5) + ': ' + wei.Description + ' (' + convert(varchar(3),wei.WaitEventID) + ')'
		into #t4
		from #t3 sw,
			 master.dbo.monWaitEventInfo wei,
			 master.dbo.monWaitClassInfo wci
		where sw.WaitEventID = wei.WaitEventID
		and wci.WaitClassID = wei.WaitClassID
		and (sw.Waits > 0 or sw.WaitTime > 0)

		insert #t4
		select distinct (#t3.SPID * 100000),
		    #t3.SPID,
			SPIDstr = right(space(5) + convert(varchar, #t3.SPID),5),
		    ltrim(suser_name(suid) + ' ' + cmd) + ' ' + status + ' ' + hostname + ' ' + ipaddr + ' ' + program_name
		from #t3, #sp
		where #t3.SPID = #sp.spid
		  and #t3.KPID = #sp.kpid

	if @debug != 0 select * from #t4

		insert #t4
		select distinct (SPID * 100000) + 99, -1, ' ', ' '
		from #t4
		where SPID >= 0

		insert #t4
		select (#sq.SPID * 100000) + 1, -1, ' ',
		       'Proc: ' +  db_name(DBID) + '..' + object_name(ProcedureID,DBID) + '  Line# in proc: ' + convert(varchar,#st.LineNumber)
		from #st, #sq
		where #st.SPID = #sq.SPID
		  and #st.KPID = #sq.KPID
          and #st.BatchID = #sq.BatchID
		  and object_name(ProcedureID,DBID) != NULL
        order by #sq.SPID

		insert #t4
		select (#sq.SPID * 100000) + 1, -1, ' ',
		       'Line# in batch: ' + convert(varchar,#st.LineNumber)
		from #st, #sq
		where #st.SPID = #sq.SPID
		  and #st.KPID = #sq.KPID
          and #st.BatchID = #sq.BatchID
		  and object_name(ProcedureID,DBID) = NULL
        order by #sq.SPID

		insert #t4
		select sortcol = (#sq.SPID * 100000) + 2, SPID= -1, SPIDstr = ' ',
		       sql = str_replace(,str_replace('SQL batch: ' + rtrim(#sq.SQLText) + "ZZZXXXYYY", char(10) + "ZZZXXXYYY", ' '),  "ZZZXXXYYY", ' ')
		from #st, #sq
		where #st.SPID = #sq.SPID
		  and #st.KPID = #sq.KPID
          and #st.BatchID = #sq.BatchID
        order by #sq.SPID

		print "  spid login   command    status   hostname   clientIPaddress   program_name"
		print "       procedure and/or SQL being executed"
		print "       waittime(sec)/#waits: wait event description (event ID)"

		-- return the formatted results for each process
		select SPIDstr " ", Info "  " from #t4
		order by sortcol

		-- set rowcount 0
	end

    -- disable the wait time per event class for now...
	select @groupwait = 0
    if @groupwait = 1
	begin
		-- report wait events by group
		select
			WaitSecs = sum(sw.WaitTime), NrWaits = sum(sw.Waits),
			NrWaitEventTypes = count(distinct wei.WaitEventID),
			WaitClass = wci.Description, wci.WaitClassID
		from #t3 sw,
			 master.dbo.monWaitClassInfo wci,
			 master.dbo.monWaitEventInfo wei
		where sw.WaitEventID = wei.WaitEventID
		and wci.WaitClassID = wei.WaitClassID
		and sw.Waits > 0
		group by wci.WaitClassID, wci.Description
		order by 1 desc, 2 desc
	end

	-- report #spids
	select @tot_spids = count(*) from master..sysprocesses
	select @sys_spids = count(*) from master..sysprocesses where suid = 0
	select @user_spids = @tot_spids - @sys_spids

	print " "
	print " Total #spids in ASE server: %1! (system: %2!; user: %3!)", @tot_spids, @sys_spids, @user_spids
end
go
grant execute on sp_mda_wait to public  -- mon_role is needed anyway
go
dump tran sybsystemprocs with truncate_only
go

----------------------------------------------------------------------------

if object_id('sp_mda_monOpenObjectActivity') <> NULL
    drop proc sp_mda_monOpenObjectActivity
go
print ""
print " Installing 'sp_mda_monOpenObjectActivity' ..."
go

create proc sp_mda_monOpenObjectActivity
/* Copyright (c) 2004-2010 Rob Verschoor/Sypron B.V. */
  @tab varchar(100) = '%', -- could be 255 long, but let's assume this is enough
  @db varchar(30) = '%'
as
  set nocount on
  declare @now datetime,  @now_c varchar(30)
  declare @prev datetime, @prev_c varchar(30)

  if (lower(@tab) in ('help', '?') )
  begin
     print "Usage: "
     print "  exec sp_mda_monOpenObjectActivity   "
	  print "     ==> calculates delta for monOpenObjectActivity since "
	  print "         previous call in this session"
	  print ""
     print "  exec sp_mda_monOpenObjectActivity 'init'  "
	  print "     ==> clears last sample "
	  print ""
     print "  exec sp_mda_monOpenObjectActivity  'tabfilter', 'dbfilter' "
	  print "     ==> specify filter for table name (first arg) and/or "
	  print "         DB name (second arg); wildcards allowed."
	  print "         Default = %% = include all (for both args)"
	  print ""
     print "  exec sp_mda_monOpenObjectActivity '?'  "
	  print "     ==> display this usage information "
	  print ""

	  print "NB: to include data on system tables, enable traceflag 3650"
	  print "NB: in case of very low I/O activity e.g. < 5 LIOs during a"
	  print "    sampling period, no results may be reported"
     return
     -- NB: outstanding ASE bug: cached plans (proc cache or stmt cache)
     --     do not increment the Operations column, uncached plans do.
  end


  declare @temptab varchar(100), @temptab_root varchar(100)
  declare @temptab_sub varchar(100), @temptab_old varchar(100), @kpid int
  declare @temptab_sub_exists varchar(10), @temptab_exists varchar(10)
  declare @tempdbname varchar(30)


  set @tempdbname = 'tempdb'

  select @kpid = kpid from master..sysprocesses where spid = @@spid
  set @temptab_root = 'd_monOOA_sp_'
  set @temptab_sub = @temptab_root + convert(varchar, @@spid) + '_kp'
  set @temptab = @temptab_sub + '_' + convert(varchar, @kpid)

  set @temptab_sub_exists = "no"
  set @temptab_exists = "no"
  set @temptab_old = NULL

  select @temptab_sub_exists = "yes", @temptab_old = name
  from tempdb..sysobjects
  where name like @temptab_sub + "%"

  select @temptab_exists = "yes"
  from tempdb..sysobjects
  where name = @temptab

  --select "full" = @temptab
  --select "sub" =  @temptab_sub
  --select "old" =  @temptab_old
  --select @temptab_sub_exists,  @temptab_exists

  set @temptab_old = @tempdbname + '..' + @temptab_old
  set @temptab = @tempdbname + '..' + @temptab

  -----------------------

  if (@temptab_sub_exists = "yes") and (@temptab_exists = "no")
  begin
	  -- the temp table exists, but was for a previous incarnation of this SPID. So drop it
	  print "Removing delta table from previous session with spid= %1! [%2!]",  @@spid, @temptab_old
	  exec('drop table ' + @temptab_old)

	  if object_id(@temptab_old) is not NULL
	  begin
		  print "Error removing delta table from previous session with spid= %1! [%2!]",  @@spid, @temptab_old
		  print "Exiting..."
		  return
	  end

	  set @temptab_sub_exists = "no"
	  set @temptab_exists = "no"
  end

  -----------------------

  if (lower(@tab) = 'init') or (@temptab_exists = "no")
  begin
	 if (@temptab_exists = "no")
	 begin
	    exec(' select dt=getdate(), *
		        into ' + @temptab + '
				  from master..monOpenObjectActivity
				')
	 end

	 if object_id(@temptab) is NULL
	 begin
		 print "Error creating delta table from current session - spid= %1! [%2!]",  @@spid, @temptab
		 print "Exiting..."
		 return
	 end

	 exec('truncate table ' + @temptab)

	 print "Delta table initialised. Subsequent calls in this session"
	 print "will report delta values since the previous call."
  end

  -----------------------

	-- take a snapshot
	select dt=getdate(), *
	into #monOOA_new
	from  master..monOpenObjectActivity
	where object_name (ObjectID, DBID) not like '#monOOA%'
	  and object_name (ObjectID, DBID) not like @temptab_root + '%'

	if (lower(@tab) = 'init') or (@temptab_exists = "no")
	begin
		exec('insert ' + @temptab + ' select * from #monOOA_new')
		return
	end

	select @now = getdate()
	select @now_c = convert(varchar(11), @now, 106) + " " +
			convert(varchar(11), @now, 108)

	-- retrieve the previous snapshot
	select *
	into #monOOA
	from #monOOA_new
	where 0 = 1

	exec('insert #monOOA select * from ' + @temptab)

	-- calc the new delta
	select secs = datediff(ms, t.dt, n.dt),
			 n.ObjectID, n.DBID, n.IndexID,
			 UsedCount = n.UsedCount - t.UsedCount,
			 LogicalReads = n.LogicalReads - t.LogicalReads,
			 PhysicalReads = n.PhysicalReads - t.PhysicalReads,
			 Operations = n.Operations - t.Operations,
			 LockWaits = isnull(n.LockWaits - t.LockWaits, 0),
			 RowsInserted = n.RowsInserted - t.RowsInserted,
			 RowsUpdated = n.RowsUpdated - t.RowsUpdated,
			 RowsDeleted = n.RowsDeleted - t.RowsDeleted,
			 LockRequests = n.LockRequests - t.LockRequests
	into #monOOA_d
	from #monOOA t, #monOOA_new n
	where t.ObjectID =* n.ObjectID
	and t.DBID =* n.DBID
	and t.IndexID =* n.IndexID


	-- subtract 2 LIO + 2 PIO for every table (IndexID=0) since the
	-- row_count() and reserved_page() built-ins cause some LIO/PIO themselves,
	-- which can mess up the deltas.
	-- This correction really only matters when there is very little or no activity in the server,
	-- and this way we try to avoid unexplained activity in such a case. Therefore, it also
	-- doesn't really matter that this correction is done right here instead of after the calls
	-- to row_count() etc.
	update #monOOA_d
	set LogicalReads  = case when LogicalReads > 2  then LogicalReads - 2  else 0 end,
	    PhysicalReads = case when PhysicalReads > 2 then PhysicalReads - 2 else 0 end
	where IndexID in (0,1)

	-- Also note that column Operations is also increased by these built-ins,
	-- with 1 unit for row_count() and 1 unit for every row in sysindexes for reserved_pages().
	-- For partitioned tables, the count might need to be multiplied by the #partitions (not tested)
	select ObjectID, DBID, OpsCorrection=count(*)+1
	into #monOOA_d_ix
	from #monOOA_d
	group by ObjectID, DBID

	update #monOOA_d
	set Operations = case when d.Operations > x.OpsCorrection then d.Operations - x.OpsCorrection else 0 end
	from #monOOA_d d, #monOOA_d_ix x
	where d.ObjectID = x.ObjectID
	and   d.DBID = x.DBID
	and   d.IndexID in (0,1)

	-- some time formatting
	select top 1 @prev = dt from #monOOA
	select @prev_c = convert(varchar(11), @prev, 106) + " " +
			 convert(varchar(11), @prev, 108)

	declare @ms int
	select top 1 @ms = secs from #monOOA_d
	select @ms = @ms / 1000
	if @ms < 1 set @ms = 1

	-- calc total LIO in this delta
	declare @sum_lio int,  @sum_lio_filter int
	select @sum_lio = sum(LogicalReads)
	from #monOOA_d

        print " "
        print " sp_mda_monOpenObjectActivity - report"
        print " ====================================="
	print " Interval for this sample   : %1! seconds (%2! - %3!)", @ms, @prev_c, @now_c
        print " Total LIO in sample period : %1!", @sum_lio

	-- apply filters, if specified
	set @tab = str_replace(str_replace('%' + @tab + '%', '%%', '%'), '%%', '%')
	set @db  = str_replace(str_replace('%' + @db + '%', '%%', '%'), '%%', '%')

	if (@tab != '%') or (@db != '%')
	begin
	   print " Applying filter for tables   : %1!", @tab
	   print " Applying filter for databases: %1!", @db

		delete #monOOA_d
		where object_name(ObjectID, DBID) not like @tab
			or db_name(DBID) not like @db

		select @sum_lio_filter = sum(LogicalReads)
		from #monOOA_d

		print ""
		print " Total LIO after filtering : %1!", @sum_lio_filter

		set @sum_lio = @sum_lio_filter
	end
	else
	begin
	   print " No filters specified."
	end

	--print "sum_lio = %1!", @sum_lio
	if @sum_lio in (0, NULL) select @sum_lio = 1

	-- calculate totals per table and add these to the delta (to allow some sorting per table, currently not really used)
	select ObjectID, DBID,
			 LogicalReads = sum(LogicalReads),
			 PhysicalReads = sum(PhysicalReads),
			 Operations=sum(Operations),
			 LockWaits=sum(LockWaits)
	into #monOOA_sort
	from #monOOA_d
	group by ObjectID, DBID

        select ObjectID, DBID,
		NrRows=row_count(DBID,ObjectID),     -- this call causes some LIO/PIO, and 1 operation
		TabSizeKB=reserved_pages(DBID,ObjectID)*(@@maxpagesize/1024)  -- this call causes some LIO/PIO and 1 operation per index
	into #monOOA_size
	from #monOOA_sort


	select t.*, sum_LogicalReads = s.LogicalReads,
			sum_PhysicalReads = s.PhysicalReads,
			sum_Operations = s.Operations,
			sum_LockWaits = s.LockWaits,
			NrRows = z.NrRows,
			TabSize=case when z.TabSizeKB < 1024 then convert(varchar,z.TabSizeKB) + ' KB'
			             when z.TabSizeKB/1024 < 1024 then convert(varchar,z.TabSizeKB/1024) + ' MB'
			             when z.TabSizeKB/(1024*1024) < 1024 then convert(varchar,z.TabSizeKB/(1024*1024)) + ' GB'
			             else convert(varchar,z.TabSizeKB/(1024*1024*1024)) + ' TB'
				end
	into #monOOA_d_sort
	from #monOOA_d t, #monOOA_sort s, #monOOA_size z
	where t.ObjectID = s.ObjectID
	and t.DBID = s.DBID
	and t.ObjectID = z.ObjectID
	and t.DBID = z.DBID

   -----------------------
	-- add a row with grand total LIO per table

	select *
	into #monOOA_tabtotal
	from #monOOA_d_sort
	where IndexID = 0

	update #monOOA_tabtotal
	set IndexID = -1,
	    LogicalReads = sum_LogicalReads

	insert #monOOA_d_sort
	select * from  #monOOA_tabtotal


   -----------------------
	-- print results
	-- other interesting sort orders could be used such as: most LockWaits; most times accessed (Operations); order by OptSelectCount/UsedCount etc.
	-- user should feel free to change/add these as they need them.

	select
	      TableName = case when IndexID = -1 then db_name(DBID) + '..' + object_name(ObjectID, DBID) else '' end,
			IndexName = case when IndexID = -1 then '(' + convert(varchar,NrRows) + ' rows, ' + convert(varchar,TabSize) + ')' when IndexID = 0 then 'TableScan' else index_name(DBID, ObjectID, IndexID) + '(' + convert(varchar,IndexID) + ')' end,
			LIOReads=LogicalReads,
			--UsedCount,
			LIOPercent= case when IndexID = -1 then str(100.0*LogicalReads/@sum_lio,5,1) + '%     ' else  '     ' + str(100.0*LogicalReads/sum_LogicalReads,5,1) + '%' end ,
			Ops= case when IndexID = -1 then Operations else 0 end,
			AvgLIOperOp= case when IndexID = -1 then
			convert(int,ceiling(case Operations when 0 then 0
					  else sum_LogicalReads/(1.0*Operations) end)) else 0 end,
			PIOReads=PhysicalReads,
			LockWaits,
			RowsIns=RowsInserted,
			RowsUpd=RowsUpdated,
			RowsDel=RowsDeleted
	into #monOOA_result
	from #monOOA_d_sort
	where (100.0*sum_LogicalReads/@sum_lio) >= 0.1  -- exclude the really small percentages
	order by 1.0*sum_LogicalReads/@sum_lio desc, db_name(DBID) + '..' + object_name(ObjectID, DBID), IndexID

	print ""
	print " Tables consuming most Logical I/O"
	print " ================================="
	print ""

	exec sp_autoformat #monOOA_result


   -----------------------

	-- store the snapshot for doing a delta the next time we're called

	exec('truncate table ' + @temptab)
	exec('insert ' + @temptab + ' select * from #monOOA_new')
go

grant execute on sp_mda_monOpenObjectActivity to public  -- mon_role is needed anyway
go
dump tran sybsystemprocs with truncate_only
go

----------------------------------------------------------------------------

if object_id('sp_mda_diskIO') <> NULL
    drop proc sp_mda_diskIO
go
print ""
print " Installing 'sp_mda_diskIO' ..."
go

create proc sp_mda_diskIO
/* Copyright (c) 2004-2010 Rob Verschoor/Sypron B.V. */
  @devicename varchar(30) = '%',
  @show_idle_devices int = 1,
  @debug int = 0
as
  set nocount on

  if object_id('master.dbo.sysinstances') is not NULL
  begin
     print ""
     print "This stored procedure is currently not supported with ASE Cluster Edition."
     print "Please let the author know if you should need this, and he'll consider fixing it..."
     print ""
     return
  end

  if (lower(@devicename) in ('help', '?') )
  begin
     print "Usage: "
     print "  exec sp_mda_diskIO   "
	  print "     ==> calculates delta values for monDeviceIO and monIOQueue since "
	  print "         previous call in this session"
	  print ""
     print "  exec sp_mda_diskIO 'init'  "
	  print "     ==> clears last sample "
	  print ""
     print "  exec sp_mda_diskIO 'devicefilter' "
	  print "     ==> specify filter for device names (first arg) to"
	  print "         be reported; wildcards allowed."
	  print "         Default = %% = report all."
	  print ""
     print "  exec sp_mda_diskIO @show_idle_devices = 0 "
     print "  exec sp_mda_diskIO '%%', 0 "
	  print "     ==> Do not report devices without any I/Os."
	  print "         Default = 1 = report everything."
	  print ""
     print "  exec sp_mda_diskIO '?'  "
	  print "     ==> display this usage information "
	  print ""
     return
  end


  declare @temptab varchar(100), @temptab_root varchar(100)
  declare @temptab_sub varchar(100), @temptab_old varchar(100), @kpid int
  declare @temptab_sub_exists varchar(10), @temptab_exists varchar(10)
  declare @tempdbname varchar(30)

  set @tempdbname = 'tempdb'

  select @kpid = kpid from master..sysprocesses where spid = @@spid
  set @temptab_root = 'd_mondiskio_sp'
  set @temptab_sub = @temptab_root + convert(varchar, @@spid) + '_kp'
  set @temptab = @temptab_sub + '_' + convert(varchar, @kpid)

  set @temptab_sub_exists = "no"
  set @temptab_exists = "no"
  set @temptab_old = NULL

  select @temptab_sub_exists = "yes", @temptab_old = name
  from tempdb..sysobjects
  where name like @temptab_sub + "%"

  select @temptab_exists = "yes"
  from tempdb..sysobjects
  where name = @temptab

  --select "full" = @temptab
  --select "sub" =  @temptab_sub
  --select "old" =  @temptab_old
  --select @temptab_sub_exists,  @temptab_exists

  set @temptab_old = @tempdbname + '..' + @temptab_old
  set @temptab = @tempdbname + '..' + @temptab

  -----------------------

  if (@temptab_sub_exists = "yes") and (@temptab_exists = "no")
  begin
	  -- the temp table exists, but was for a previous incarnation of this SPID. So drop it
	  print "Removing delta table from previous session with spid= %1! [%2!]",  @@spid, @temptab_old
	  exec('drop table ' + @temptab_old)

	  if object_id(@temptab_old) is not NULL
	  begin
		  print "Error removing delta table from previous session with spid= %1! [%2!]",  @@spid, @temptab_old
		  print "Exiting..."
		  return
	  end

	  set @temptab_sub_exists = "no"
	  set @temptab_exists = "no"
  end

  -----------------------

  if (lower(@devicename) = 'init') or (@temptab_exists = "no")
  begin
	 if (@temptab_exists = "no")
	 begin
	    exec(' select dt=getdate(),
	                  d.LogicalName, /*d.InstanceID,*/ Reads, APFReads, Writes, dIOTime = d.IOTime, DevSemaphoreRequests, DevSemaphoreWaits, PhysicalName, IOs,  qIOTime = q.IOTime, IOType
		   into ' + @temptab + '
		   from master.dbo.monDeviceIO d, master.dbo.monIOQueue q where d.LogicalName = q.LogicalName
				')
	 end


	 if object_id(@temptab) is NULL
	 begin
		 print "Error creating delta table from current session - spid= %1! [%2!]",  @@spid, @temptab
		 print "Exiting..."
		 return
	 end

	 exec('truncate table ' + @temptab)

	 print "Delta table initialised. Subsequent calls in this session"
	 print "will report delta values since the previous call."
  end

  -----------------------

  -- take a snapshot

	select dt=getdate(),
	       d.LogicalName, /*d.InstanceID,*/ Reads, APFReads, Writes, dIOTime = d.IOTime, DevSemaphoreRequests, DevSemaphoreWaits, PhysicalName, IOs,  qIOTime = q.IOTime, IOType
	into #mondio_new
	from master.dbo.monDeviceIO d, master.dbo.monIOQueue q
	where d.LogicalName = q.LogicalName

	if (lower(@devicename) = 'init') or (@temptab_exists = "no")
	begin
		exec('insert ' + @temptab + ' select * from #mondio_new')
		return
	end

	if @debug > 0
	begin
	   print ""
	   print "Previous shapshot in delta table:"
	   exec sp_autoformat @temptab

	   print ""
	   print ""
	   print "Current shapshot:"
	   exec sp_autoformat #mondio_new
	   print ""
	end

	-- retrieve the previous snapshot
	select *
	into #mondio
	from #mondio_new
	where 0 = 1

	exec('insert #mondio select * from ' + @temptab)


   -- calc the new delta

	      -- d.LogicalName, /*d.InstanceID,*/ Reads, APFReads, Writes, TotalIOs = Reads + Writes, ReadPct = 0, WritePct = 0, dIOTime = d.IOTime, DevSemaphoreRequests, DevSemaphoreWaits, PhysicalName, IOs,  qIOTime = -- q.IOTime, IOType, qAvgIOMilliSec = 0


	select secs = datediff(ms, t.dt, n.dt),
			 n.LogicalName,
			 --n.PhysicalName,
			 n.IOType,
			 Reads = convert(bigint,n.Reads)- t.Reads,
			 Writes = convert(bigint,n.Writes) - t.Writes,
			 TotalIOs = (convert(bigint,n.Reads) - t.Reads + n.Writes - t.Writes),
			 ReadPct = 0,
			 WritePct = 0,
			 dIOTime = n.dIOTime - t.dIOTime,
			 --DevSemaphoreRequests = n.DevSemaphoreRequests - t.DevSemaphoreRequests,
			 --DevSemaphoreWaits = n.DevSemaphoreWaits - t.DevSemaphoreWaits,
			 IOs = convert(bigint,n.IOs) - t.IOs,
			 qIOTime = n.qIOTime - t.qIOTime
	into #mondio_delta
	from #mondio t, #mondio_new n
	where t.LogicalName = n.LogicalName
	  and t.IOType = n.IOType

	if @debug > 0
	begin
	   print ""
	   print "Delta:"
	   exec sp_autoformat #mondio_delta
	   print ""
	end

	if (select count(*) from #mondio_delta
	   where Reads < 0 or Writes < 0 or IOs < 0)  > 0
	begin
	   print ""
	   print " It seems sp_sysmon has been run and cleared the counters? "
	   print " Please try again without running sp_sysmon in between..."
	   print ""

	   -- store the current snapshot
	   exec('truncate table ' + @temptab)
	   exec('insert ' + @temptab + ' select * from #mondio_new')
	   return
	end

	declare @ms int
	select top 1 @ms = secs from #mondio_delta
	select @ms = @ms / 1000
	if @ms < 1 set @ms = 1
	if @ms is NULL set @ms = 1

-----------------------

	print ""
	print " Disk I/O activity per database device"
	print " ====================================="
   	print " Interval duration for this sample: %1! seconds", @ms
	print ""

-----------------------

   -- apply filters, if specified

	set @devicename = str_replace(str_replace('%' + @devicename + '%', '%%', '%'), '%%', '%')

	if (@devicename != '%')
	begin
		print "Applying filter for devices : %1!", @devicename

		delete #mondio_delta
		where LogicalName not like @devicename
	end

-----------------------
	-- print results, part 1: monIOQueue

	select
		LogicalName,
		TotalIOs,
		IOs,
		IOType,
		qIOTime,
		qAvgIOMilliSec = 0
	into #q
	from #mondio_delta

	update #q
	set qAvgIOMilliSec= floor(((qIOTime*1.0)/IOs) + 0.5)
	where IOs > 0

	if (@show_idle_devices = 0)
	begin
		delete #q
		where IOs = 0
	end

	select
		DBDevice=LogicalName,
		TotalIOs,
		Nr_IOs = IOs,
		IOType,
		AvgIOTime = case when qAvgIOMilliSec = 0 and IOs > 0 then 1 else qAvgIOMilliSec end,
		Qual = case when IOs = 0 then ''  when IOs < 1000 then '??'  when IOs < 20000 then '?' when IOs < 50000 then '+'  when IOs >= 50000 then '++'  else '' end
	into #q2
	from #q

	exec sp_autoformat #q2, @selectlist = 'DBDevice, Nr_IOs, IOType, AvgIOTime, Qual ',
	                        @orderby = ' order by TotalIOs desc, Nr_IOs desc, IOType'


	print " "

	-- print results, part 2: monDeviceIO

	select distinct
		LogicalName,
		TotalIOs,
		Reads,
		ReadPct = 0,
		dIOTime,
		dAvgIOMilliSec = 0
	into #d
	from #mondio_delta

	update #d
	set dAvgIOMilliSec = floor(((dIOTime*1.0)/TotalIOs) + 0.5),
	    ReadPct = Reads*100 / TotalIOs
	--    WritePct = 100 - (Reads*100 / TotalIOs)
	where TotalIOs > 0

	if (@show_idle_devices = 0)
	begin
		delete #d
		where TotalIOs = 0
	end

	select
		DBDevice=LogicalName,
		Nr_IOs = TotalIOs,
		Reads_vs_Writes = case when TotalIOs > 0
			     then 'R:' + right('   '+convert(varchar,ReadPct),3) +
				'%   W:' + right('   '+convert(varchar,100-ReadPct),3) + '%' else '' end,
		AvgIOTime =  case when dAvgIOMilliSec = 0 and TotalIOs > 0 then 1 else dAvgIOMilliSec end,
		Qual = case when TotalIOs = 0 then ''  when TotalIOs < 1000 then '??'  when TotalIOs < 20000 then '?' when TotalIOs < 50000 then '+'  when TotalIOs >= 50000 then '++'  else '' end
	into #d2
	from #d

	exec sp_autoformat #d2, @orderby = ' order by Nr_IOs desc'


print " "
print " Please note:"
print " - Estimated Average I/O times are in milliseconds"
print " - 'Qual' column estimates the quality of the Average I/O times reported:"
print "        ++ : Avg I/O time very likely to be accurate"
print "        +  : Avg I/O time likely to be accurate"
print "        ?  : Avg I/O time less likely to be accurate"
print "        ?? : Avg I/O time unlikely to be accurate"
print "   In general, I/O times are more likely to be accurate when "
print "   based on a larger number of I/Os. "
print " - Measurements are based on monIOQueue and monDeviceIO"
print " "


   -----------------------

	-- store the snapshot for doing a delta the next time we're called

	exec('truncate table ' + @temptab)
	exec('insert ' + @temptab + ' select * from #mondio_new')
go

grant execute on sp_mda_diskIO to public  -- mon_role is needed anyway
go
dump tran sybsystemprocs with truncate_only
go



----------------------------------------------------------------------------


print ""
print " For on-line help information, run these procedures with '?' as "
print " the first parameter."
print " Ready."
print ""
print " Copyright (c) 2003-2013 Rob Verschoor/Sypron B.V."
go

--
-- end
--