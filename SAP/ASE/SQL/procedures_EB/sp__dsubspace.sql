/************************************************************************************************************************************************
 *  This process will use a persistant table called sysdbspaceinfo.  It is not a previously defined sybase system table, but  
 *  is used by the sp__dbsubspace procedure.  The database that this table resides in is defined by the "sybsystemdb" 
 *  marker.  Please replace the "sybsystemdb" marker with an actual database prior to installing this procedure.  In some    
 *  cases you may want to use something like sybsystemprocs or sybsystemdb.  You may also use tempdb, but if you do
 *  you may want to define the table in the model database as well, so it will exist when the server is restarted.  Good luck
 *  and enjoy.                                                                        Drew Montgomery
 ************************************************************************************************************************************************/

use master
go

/*  This is to set the Truncate Log on Checkpoint option for the database with the space check table on, so it doesn't fill up.
 *     This was done in case the database being used for this doesn't have its logs regularly cleaned (some sybase system
 *     databases are like that).  If the database you are going to use has a regular log cleanup procedure, you may comment 
 *     out this section.                         DM                                                                                                                       */
sp_dboption sybsystemdb, "trunc. log", true
go

use sybsystemdb
go

checkpoint
go

/* Drops the table if it already exists, as a precaution for the create */
if object_id('sysdbspaceinfo') is not null  
 drop table sysdbspaceinfo
go

create table sysdbspaceinfo 
   (dbid int, 
    DataPages numeric(19,5), 
    DataPagesUsed numeric(19,5), 
    LogPages numeric(19,5),
    LogPagesUsed numeric(19,5), 
    LogFirstPage int,
    NumberOfObjects int    )
go

/* Unique index is required for the isolation level, and makes the access faster! */
create unique index UCsysdbspaceinfo on sysdbspaceinfo(dbid)
go

/* Go to the sybsystemprocs to install the procedure */
use sybsystemprocs
go

/* Drop it first, as a precaution */
if object_id("sp__dbsubspace") is not null
  drop procedure sp__dbsubspace
go

create procedure sp__dbsubspace 
          @dont_format char(1) = NULL,          /* Flag for indicating the need to have more or less formatted information */
          @LogThreshold float = 0.01,              /* Change threshold for the amount of log "movement" before a recalculation of the data space is performed.
                                                                   The default value of 0.01 represents a 1.0% change in the amont of log space or the first page pointer of the log.
                                                                   Please note: it is theoretically possible that the log pointer could move just less than this amount and have 
                                                                   an amount of log space used that is just less than this amount, therefore it is POSSIBLE that change could be 
                                                                   two times this amount before a recalculation of the data space is performend.  Possible but not very likely.        */
           @Force varchar(10) = NULL
                                                                    
as
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 *  This procedure conceived and written by Drew Montgomery - please forward any and all substantial updates to 
 *        drew_montgomery@ameritech.net (so I can make this procedure better).  Thank you.                               
 * ------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

set nocount on
set lock nowait
set transaction isolation level 0

/* Declaration Section */
declare     @MixedFlag char,                                 /* Flag to signify if log and data are on the same device */
                @DataPages numeric(19,5),                  /* Number of data pages defined from sysusages */
                @LogPages numeric(19,5),                    /* Number of log pages defined from sysusages */
                @TotalPages numeric(19,5),                    /* Number of pages defined from sysusages */
                @DataPagesUsed numeric(19,5),           /* Number of data pages currently in use (reserved) */
                @LogPagesUsed numeric(19,5),             /* Number of log pages currently in use */
                @LogFirstPage bigint,                                /* First defined page of the transaction log */
                @NumberOfObjects int,                       /* for determining if a table has been dropped or added */
                @OldDataPages numeric(19,5),              /* Previous number of data pages defined from sysusages */
                @OldLogPages numeric(19,5),                /* Previous number of log pages defined from sysusages */
                @OldLogPagesUsed numeric(19,5),        /* Previous number of data pages being used */
                @OldDataPagesUsed numeric(19,5),       /* Previous number of log pages being used */
                @OldLogFirstPage int,                            /* Previous transaction log first page pointer */
                @OldNumberOfObjects int,                  /* Previous number of user tables in this database */
