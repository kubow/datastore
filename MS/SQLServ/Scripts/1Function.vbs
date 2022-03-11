'OPTION EXPLICIT
'Set the connection - https://www.connectionstrings.com/sql-server/
'conStr = "Driver={SQL Server};Server=RS157\SQLEXPRESS;database=DPmHK;Integrated Security=True;"
'conStr = "provider=sqloledb;Data Source=localhost\SQLEXPRESS;initial catalog=DPmHK;Trusted_Connection=yes; Integrated Security=True;"
'conStr="DSN=localhost\SQLEXPRESS;Integrated Security=True;;Database=DPmHK"
'conStr="Provider=System.Data.SqlClient;Server=RS157\SQLEXPRESS; database=DPmHK;Integrated Security=True;Trusted_Connection=yes"
dim conStr: conStr="Provider=SQLNCLI11;Server=RS157\SQLEXPRESS; database=DPmHK;Trusted_Connection=yes"
Dim oConn: Set oConn = CreateObject("ADODB.Connection")
oConn.Open conStr

Dim sqlString: sqlString = "SELECT * FROM [dbo].[vysledek] ORDER BY [Poradi]"
'oConn.Execute( CStr(sqlString) )

Dim rs: Set rs = CreateObject("ADODB.recordset")
rs.Open sqlString,oConn

If rs.EOF Then 
	wscript.echo "There are no records to retrieve; Check that you have the correct job number."
Else 
	Do While NOT rs.Eof   
		wscript.echo rs.Fields.Item("Lokace")
		rs.MoveNext     
	Loop
End If

rs.Close
Set rs=nothing

oConn.Close
Set oConn = Nothing
