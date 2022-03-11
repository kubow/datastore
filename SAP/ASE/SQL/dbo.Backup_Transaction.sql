create procedure dbo.Backup_Transaction_log /* [ (@param_name datatype [=default] [output] ), ... ] */
as
begin
	declare @db_names varchar(500),
	@dump_location varchar(128),
	@use_srvr_name int,
	@date_fmt int,
	@compress_value int,
	@truncate_flag int,
	@row_threshold int,
	@time_threshold varchar(5),
	@js_runid int

	select @db_names='YOUR DATABASE',
	@dump_location='PATH TO BACKUP',
	@use_srvr_name=0,
	@date_fmt=4,
	@compress_value=6,
	@truncate_flag=0,
	@row_threshold=0,
	@time_threshold='0mi'

	declare @len int
	, @end_pos int
	, @db_name varchar(30)
	, @user_code int
	select @len=isnull(datalength(@db_names), 0)

	--loop through each db specified
	while @len > 0
	begin
		--get the filename, only, next or last
		select @end_pos=patindex('%[, ]%', @db_names )
		if @end_pos <=0
			begin
				-- only or last db_names
				select @db_name=rtrim(ltrim(@db_names))
				select @len=0
			end
		else
			begin
				-- get the next name
				select @db_name=substring(@db_names, 1, @end_pos-1)
				select @db_name=ltrim(rtrim(@db_name))
				select @db_names=stuff(@db_names, 1, @end_pos, NULL)
				select @len=isnull(datalength(ltrim(@db_names)), 0)
			end
		print @db_name
		exec @user_code=sybsystemprocs..sp_jst_dump_tran_logs_to_disk @db_name,
		@dump_location, @use_srvr_name, @date_fmt, @compress_value,
		@truncate_flag, @row_threshold, @time_threshold
		if( @user_code < 0 )
			begin
			print "ase_js_cmd: sp_sjobsetstatus @name='%1!',
			@option='exit_code=2, user_code=%2!'",
			@js_runid, @user_code
			end
		else
			begin
			print "ase_js_cmd: sp_sjobsetstatus @name='%1!',
			@option='exit_code=1, user_code=0'",
			@js_runid
			end
	end
end