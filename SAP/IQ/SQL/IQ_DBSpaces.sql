begin
declare @db_file        long varchar;
declare @iq_file        long varchar;
declare @msg_file       long varchar;
declare @temp_file      long varchar;
declare @block_size     unsigned int;
declare @chunk_size     unsigned int;
declare @reserve_size   rowid;
declare @user_dbspace   long varchar;
declare @user_dbfile_name long varchar;
declare @user_file_name long varchar;
declare @counter        int;

declare local temporary table #statement(
        seq             int             not null default autoincrement,
        statement_txt   long varchar    null);

declare end_of_cursor exception for SQLSTATE '02000';

declare user_dbspaces cursor for
        select  dbspace_name
                from sysdbspace
                where   store_type      = 2
                and     dbspace_name    not in ('IQ_SYSTEM_MAIN', 'IQ_SYSTEM_TEMP', 'IQ_SYSTEM_MSG');

declare user_dbfiles cursor for
        select  f.dbfile_name,
                f.file_name
                from    sysdbfile f,
                        sysdbspace d
                where   d.store_type    = 2
                and     d.dbspace_name  = @user_dbspace
                and     d.dbspace_id    = f.dbspace_id
                order   by dbfile_id;

select  file_name into @db_file
        from    sysdbfile
        where   dbspace_id      = 0;

select  file_name into @iq_file
        from    sysdbfile
        where   dbfile_name     = 'IQ_SYSTEM_MAIN';

select  file_name into @msg_file
        from    sysdbfile
        where   dbfile_name     = 'IQ_SYSTEM_MSG';

select  file_name into @temp_file
        from    sysdbfile
        where   dbfile_name     = 'IQ_SYSTEM_TEMP';

select  block_size, chunk_size into @block_size, @chunk_size
        from    sysiqinfo;

select  reserve_size into @reserve_size
        from    sysiqdbfile
        where   dbfile_id       = 16384;

insert  into #statement(statement_txt)
        select  'create database  + @db_file + ' +
        ' IQ PATH  + @iq_file + ' +
        ' IQ PAGE SIZE ' + convert(varchar,@block_size * @chunk_size) +
        ' IQ RESERVE ' + convert(varchar,convert(int,(@reserve_size * 1024)/ @block_size)) +
        ' BLOCK SIZE ' + convert(varchar,@block_size) +
        ' MESSAGE PATH  + @msg_file + ' +
        ' TEMPORARY PATH  + @temp_file + ;' as "statement";

insert  into #statement(statement_txt)
        select  'alter dbspace ' + d1.dbfile_name +
                ' add file ' + d2.dbfile_name + '  + d2.file_name + ;' as "statement"
                from    sysdbfile d1,
                        sysdbfile d2
                where   d1.dbfile_name  in ('IQ_SYSTEM_MAIN', 'IQ_SYSTEM_TEMP')
                and     d1.dbfile_id    = d1.dbspace_id
                and     d2.dbspace_id   = d1.dbspace_id
                and     d2.dbfile_id    != d2.dbspace_id;

open    user_dbspaces;

user_dbspace_loop:
LOOP
        fetch   next user_dbspaces into @user_dbspace;
        if      SQLSTATE = end_of_cursor then
                leave user_dbspace_loop;
        end if;

        insert  into #statement(statement_txt)
                select  'create dbspace ' + @user_dbspace + ' using ';

        set     @counter = 0;

        open    user_dbfiles;

        user_dbfiles_loop:
        LOOP
                fetch   next user_dbfiles into @user_dbfile_name, @user_file_name;
                if      SQLSTATE = end_of_cursor then
                leave   user_dbfiles_loop;
        end if;

        if      @counter = 0 then
                insert  into #statement(statement_txt)
                        select  'file ' + @user_dbfile_name + ' + @user_file_name + ' as statement;

                set     @counter = @counter + 1;
        else
                insert  into #statement(statement_txt)
                        select  ',file ' + @user_dbfile_name + '  + @user_file_name + ' as statement;
        end if;

        end loop user_dbfiles_loop;
        close user_dbfiles;

        insert  into #statement(statement_txt)
                select 'iq store;' as "statement";
end loop user_dbspace_loop;

close   user_dbspaces;

insert  into #statement(statement_txt)
        select  'alter dbspace ' + d.dbspace_name +
                ' striping ' + case sb.striping_on when 'T' then 'on' else 'off' end +
                ' stripesizeKb ' + convert(varchar,stripe_size_kb) + ';' as "statement"
                from    sysiqdbspace sb,
                        sysdbspace d
                where   d.dbspace_id    = sb.dbspace_id
                and     d.store_type    = 2
                and     d.dbspace_name  != 'IQ_SYSTEM_MSG';

select  statement_txt
        from    #statement
        order   by seq;
end;