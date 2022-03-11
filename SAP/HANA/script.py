# install on command line
# pip install /path/to/hdbclient/hdbcli-N.N.N.zip
from hdbcli import dbapi

conn = dbapi.connect(address='<host>', port=3NN13, databaseName='<DB>', user='<userid>', password='<pass>')

# queries and result sets
cursor = conn.cursor()
cursor.execute('SELECT * FROM T1')
for row in cursor:
    print(row)
    
# streaming LOBs
cursor.execute('SELECT PHOTO from T1 WHERE id = :id', {'id': id})
out_blob = cursor.fetchone(True)[0]
out_img = bytearray()
flag = True
while flag:
    data = out_blob.read(size=500)
    if data:
        out_img.extend(data.tobytes())
    else:
        flag = False
        
        
# stored procedure
sql_proc = """create procedure ADD2 (in a int, in b int, out c int)
language sqlscript reads data as 
begin
    c := :a + :b;
end"""
cursor,execute(sql_proc)

# call stored procdeures
params_in = (2, 5, None)
params_out = cursor.callproc('ADD2', params_in)
print(params_out)