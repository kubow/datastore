USE atal;
GO

-- importovat soubor StaLin.fs

-- rozdelit dle symbolu | vsechny zname sloupce

-- temp tabulka pro stanice a linky
IF OBJECT_ID('dbo.temp_linky','U') IS NOT NULL DROP TABLE dbo.temp_linky
CREATE TABLE dbo.temp_linky
(
	LineFeed varchar(100)
);
GO

BULK INSERT dbo.temp_linky
   FROM '\\dpserver05\users$\data\atal\fs\StaLin.fs'  
   WITH   
      (  
         CODEPAGE = '1250',
         ROWTERMINATOR ='\n'  
      );

/*SELECT * FROM dbo.temp_linky*/

-- struktura pro stanice a linky
IF OBJECT_ID('dbo.C_StaLinky','U') IS NOT NULL DROP TABLE dbo.C_StaLinky
CREATE TABLE dbo.C_StaLinky
(
	Cislo_linky varchar(10)
	,Cislo_licence int
	,Druh_provozu varchar(10)
	,Platnost varchar(50)
	,Poradi int
	,Cislo_zastavky int
	,Cislo_oznacniku varchar(10)
	,Smer int
	,t0 varchar(10)
	,t1 varchar(10)
	,t2 varchar(10)
	,t3 varchar(10)
	,t4 varchar(10)
	,t5 varchar(10)
	,t6 varchar(10)
	,t7 varchar(10)
	,t8 varchar(10)
	,t9 varchar(10)
	,Temp varchar(10)
);
GO

-- prochazet temp a vkladat
DECLARE @radek varchar(100)
DECLARE @linka varchar(10)
DECLARE @licence varchar(10)
DECLARE @provoz varchar(10)
DECLARE @platnost varchar(50)
DECLARE @poradi varchar(50)
DECLARE @zastavka varchar(10)
DECLARE @oznacnik varchar(10)
DECLARE @smer varchar(10)
DECLARE @s0 varchar(10)
DECLARE @s1 varchar(10)
DECLARE @s2 varchar(10)
DECLARE @s3 varchar(10)
DECLARE @s4 varchar(10)
DECLARE @s5 varchar(10)
DECLARE @s6 varchar(10)
DECLARE @s7 varchar(10)
DECLARE @s8 varchar(10)
DECLARE @s9 varchar(10)
DECLARE @zbytek varchar(50)

DECLARE C CURSOR FOR SELECT LineFeed FROM dbo.temp_linky

OPEN C

FETCH NEXT FROM C INTO @radek
WHILE @@FETCH_STATUS = 0
BEGIN
	IF LEFT(@radek, 1) = '@'
		BEGIN
			--PRINT @radek + ' contains @'
			SET @linka = REPLACE(dbo.SPLIT_COLUMNS(@radek, 1, '|'),'@','')
			SET @licence = dbo.SPLIT_COLUMNS(@radek, 2, '|') 
			SET @provoz = dbo.SPLIT_COLUMNS(@radek, 3, '|') 
			SET @platnost = REPLACE(@radek, '@' + @linka + '|' + @licence + '|' + @provoz + '|', '') 
		END
	ELSE
		BEGIN
			--PRINT @radek + ' values'
			SET @poradi = dbo.SPLIT_COLUMNS(@radek, 1, '|')
			SET @zastavka = dbo.SPLIT_COLUMNS(@radek, 2, '|')
			SET @oznacnik = dbo.SPLIT_COLUMNS(@radek, 3, '|')
			SET @smer = dbo.SPLIT_COLUMNS(@radek, 4, '|')
			SET @s0 = dbo.SPLIT_COLUMNS(@radek, 5, '|')
			SET @s1 = dbo.SPLIT_COLUMNS(@radek, 6, '|')
			SET @s3 = dbo.SPLIT_COLUMNS(@radek, 7, '|')
			SET @s4 = dbo.SPLIT_COLUMNS(@radek, 8, '|')
			SET @s5 = dbo.SPLIT_COLUMNS(@radek, 9, '|')
			SET @s6 = dbo.SPLIT_COLUMNS(@radek, 10, '|')
			SET @s7 = dbo.SPLIT_COLUMNS(@radek, 11, '|')
			SET @s8 = dbo.SPLIT_COLUMNS(@radek, 12, '|')
			SET @s9 = dbo.SPLIT_COLUMNS(@radek, 13, '|')
			SET @zbytek = REPLACE(@radek, @poradi + '|' + @zastavka + '|' + @oznacnik + '|' + @smer + '|' + @s0 + '|' + @s1 + '|' + @s2 + '|' + @s3 + '|' + @s4 + '|' + @s5 + '|' + @s6 + '|' + @s7 + '|' + @s8 + '|' + @s9 + '|', '') 
			INSERT INTO dbo.C_StaLinky (Cislo_linky, Cislo_licence, Druh_provozu, Platnost, Poradi, Cislo_zastavky, Cislo_oznacniku, Smer, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, Temp) 
			VALUES (@linka, @licence, @provoz, @platnost, @poradi, @zastavka, @oznacnik, @smer, @s0, @s1, @s2, @s3, @s4, @s5, @s6, @s7, @s8, @s9, @zbytek)
			--PRINT @linka + @licence + @provoz + @platnost + @poradi + @zastavka + @oznacnik
		END
	FETCH NEXT FROM C INTO @radek
END

CLOSE C
DEALLOCATE C
GO

IF OBJECT_ID('dbo.LinkyStanice','V') IS NOT NULL DROP VIEW dbo.LinkyStanice
GO
CREATE VIEW dbo.LinkyStanice AS
SELECT     TOP (100) PERCENT dbo.C_StaLinky.Cislo_linky, dbo.C_StaLinky.Poradi, dbo.C_Stanice.Nazev_zastavky, dbo.C_Stanice.Zkraceny_nazev_zastavky, 
                      dbo.C_StaLinky.Cislo_zastavky, dbo.C_StaLinky.Cislo_oznacniku, dbo.C_StaLinky.Druh_provozu, dbo.C_StaLinky.Smer, dbo.C_StaLinky.t0, dbo.C_StaLinky.t8, 
                      dbo.C_StaLinky.t3, dbo.C_StaLinky.t4, dbo.C_StaLinky.t6, dbo.C_StaLinky.Cislo_licence, dbo.C_StaLinky.Platnost
FROM         dbo.C_Stanice INNER JOIN
                      dbo.C_StaLinky ON dbo.C_Stanice.Cislo_zastavky = dbo.C_StaLinky.Cislo_zastavky AND dbo.C_Stanice.Cislo_oznacniku = dbo.C_StaLinky.Cislo_oznacniku AND 
                      dbo.C_Stanice.Druh_provozu = dbo.C_StaLinky.Druh_provozu
GO

IF OBJECT_ID('dbo.temp_linky','U') IS NOT NULL DROP TABLE dbo.temp_linky
SELECT * FROM dbo.C_StaLinky 