--                @LogDelta numeric(19,5),                       /* Change in the number of log pages being used */
--                @LFPDelta int,                                       /* Change in the location of the first log page */
                @scale numeric(19,5),                            /*  Multiplier used for displaying amount of space from number of pages -
                                                                                 this value is derived from the @@maxpagesize */
                @ReSize char,                                       /* Flag indicating if we need to recalculate the amount of data space being used */
                @pct_used numeric(10,2),                       /* Calculated percentage of data space used */
                @log_pct_used numeric(10,2)                  /* Calculated percentage of log space used */

set @ReSize = 'F'            /* Predefined as "No, thanks, we don't need to get a new reading of the data space being used -
                                          the old value will do just fine.   */

/* Determine the current data and log space allocated to this dabase as defined from sysusages */
select @DataPages = sum(case when segmap=4 then 0 else convert(numeric(19,5), size) end),
          @LogPages = sum(case when segmap & 4=4 then convert(numeric(19,5), size) else 0 end),
          @TotalPages = sum(convert(numeric(19,5), size))
  from master..sysusages where dbid = db_id()

/* If there are no log pages (or the value is null), then the system is defined as having Mixed data and log space -
 *   which also means that the number of potential log pages is the same as the number of data pages.              */
if isnull(@LogPages,0) = 0
begin
  set @MixedFlag = 'M'  -- Mode is Mixed
  set @LogPages=@DataPages
end
else if exists (select 1 from master..sysusages where dbid = db_id() and segmap &5 =5)
  set @MixedFlag = "C"  -- Stands for Confused
else
  set @MixedFlag = 'P'  -- Indicates Pristine

/* We are getting the number of pages being used by the syslogs table (table id = 8).
 * The first select line is "Prior to system 15 version", the second is the "System 15 or above" version-
 *   Please set the appropriate comment as to which kind of system is being used */
/*  select @LogPagesUsed = reserved_pgs(id, doampg), */
select @LogPagesUsed = reserved_pages(db_id(), id), 
          @LogFirstPage = first
  from sysindexes
 where id = 8

/* Extract the information from previous executions of sp__dbsubspace */
select @OldDataPages = DataPages, 
          @OldDataPagesUsed = DataPagesUsed,
          @OldLogPages = LogPages,
          @OldLogPagesUsed = LogPagesUsed,
          @OldLogFirstPage = LogFirstPage,
          @OldNumberOfObjects = NumberOfObjects
  from sybsystemdb..sysdbspaceinfo
where dbid = db_id()

/* Get an object count of the USER TABLES */
select @NumberOfObjects = count(*) from sysobjects where type = 'U'

/* If there are no records retrieved (first run) we need to Recalculate the size */
if @@rowcount = 0
begin
  set @ReSize = 'T'
end
else        
  if @OldDataPages != @DataPages           /* If the number of data pages changed from sysusages - Recalculate size */
  begin
    set @ReSize = 'T'
  end
  else
    if @OldLogPages != @LogPages            /* If the nubmer of log pages changed from sysusages - Recalculate size */
    begin
      set @ReSize = 'T'
    end
    else
    begin                                                   /* if the number of log pages used is greather than a percentage of the total number of log pages available - Recalc Size */
      if (@LogPagesUsed - @OldLogPagesUsed) > @LogThreshold * @LogPages
        set @ReSize = 'T'
      else
        begin                                               /* if the log's first page moved more than the threshold of the number of log pages available - Recalc Size */
        if (abs(@LogFirstPage - @OldLogFirstPage)) > @LogThreshold * @LogPages
          set @ReSize = 'T'
        else
          begin
            if (@OldNumberOfObjects != @NumberOfObjects)
              set @ReSize = 'T'
          end
        end
    end

if @Force is not null  -- This is a force option to make it update the value
  set @ReSize = 'T'

if @ReSize = 'T'                                        /* We are recalculating size, and getting back the new value of the Data Pages Used */
  exec sp__dbsubspace;2 @DataPages, @DataPagesUsed out, @LogPages, @LogPagesUsed, @LogFirstPage, @NumberOfObjects
else
begin                                                       /* or if we don't need to do that, we just use the previous value of the Data Pages Used */
  set @DataPagesUsed = @OldDataPagesUsed
end

