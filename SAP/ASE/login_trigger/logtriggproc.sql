create or replace procedure proc4login
as
 insert master..log_login ( enter_time, logname ) values ( getdate(), suser_name() )
 return 0
go
grant execute on proc4login to public
