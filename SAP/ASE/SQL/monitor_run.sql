sp_lock
go
print "-----------end of of sp_lock-------------"
go

select spid,cmd,hostname,program_name,hostprocess,physical_io from sysprocesses order by physical_io
go
print "-----------end of of sysprocesses-------------"
go

select spid, suid, cmd, status, physical_io, cpu from sysprocesses where status in (“sleeping”, “send sleep”, ”lock sleep”) and suid!=0
go
print "-----------end of of sysprocesses-------------"
go

sp_sysmon "00:05:00"
go
print "-----------end of sysmon-------------"
go

sp_lock
go
print "-----------end of of sp_lock-------------"
go

select spid,cmd,hostname,program_name,hostprocess,physical_io from sysprocesses order by physical_io
go
print "-----------end of of sysprocesses-------------"
go

select spid, suid, cmd, status, physical_io, cpu from sysprocesses where status in (“sleeping”, “send sleep”, ”lock sleep”) and suid!=0
go
print "-----------end of of sysprocesses-------------"
go

select * from syslogshold
print "-----------end of syslogshold-------------"
go

sp_object_stats “00:05:00”
go
print "-----------end of of top locking tables-------------"
go

sp_who
go
print "-----------end of of sp_who-------------"
go

sp_monitorconfig “all”
go
print "-----------end of of monitor config-------------"
go

sp_monitor
go
print "-----------end of of monitor-------------"
go

sp_lock
go
print "-----------end of of sp_lock-------------"
go


select spid,cmd,hostname,program_name,hostprocess,physical_io from sysprocesses order by physical_io
go
print "-----------end of of sysprocesses-------------"
go

select spid, suid, cmd, status, physical_io, cpu from sysprocesses where status in (“sleeping”, “send sleep”, ”lock sleep”) and suid!=0
go
print "-----------end of of sysprocesses-------------"
go

sp_sysmon "00:05:00"
go
print "-----------end of sysmon-------------"
go

sp_lock
go
print "-----------end of of sp_lock-------------"
go


select spid,cmd,hostname,program_name,hostprocess,physical_io from sysprocesses order by physical_io
go
print "-----------end of of sysprocesses-------------"
go

select spid, suid, cmd, status, physical_io, cpu from sysprocesses where status in (“sleeping”, “send sleep”, ”lock sleep”) and suid!=0
go
print "-----------end of of sysprocesses-------------"
go