/* Calculated scale from the maximum page size (size of the data pages, usually 2k, 4k, 8k, or 16k) */
set @scale = @@maxpagesize / 1024

/* "Borrowed" this calculation from sp__dbspace of the percentages used*/
if @MixedFlag = 'M' 
begin  /* Please note, if the mode is mixed, we will apparently have no Log Percentage Used as it is part of the data space */
  set @pct_used = convert(numeric(10,2), ((@DataPagesUsed + @LogPagesUsed) * 100) / @DataPages)
  set @log_pct_used = convert(numeric(10,2), 0)
end
else
begin
  set @pct_used = convert(numeric(10,2), (@DataPagesUsed * 100) / @DataPages) 
  set @log_pct_used = convert(numeric(10,2), (@LogPagesUsed * 100 )/(@LogPages) ) 
end

/* The @dont_format is from the sp__dbspace command - and provides the option for an abbreviated display of information */
if @dont_format is not null
begin            /* Provide the results based on the local variables - formatted first */
select  Name             = db_name(),
        "Data MB"  = str((@DataPages*@scale)/1024, 16, 0),
        "Used MB"  = str(((@DataPagesUsed + case @MixedFlag when 'M' then @LogPagesUsed else 0 end)*@scale)/1024, 16, 1),
        Percent    = str(@pct_used, 7, 2),
        "Log MB" = str((@LogPages*@scale)/1024, 12, 0),
        "Log Used"   = str(((case @MixedFlag when 'M' then 0 else @LogPagesUsed end)*@scale)/1024, 12, 2),
        "Log Pct"  = str(@log_pct_used, 7, 2),
        "Total MB" = str((@TotalPages*@scale)/1024, 18, 0)
end
else
begin          /* And unformatted */
select  Name             = convert(char(12),db_name()),
        "Data MB"  = str((@DataPages*@scale)/1024, 13, 0),
        "Used MB"  = str(((@DataPagesUsed + case when @MixedFlag = 'M' then @LogPagesUsed else 0 end)*@scale)/1024, 14, 1),
        Percent    = str(@pct_used, 7, 2),
        "Log MB"   = str((@LogPages*@scale)/1024, 9, 0),
       "Log Used" = str(((case when @MixedFlag='M' then 0 else @LogPagesUsed end)*@scale)/1024, 9, 2),
        "Log Pct"  = str(@log_pct_used, 7, 2),
        "Total MB" = str((@TotalPages*@scale)/1024, 15, 0)
end

/*  And Vola' we are done!  */
go

/* This is a subordinate procedure that gets the information from the sysindexes (or sysobjects for system 15+) and stores the information into the sysdbspaceinfo table */
create procedure sp__dbsubspace;2
  @DataPages numeric(19,5),                           /* See comments above about variables */
  @DataPagesUsed numeric(19,5) output,         /* NOTE: this value is returned to the calling procedure */
  @LogPages numeric(19,5),
  @LogPagesUsed numeric(19,5),
  @LogFirstPage bigint,
  @NumberOfObjects int

with recompile
as

  /* Prior to system 15 version */
  /* select @DataPagesUsed = sum(reserved_pgs(id, doampg) + reserved_pgs(id, ioampg))
     from sysindexes
    where id != 8
  */
/* System 15 and above version */    
   select @DataPagesUsed = sum(convert(numeric(19,5), reserved_pages(db_id(), id)))
     from sysobjects
    where id != 8
    
    
 /* Update the information in the table */
      update sybsystemdb..sysdbspaceinfo 
           set  DataPages = @DataPages,
                 DataPagesUsed = @DataPagesUsed,
                 LogPages = @LogPages,
                 LogPagesUsed = @LogPagesUsed,
                 LogFirstPage = @LogFirstPage,
                 NumberOfObjects = @NumberOfObjects
         where dbid = db_id()                 

/* if the update is not for any rows, then add a row */
        if @@rowcount = 0
          insert into sybsystemdb..sysdbspaceinfo values (db_id(), @DataPages, @DataPagesUsed, @LogPages, @LogPagesUsed, @LogFirstPage, @NumberOfObjects)
          
return  /* and we are done with this one */
go

/* You may want to grant some permissions (execute, perhaps) if the users are not sa's */