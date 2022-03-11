'OPTION EXPLICIT
'Set the connection
dim Connection, ConStr
ConStr = "Driver={SQL Server};Server=RS157\SQLEXPRESS;database=DPmHK;Trusted_Connection=yes; Integrated Security=True;"
Set Connection = CreateObject("ADODB.Connection")
Connection.Open ConStr
'...............

'Set the command
DIM cmd
SET cmd = Server.CreateObject("ADODB.Command")
SET cmd.ActiveConnection = Connection

'Set the record set
DIM RS
SET RS = Server.CreateObject("ADODB.recordset")

'Prepare the stored procedure
' cmd.CommandText = "[dbo].[sptestproc]"
' cmd.CommandType = 4  'adCmdStoredProc

' cmd.Parameters("@Option1 ") = Opt1 
' cmd.Parameters("@Option2 ") = Opt2 

'Execute the stored procedure
' SET RS = cmd.Execute
' SET cmd = Nothing

'You can now access the record set
' if (not RS.EOF) THEN
    ' first = RS("first")
    ' second = RS("second")
' end if

'dispose your objects
' RS.Close
' SET RS = Nothing

Connection.Close
SET Connection = Nothing