create procedure dbo.Backup_Database /* [ (@param_name datatype [=default] [output] ), ... ] */
as
begin
	declare @db_names varchar(500),
	@dump_location varchar(128),
	@use_srvr_name int,
	@date_fmt int,
	@stripe_cnt int,
	@compress_value Int,
	@js_runid Int

	select @db_names='Your DATABASE',
	@dump_location='LOCATION TO THE DUMP',
	@use_srvr_name=0,
	@date_fmt=3,
	@stripe_cnt=8,
	@compress_value=6

	declare @user_code int
	exec @user_code=sybsystemprocs..sp_jst_dump_dbs_to_disk @db_names,
	@dump_location, @use_srvr_name, @date_fmt, @stripe_cnt, @compress_value
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