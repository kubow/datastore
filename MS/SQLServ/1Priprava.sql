USE atal
GO

-- funkce pro split
IF OBJECT_ID(N'dbo.SPLIT_COLUMNS',N'FN') IS NOT NULL DROP FUNCTION dbo.SPLIT_COLUMNS
GO

CREATE FUNCTION dbo.SPLIT_COLUMNS(
 @TEXT      varchar(500)
,@COLUMN    tinyint
,@SEPARATOR char(1)
)RETURNS varchar(500)
AS
  BEGIN
       DECLARE @POS_START  int = 1
       DECLARE @POS_END    int = CHARINDEX(@SEPARATOR, @TEXT, @POS_START)

       WHILE (@COLUMN >1 AND @POS_END> 0)
         BEGIN
             SET @POS_START = @POS_END + 1
             SET @POS_END = CHARINDEX(@SEPARATOR, @TEXT, @POS_START)
             SET @COLUMN = @COLUMN - 1
         END 

       IF @COLUMN > 1  SET @POS_START = LEN(@TEXT) + 1
       IF @POS_END = 0 SET @POS_END = LEN(@TEXT) + 1 

       RETURN SUBSTRING (@TEXT, @POS_START, @POS_END - @POS_START)
  END
GO

--funkce pro odstraneni czech characters - pro sparovani 
IF OBJECT_ID(N'dbo.REMOVE_CHARS',N'FN') IS NOT NULL DROP FUNCTION dbo.REMOVE_CHARS
GO
CREATE FUNCTION dbo.REMOVE_CHARS (@s varchar(50)) RETURNS varchar(50)
AS
	BEGIN
		IF @s IS NULL
        RETURN NULL
		DECLARE @OutputString VARCHAR(8000)
		SET @OutputString = ''
		DECLARE @l INT
		SET @l = LEN(@s)
		DECLARE @p INT
		SET @p = 1
		WHILE @p <= @l
	        BEGIN
		        DECLARE @c INT
			    SET @c = ASCII(SUBSTRING(@s, @p, 1))
				IF @c BETWEEN 48 AND 57
					OR @c BETWEEN 65 AND 90
					OR @c BETWEEN 97 AND 122
					OR @c = 32 --as space character
					SET @OutputString = @OutputString + CHAR(@c)
				IF @c = 193 or @c = 225
					SET @OutputString = @OutputString + 'a'
				IF @c = 201 or @c = 233 or @c = 204 or @c = 236
					SET @OutputString = @OutputString + 'e'
				IF @c = 205 or @c = 237
					SET @OutputString = @OutputString + 'i'
				IF @c = 211 or @c = 243
					SET @OutputString = @OutputString + 'o'
				IF @c = 218 or @c = 250 or @c = 249
					SET @OutputString = @OutputString + 'u'
				IF @c = 221 or @c = 253
					SET @OutputString = @OutputString + 'y'
				IF @c = 200 or @c = 232
					SET @OutputString = @OutputString + 'c'
				IF @c = 207 or @c = 239
					SET @OutputString = @OutputString + 'd'
				IF @c = 210 or @c = 242
					SET @OutputString = @OutputString + 'n'
				IF @c = 216 or @c = 248
					SET @OutputString = @OutputString + 'r'
				IF @c = 138 or @c = 154
					SET @OutputString = @OutputString + 's'
				IF @c = 141 or @c = 157
					SET @OutputString = @OutputString + 't'
				IF @c = 142 or @c = 158
					SET @OutputString = @OutputString + 'z'
				SET @p = @p + 1
	        END
		IF LEN(@OutputString) = 0
			RETURN NULL
	    RETURN @OutputString
	END
GO

-- tabulka zastavek (STA.fs -- C_Stanice)
IF OBJECT_ID('dbo.C_Stanice','U') IS NOT NULL DROP TABLE dbo.C_Stanice

