--#install additional languages
--search for *.loc files - desired character set ID - corresponds binary.srt
--#bin/bash
charset -Usa -Ssrv binary.srt cp1250
--#win
%SYBASE%\%SYBASE_ASE%\bin\charset -Usa -Ssrv binary.srt cp1250

--search for *.srt files - desired sort order ID - corresponds name_of_sort_order.srt
--#bin/bash
charset -Usa -Ssrv name_of_sort_order.srt cp1250
--#win
%SYBASE%\%SYBASE_ASE%\bin\charset -Usa -Ssrv name_of_sort_order.srt cp1250


--#configure charset and sort order
sp_configure "default character set id"
go
--#restart ase service 1st
shutdown
go
sp_configure "default sortorder id"
go
--#restart ase service 2nd
shutdown
go
--#examine result
sp_helpsort

--#change languages (localizations)
select * from master.dbo.syslanguages
select * from master.dbo.sysmessages

sp_configure "enable unicode conversions"
sp_configure "Languages"