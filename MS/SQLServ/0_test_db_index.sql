 
USE master
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'IndexMaintenance')
DROP DATABASE [IndexMaintenance]
GO
CREATE DATABASE IndexMaintenance;
GO
USE IndexMaintenance;
GO 
 
CREATE TABLE IndexTable (c1 INT, c2 CHAR (4000));
CREATE CLUSTERED INDEX IndexTable_CL ON IndexTable (c1);
GO
 
 
DECLARE @a INT
SET @a = 1
WHILE (@a<80)
BEGIN
IF (@a=5 or @a=15 or @a=22 or @a=29 or @a=34 or @a=38 or @a=45) PRINT 'Nothing to insert'
ELSE INSERT INTO IndexTable VALUES (@a, 'a')
SET @a=@a + 1
END
 
INSERT INTO IndexTable VALUES (5, 'a');
GO 
INSERT INTO IndexTable VALUES (15, 'a');
GO 
INSERT INTO IndexTable VALUES (22, 'a');
GO 
INSERT INTO IndexTable VALUES (29, 'a');
GO 
INSERT INTO IndexTable VALUES (34, 'a');
GO 
INSERT INTO IndexTable VALUES (38, 'a');
GO 
INSERT INTO IndexTable VALUES (45, 'a');
GO 
 