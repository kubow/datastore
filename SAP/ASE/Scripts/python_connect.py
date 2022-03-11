import sys
sys.path.append('C:\\SAP\\OCS-16_0\\python\\python37_64\\dll')

print('imported')
import sybpydb

#conn = sybpydb.connect(user='sa', password='', servername='audrow_ds')
conn = sybpydb.connect(user='sa', password='sybase', servername='SapMint_ds')
cur = conn.cursor()
cur.execute("use master")
cur.execute("SELECT * FROM sysobjects")


cur.close()
conn.close()