CREATE TABLE dbo.C_Stanice
(
	Cislo_zastavky int
	,Cislo_oznacniku int
	,Druh_provozu varchar(10)
	,Nazev_zastavky varchar(100)
	,Zkraceny_nazev_zastavky varchar(20)
	,Temp int
);
GO
PRINT '...importing STA.FS'
BULK INSERT dbo.C_Stanice
   FROM '\\dpserver05\users$\data\atal\fs\STA.fs'  
   WITH   
      (  
         CODEPAGE = '1250',
		 FIELDTERMINATOR ='|',  
         ROWTERMINATOR ='\n'  
      );  

-- Counter pairing Vehicle_Number a Nazev_sluzby
PRINT '...creating table C_Vozy'
IF OBJECT_ID('dbo.C_Vozy','U') IS NOT NULL DROP TABLE dbo.C_Vozy
CREATE TABLE dbo.C_Vozy
(
	Vuz_cislo int
	,Linka varchar(10)
	,Nazev_sluzby varchar(10)
	,Datum date
);
PRINT '...importing vozy.csv'
SET DATEFORMAT dmy;
-- INSERT INTO dbo.C_Vozy VALUES (163, '15', 15321, '2016-02-15')
BULK INSERT dbo.C_Vozy
	FROM '\\dpserver05\users$\data\atal\vozyn.csv'  
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',  --CSV field delimiter
		ROWTERMINATOR = '\n' --'0x0a'   --Use to shift the control to next row 
	);  
-- csv pro importovani propojujicich hodnot
UPDATE dbo.C_Vozy SET Nazev_sluzby = '0' + Nazev_sluzby
-- nutno udelat update nazvu slzby
-- ciselniky
PRINT '...creating table C_Provoz'
IF OBJECT_ID('dbo.C_Provoz','U') IS NOT NULL DROP TABLE dbo.C_Provoz
CREATE TABLE dbo.C_Provoz
(
	Druh_provozu varchar(10)
	,Nazev_provozu varchar(50)
);
INSERT INTO dbo.C_Provoz VALUES ('O', 'Trolejbus')
INSERT INTO dbo.C_Provoz VALUES ('T', 'Autobus')

IF OBJECT_ID('dbo.C_TypDen','U') IS NOT NULL DROP TABLE dbo.C_TypDen
PRINT '...creating table C_Den (list of file type days)'
CREATE TABLE dbo.C_TypDen
(
	Typ_dne varchar(10)
	,Nazev_dne varchar(50)
);
INSERT INTO dbo.C_TypDen VALUES ('c', 'Pracovní den')
INSERT INTO dbo.C_TypDen VALUES ('X', 'Pracovní den omezení dopravy')
INSERT INTO dbo.C_TypDen VALUES ('6', 'Sobota')
INSERT INTO dbo.C_TypDen VALUES ('7', 'Nedìle')

PRINT '...creating table C_PoradiLokace'
IF OBJECT_ID('dbo.C_PoradiLokace','U') IS NOT NULL DROP TABLE dbo.C_PoradiLokace
/*CREATE TABLE dbo.C_PoradiLokace
(
	Poradi int
	,Poradi_lokace int
	,Linka15a int
	,Linka15b int
);
GO
INSERT INTO dbo.C_PoradiLokace VALUES (100, 0, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (1, 0.5, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (35, 1, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (34, 2, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (33, 3, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (32, 4, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (31, 5, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (30, 6, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (29, 7, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (28, 8, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (27, 9, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (26, 10, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (22, 11, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (21, 12, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (20, 13, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (19, 14, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (18, 15, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (17, 16, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (16, 17, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (15, 18, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (14, 19, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (13, 20, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (12, 21, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (11, 22, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (10, 23, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (9, 24, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (8, 25, 1, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (7, 26, 0, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (6, 27, 0, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (5, 28, 0, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (4, 29, 0, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (3, 30, 0, 1)
INSERT INTO dbo.C_PoradiLokace VALUES (2, 31, 0, 1)
*/