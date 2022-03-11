USE atal;
GO

/* ******************************************************** */
/* *******PRIPRAVA ZDROJE A VYSELDKOVE TABULKY************* */ 
/* ******************************************************** */

--- import tabulky zdroj (surova data) -- nutno zapnout
PRINT '******** Script  begin ********'
IF OBJECT_ID('dbo.zdroj_temp','U') IS NOT NULL DROP TABLE dbo.zdroj_temp
CREATE TABLE dbo.zdroj_temp (
	temp1 varchar(50)
	,Vehicle_Name varchar(10)
	,temp2 varchar(50)
	,Lokace varchar(50)
	,temp3 varchar(50)
	,ostatni varchar(100)
	,temp4 varchar(50)
	)
BULK INSERT dbo.zdroj_temp
	FROM '\\dpserver05\users$\data\atal\import_dat.csv'  
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '"',  --CSV field delimiter
		ROWTERMINATOR = '\n' --'0x0a'   --Use to shift the control to next row 
	);  

IF OBJECT_ID('dbo.zdroj','U') IS NOT NULL DROP TABLE dbo.zdroj
CREATE TABLE dbo.zdroj (
	Vehicle_Name varchar(50)
	,Lokace varchar(50)
	,Datum_prijezdu varchar(50)
	,Cas_prijezdu time(7)
	,Datum_odjezdu varchar(50)
	,Cas_odjezdu time(7)
	,Doba_na_zastavce time(7)
	,Prijelo varchar(50)
	,Nastoupilo varchar(50)
	,Vystoupilo varchar(50)
	,Odjelo varchar(50)
	)

insert into dbo.zdroj 
(
Vehicle_Name,Lokace,Datum_prijezdu,Cas_prijezdu,Datum_odjezdu,Cas_odjezdu,Doba_na_zastavce,Prijelo,Nastoupilo,Vystoupilo,Odjelo)
select 
LEFT(Vehicle_Name, LEN(Vehicle_Name) - 1), RTRIM(Lokace),dbo.SPLIT_COLUMNS([ostatni], 2, ','),dbo.SPLIT_COLUMNS([ostatni], 3, ','),dbo.SPLIT_COLUMNS([ostatni], 4, ','),dbo.SPLIT_COLUMNS([ostatni], 5, ','),dbo.SPLIT_COLUMNS([ostatni], 6, ','),dbo.SPLIT_COLUMNS([ostatni], 7, ','),dbo.SPLIT_COLUMNS([ostatni], 8, ','),dbo.SPLIT_COLUMNS([ostatni], 9, ','),dbo.SPLIT_COLUMNS([ostatni], 10, ',')
from 
[dbo].[zdroj_temp]
go
-- IF OBJECT_ID('dbo.zdroj_temp','U') IS NOT NULL DROP TABLE dbo.zdroj_temp 
--- zpracovani dat do tabulky zdroj
PRINT '--------------------- zdroj table prepared ---------------------'
-- vytvoreni tabulky vysledek (pole, formaty)
PRINT '... Creating new table vysledek from table zdroj'
IF OBJECT_ID('dbo.vysledek','U') IS NOT NULL DROP TABLE dbo.vysledek
create table dbo.vysledek (
	Vehicle_Name varchar(50)
	,Lokace varchar(50)
	,ID_Lokace varchar(10)
	,Oznacovnik varchar(10)
	,Datum_prijezdu date
	,Cas_prijezdu time
	,Datum_odjezdu date
	,Cas_odjezdu time
	,Doba_na_zastavce time
	,Prijelo /*varchar(10)*/ int
	,Nastoupilo /*varchar(10)*/ int
	,Vystoupilo /*varchar(10)*/ int
	,Odjelo /*varchar(10)*/ int
	,Poradi int
	,Kurz varchar(10)
	,Linka varchar(10)
	,Spoj varchar(10)
	,Smer int
	,cas_jr time
	,rownumber int IDENTITY
	,RN int
	)

-- naplneni tabulky vysledek (preformatovani dat a casu, orezani retezcu)
insert into dbo.vysledek 
(
Vehicle_Name,Lokace,ID_Lokace,Oznacovnik,Datum_prijezdu,Cas_prijezdu,Datum_odjezdu,Cas_odjezdu,Doba_na_zastavce,Prijelo,Nastoupilo,Vystoupilo,Odjelo)
select 
Vehicle_Name, Lokace
,REVERSE(substring(reverse(RTRIM(REPLACE(Lokace,'"',''))),0,charindex(' ',reverse(RTRIM(REPLACE(Lokace,'"',''))))))
,RIGHT(REPLACE(Lokace,'"',''),1)
,DATEFROMPARTS(dbo.SPLIT_COLUMNS(Datum_prijezdu, 3, '.'), dbo.SPLIT_COLUMNS(Datum_prijezdu, 2, '.'), dbo.SPLIT_COLUMNS(Datum_prijezdu, 1, '.'))
,Cas_prijezdu
,DATEFROMPARTS(dbo.SPLIT_COLUMNS(Datum_odjezdu, 3, '.'), dbo.SPLIT_COLUMNS(Datum_odjezdu, 2, '.'), dbo.SPLIT_COLUMNS(Datum_prijezdu, 1, '.'))
,Cas_odjezdu
,Doba_na_zastavce,Prijelo,Nastoupilo,Vystoupilo,Odjelo
from 
zdroj
go

-- uprava zastavek bez oznacovniku / nastaveni hodnoty 0!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
PRINT '... Searching for stops without proper location ID / updating with 0 '
DECLARE @Vuz_cislo int
DECLARE @Lokace varchar(50)
DECLARE @Cislo_zastavky varchar(50)
DECLARE @Cislo_oznacniku varchar(50)

DECLARE C CURSOR FOR SELECT  COUNT(Vehicle_Name), MIN(Lokace), ID_Lokace, Oznacovnik FROM dbo.vysledek GROUP BY ID_Lokace, Oznacovnik ORDER BY ID_Lokace ASC
OPEN C
FETCH NEXT FROM C INTO @Vuz_cislo,@Lokace,@Cislo_zastavky,@Cislo_oznacniku
WHILE @@FETCH_STATUS = 0
BEGIN
	--pokud neni cislo zastavky celociselne, nahradime nulou, posleze updatujeme konkretnim cislem
	IF ISNUMERIC(@Cislo_zastavky) = 0
		BEGIN
			PRINT @Cislo_zastavky + ' > 0 (UPDATE dbo.vysledek SET ID_Lokace = 0, Oznacovnik = 0 WHERE ID_Lokace = ' + @Cislo_zastavky + ')'
			UPDATE dbo.vysledek SET ID_Lokace = '00', Oznacovnik = 0 WHERE ID_Lokace = @Cislo_zastavky
		END
	FETCH NEXT FROM C INTO @Vuz_cislo,@Lokace,@Cislo_zastavky,@Cislo_oznacniku
END
CLOSE C
DEALLOCATE C

-- uprava vysledku - pole Lokace (odstraneni cisla), pole ID_Lokace (odstraneni posledniho cisla), cisla radku (prejmenovani sloupce)
PRINT '... Trimming location names and IDs'
update dbo.vysledek set ID_Lokace = substring(rtrim(ID_Lokace),1,len(ID_Lokace)-1), Lokace = REPLACE(Lokace,ID_Lokace,''), RN = rownumber
go
PRINT '... Nulling and renaming column'
alter table dbo.vysledek drop column rownumber
EXEC sp_rename 'dbo.vysledek.RN', 'people'
go
ALTER TABLE dbo.vysledek ADD vozovna int
--UPDATE dbo.vysledek SET /*rownumber*/ people = 0
--EXEC sp_rename 'dbo.vysledek.rownumber', 'people'
PRINT '--------------------- vysledek table prepared ---------------------'
IF OBJECT_ID('dbo.vysledek_final','U') IS NOT NULL DROP TABLE dbo.vysledek_final
SELECT * INTO dbo.vysledek_final FROM dbo.vysledek
DELETE FROM dbo.vysledek_final
PRINT '--------------------- structure of vysledek final table done ---------------------'

/* ******************************************************* */
/* *******H L A V N I   C Y K L U S - D A T U M Y********* */ 
/* ******************************************************* */
PRINT '--------------------- dates iterating ---------------------'
DECLARE @Vuz_ID int
DECLARE @ListofRides TABLE(Vuz_cislo int ,Linka varchar(10),Nazev_sluzby varchar(50),NDen date, nrows int, fullrows int, nid int) -- seznam dni
DECLARE @nid_last int -- posledni ID
DECLARE @nrows int
-----------------------------------------------------------------------
SELECT @Vuz_ID = [Vehicle_Name] FROM [dbo].[zdroj] GROUP BY [Vehicle_Name]
INSERT INTO @ListofRides SELECT Vuz_cislo, Linka, Nazev_sluzby, Datum, 0, 0, 0 FROM C_Vozy WHERE Vuz_cislo = @Vuz_ID
--DATEFROMPARTS(dbo.SPLIT_COLUMNS(Datum_prijezdu, 3, '.'), dbo.SPLIT_COLUMNS(Datum_prijezdu, 2, '.'), dbo.SPLIT_COLUMNS(Datum_prijezdu, 1, '.')) AS NDen FROM dbo.zdroj GROUP BY Datum_prijezdu 

--SELECT NDen FROM @ListofDays ORDER BY NDen;
DECLARE @NVC int
DECLARE @NL varchar(10)
DECLARE @NNS varchar(50)
DECLARE @PNS varchar(10)
DECLARE @ND date
DECLARE @PD date
DECLARE @NR int
DECLARE @NFR int
DECLARE @NI int
DECLARE @nid int
SET @PD = DATEFROMPARTS(2000,1,1)
SET @nid = 1
DECLARE C CURSOR FOR SELECT * FROM @ListofRides ORDER BY NDen
OPEN C
FETCH NEXT FROM C INTO @NVC,@NL,@NNS,@ND,@NR,@NFR,@NI
WHILE @@FETCH_STATUS = 0
	BEGIN
		/*IF @PD = @ND
			BEGIN
				SET @nid = @nid - 1
				PRINT 'date '  + CAST(@ND as varchar(10)) + ' - more than one row (' + CAST(@nid as varchar(10)) + ')'
				UPDATE @ListofRides SET Nazev_sluzby = @NNS + ',' + @PNS, nid = @nid WHERE Nazev_sluzby = @NNS AND NDen = @ND
				DELETE FROM @ListofRides WHERE Nazev_sluzby = @PNS AND NDen = @ND
			END
		ELSE
			BEGIN
				PRINT 'date '  + CAST(@ND as varchar(10)) + ' (' + CAST(@nid as varchar(10)) + ')'
				UPDATE @ListofRides SET nid = @nid WHERE Nazev_sluzby = @NNS AND NDen = @ND
			END
		SET @PD = @ND
		SET @PNS = @NNS*/
		UPDATE @ListofRides SET nid = @nid WHERE Nazev_sluzby = @NNS AND NDen = @ND
		SET @nid = @nid + 1
		FETCH NEXT FROM C INTO @NVC,@NL,@NNS,@ND,@NR,@NFR,@NI
	END
CLOSE C
DEALLOCATE C

SELECT @nid = min(nid), @nid_last = max(nid) FROM @ListofRides
--SELECT @nid = min(nid), @nid_last = 3 FROM @ListofRides ---comment!!!!!!!!!!!!!!!!!!!!
DECLARE @minpeople int
WHILE @nid < @nid_last
BEGIN
	SET @nrows = 0
	SELECT @NVC=Vuz_cislo,@NL=Linka,@NNS=Nazev_sluzby,@ND=NDen,@NR=nrows,@NFR=fullrows FROM @ListofRides WHERE nid=@nid 
	SELECT @nrows = COUNT(Datum_prijezdu) FROM dbo.vysledek WHERE Datum_prijezdu = @ND GROUP BY Datum_prijezdu
	UPDATE @ListofRides SET nrows = @nrows WHERE NDen = @ND
	IF @nrows > 0
		BEGIN
			PRINT '********************************* day ' + CAST(@ND as varchar(10)) + '*********************************'
			PRINT '------------------ Prepare temp table : ------------------------------'
			IF OBJECT_ID('dbo.vysledek_temp','U') IS NOT NULL DROP TABLE dbo.vysledek_temp
			PRINT 'vysledek_temp prepared from vysledek table (where Datum_prijezdu = '+CAST(@ND as varchar(10))+')'
			SELECT * INTO dbo.vysledek_temp FROM dbo.vysledek WHERE Datum_prijezdu = @ND
		
			--- naplneni pomocne tabulky PoradiZastavky (poradi zastavek pro platny prikaz z View)
			PRINT '------------------ Creating station order (PoradiZastavky): ------------------------------'
			IF OBJECT_ID('dbo.PoradiZastavky','U') IS NOT NULL DROP TABLE dbo.PoradiZastavky
			IF CHARINDEX(',',@NNS) > 0
				BEGIN
					PRINT 'SELECT * FROM dbo.PrikazStanice WHERE (Nazev_sluzby='+dbo.SPLIT_COLUMNS(@NNS, 1, ',')+' OR Nazev_sluzby='+dbo.SPLIT_COLUMNS(@NNS, 2, ',')+')'
					SELECT * INTO dbo.PoradiZastavky FROM dbo.PrikazStanice WHERE (Nazev_sluzby=CAST(dbo.SPLIT_COLUMNS(@NNS, 1, ',') as int) OR Nazev_sluzby=CAST(dbo.SPLIT_COLUMNS(@NNS, 2, ',') as int))
				END
			ELSE
				BEGIN
					PRINT 'SELECT * FROM dbo.PrikazStanice WHERE Nazev_sluzby='+CAST(CAST(@NNS as int) as varchar(10))
					SELECT * INTO dbo.PoradiZastavky FROM dbo.PrikazStanice WHERE Nazev_sluzby=CAST(@NNS as int)
				END
			PRINT 'Update PoradiZastavky / set date&time from field Prijezd AND vuz_cislo='+CAST(@NVC as varchar(10))
			--PRINT 'UPDATE dbo.PoradiZastavky SET Vuz_cislo = '+CAST(@NVC as varchar(10))+', Datum = '+CAST(Prijezd as varchar(10))
			UPDATE dbo.PoradiZastavky SET Vuz_cislo = @NVC,Datum = DATETIMEFROMPARTS(YEAR(@ND),MONTH(@ND),DAY(@ND),CAST([Prijezd] as int)/60,CAST([Prijezd] as int)%60,0,0) WHERE [Prijezd] < 1440
			PRINT '--- minimum correction'
			SELECT @minpeople=MIN([Poradi])-1 FROM dbo.PoradiZastavky
			PRINT '---UPDATE dbo.PoradiZastavky SET [Poradi] = [Poradi] - '+CAST(@minpeople as varchar(10))
			UPDATE dbo.PoradiZastavky SET [Poradi] = [Poradi] - @minpeople

			---------------------------------------------------------------------------------------------------------------
			--- pridani chybejicich zastavek z pomocne tabulky (vyplneni dat Kurz, Linka, Spoj, Smer) a aktualizace cisla oznacniku
			PRINT '------------------ Filling out missing stations: ------------------------------'
			DECLARE @Vuz_cislo int
			DECLARE @Kurz int
			DECLARE @Linka varchar(10)
			DECLARE @Smer int
			DECLARE @Poradi_lokace int
			DECLARE @Nazev_zastavky varchar(50)
			DECLARE @Zkraceny_nazev_zastavky varchar(10)
			DECLARE @Cislo_zastavky int
			DECLARE @Cislo_oznacniku int
			DECLARE @Druh_provozu varchar(10)
			DECLARE @Prijezd int
			DECLARE @Odjezd int
			DECLARE @KodCile int
			DECLARE @Nazev_sluzby varchar(10)
			DECLARE @Typ_den varchar(10)
			DECLARE @Datum datetime

			DECLARE @Spoj int
			DECLARE @Poradi int
			DECLARE @tporad varchar(10)
			
			DECLARE @ID_Lokace varchar(10)
			DECLARE @Oznacovnik varchar(10)
			DECLARE @Zastavka varchar(50)
	
			DECLARE @gapcnt int -- pocitadlo mezer
			DECLARE @PrevID varchar(10) -- promene pro predchazejici zaznamy
			DECLARE @NextID varchar(10)
			DECLARE @NextID2 varchar(10)
			DECLARE @PrevSame int
			DECLARE @PrevKurz int
			DECLARE @PrevLinka varchar(10)
			DECLARE @PrevSpoj int
			DECLARE @PrevSmer int
			DECLARE @PrevCasJR time

			SET @Poradi = 1
			SET @gapcnt = 0

			DECLARE C CURSOR FOR SELECT * FROM dbo.PoradiZastavky ORDER BY Prijezd ASC
			OPEN C
			FETCH NEXT FROM C INTO @Vuz_cislo,@Kurz,@Linka,@Smer,@Poradi_lokace,@Nazev_zastavky,@Zkraceny_nazev_zastavky,@Cislo_zastavky,@Cislo_oznacniku,@Druh_provozu,@Prijezd,@Odjezd,@KodCile,@Nazev_sluzby,@Typ_den,@Datum,@tporad
			WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @ID_Lokace = ''
					SET @Oznacovnik = ''
					SELECT @ID_Lokace=ID_Lokace, @Oznacovnik=Oznacovnik, @Zastavka=Lokace from dbo.vysledek_temp where people=(@Poradi-@gapcnt)
					IF @Poradi > 3
						BEGIN
							SELECT @PrevID = ID_Lokace from dbo.vysledek_temp where people=(@Poradi-@gapcnt-1)
							IF @PrevID = @ID_Lokace 
								BEGIN
									PRINT @tporad
									SELECT @NextID = Cislo_zastavky from dbo.PoradiZastavky where Poradi=(@tporad+1)
									SELECT @NextID2 = Cislo_zastavky from dbo.PoradiZastavky where Poradi=(@tporad+2)
									PRINT CAST(@PrevID as varchar(10)) + ' vs ' + CAST(@ID_Lokace as varchar(10)) + ' / ' + CAST(@NextID as varchar(10)) + '-' + CAST(@Cislo_zastavky as varchar(10)) 
									IF @NextID = @Cislo_zastavky
										BEGIN
										PRINT 'hoooooooooooooooooooooooooray!!!!!!!'
										SET @PrevSame = 0
										END
									ELSE
										BEGIN
										SET @PrevSame = 1
										END
								END
							ELSE
								BEGIN
									SET @PrevSame = 0
								END
						END
					PRINT '--- row number ' + CAST(@Poradi as varchar(10)) /*+ '-' + CAST(@gapcnt as varchar(10)) */+ ' --- station: ' + CAST(@ID_Lokace as varchar(10)) + '/' + CAST(@Oznacovnik as varchar(10)) + ' - ' + @Zastavka
					IF @ID_Lokace = 0 -- vyplnujeme logickeho nasledovnika, pokud je nazev zastavky nerozeznan
						BEGIN
							PRINT '0 station - updating with logical follower... UPDATE dbo.vysledek_temp SET ID_Lokace = @Cislo_zastavky, Oznacovnik = @Cislo_oznacniku WHERE people = ' + CAST(@Poradi-@gapcnt as varchar(10))
							UPDATE dbo.vysledek_temp SET ID_Lokace = @Cislo_zastavky, Oznacovnik = @Cislo_oznacniku, Kurz = @NNS WHERE people = @Poradi-@gapcnt
							SET @ID_Lokace = @Cislo_zastavky
						END
					IF @Cislo_zastavky = @ID_Lokace -- zastavka je na spravnem poradi, vyplnuje se pole Kurz, Linka, Spoj, Smer, cas_jr
						BEGIN
							IF @Cislo_oznacniku <> @Oznacovnik -- aktualizace cisla oznacniku v pripade ze se lisi od prikazu (zaroven s poradim)
								BEGIN 
									PRINT 'oznacovnik (' + CAST(@Oznacovnik as varchar(10)) + ' > ' + CAST(@Cislo_oznacniku as varchar(10)) + ') / Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10))
									UPDATE dbo.vysledek_temp SET Poradi = @Poradi, Oznacovnik = @Cislo_oznacniku, Kurz = @NNS, Linka = @Linka, Spoj = @Spoj, Smer = @Smer, cas_jr = @Datum WHERE people = @Poradi-@gapcnt
								END
							ELSE -- aktualizace pouze poradi
								BEGIN
									PRINT 'stop in place / Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10)) + ' / cas '+CAST(@Datum as varchar(20))
									UPDATE dbo.vysledek_temp SET Poradi = @Poradi/*+@gapcnt*/, Kurz = @NNS, Linka = @Linka, Spoj = @Spoj, Smer = @Smer, cas_jr = @Datum WHERE people = @Poradi-@gapcnt
								END
						END
					ELSE IF @PrevSame = 1 -- vuz zastavil na zastavce vickrat, nez mel + obrana !!!!!!!!!!!!!!!!!!!!!!!!
						BEGIN
							PRINT 'mutliple stop // Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10)) + ''
							-- zjistit hodnoty predchoziho zaznamu
							SELECT @PrevKurz = Kurz, @PrevLinka = Linka, @PrevSpoj = Spoj, @PrevSmer = Smer, @PrevCasJR = cas_jr FROM dbo.vysledek_temp WHERE people=(@Poradi-@gapcnt-1)
							PRINT 'dbo.vysledek_temp SET Poradi = @Poradi, Kurz = @PrevKurz, Linka = @PrevLinka, Spoj = @PrevSpoj, Smer = @PrevSmer, cas_jr = @PrevCasJR WHERE people = '+CAST(@Poradi-@gapcnt as varchar(10))
							UPDATE dbo.vysledek_temp SET Poradi = @Poradi, Kurz = @PrevKurz, Linka = @PrevLinka, Spoj = @PrevSpoj, Smer = @PrevSmer, cas_jr = @PrevCasJR WHERE people = @Poradi-@gapcnt
							-- update stavajici zaznam
							SELECT @ID_Lokace=ID_Lokace, @Oznacovnik=Oznacovnik from dbo.vysledek_temp where people=(@Poradi-@gapcnt+1)
							SET @Poradi = @Poradi + 1
							IF @Cislo_zastavky = @ID_Lokace -- dalsi zastavka ve spravnem poradi
								BEGIN
									PRINT '++ stop in place / Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10)) + ' / station ' + @Nazev_zastavky + ' - ' + CAST(@Cislo_zastavky as varchar(10)) + '/' + CAST(@Cislo_oznacniku as varchar(10))
									PRINT 'UPDATE dbo.vysledek_temp SET Poradi = '+CAST(@Poradi as varchar(10))+', Oznacovnik = @Cislo_oznacniku, Kurz = @Kurz, Linka = @Linka, Spoj = @Spoj, Smer = @Smer, cas_jr = @Datum WHERE people = '+CAST(@Poradi-@gapcnt as varchar(10))
									UPDATE dbo.vysledek_temp SET Poradi = @Poradi, Oznacovnik = @Cislo_oznacniku, Kurz = @NNS, Linka = @Linka, Spoj = @Spoj, Smer = @Smer, cas_jr = @Datum WHERE people = @Poradi-@gapcnt
								END
							ELSE -- dalsi zastavka chybi, vkladani
								BEGIN
									--SET @gapcnt = @gapcnt + 1
									PRINT '++ new gap / inserting row Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10)) + ' - station name: ' + @Nazev_zastavky
									INSERT INTO dbo.vysledek_temp(Vehicle_Name,Lokace,ID_Lokace,Oznacovnik,Datum_prijezdu,Poradi,Kurz,Linka,Spoj,Smer,cas_jr)
									VALUES (@Vuz_cislo,@Nazev_zastavky,@Cislo_zastavky,@Cislo_oznacniku,@ND,@Poradi,@NNS,@Linka,@Spoj,@Smer,@Datum) --,@Poradi_lokace,
								END
							--UPDATE dbo.vysledek_temp SET Poradi = @Poradi + 1, Kurz = @Kurz, Linka = @Linka, Spoj = @Spoj, Smer = @Smer, cas_jr = @Datum WHERE people = @Poradi-@gapcnt
						END
					ELSE -- chybejici zastavka, vklada se cely radek z tabulky poradi zastavek
						BEGIN
							SET @gapcnt = @gapcnt + 1
							PRINT 'inserting new row / Poradi = ' + CAST(@Poradi+@gapcnt as varchar(10)) + '-' + CAST(@gapcnt as varchar(10)) + ' / station: ' + @Nazev_zastavky + ' - ' + CAST(@Cislo_zastavky as varchar(10)) + '/' + CAST(@Cislo_oznacniku as varchar(10))
							INSERT INTO dbo.vysledek_temp(Vehicle_Name,Lokace,ID_Lokace,Oznacovnik,Datum_prijezdu,Poradi,Kurz,Linka,Spoj,Smer,cas_jr)
							VALUES (@Vuz_cislo,@Nazev_zastavky,@Cislo_zastavky,@Cislo_oznacniku,@ND,@Poradi,@NNS,@Linka,@Spoj,@Smer,@Datum) --,@Poradi_lokace,
						END
					SET @Poradi = @Poradi + 1
					FETCH NEXT FROM C INTO @Vuz_cislo,@Kurz,@Linka,@Smer,@Poradi_lokace,@Nazev_zastavky,@Zkraceny_nazev_zastavky,@Cislo_zastavky,@Cislo_oznacniku,@Druh_provozu,@Prijezd,@Odjezd,@KodCile,@Nazev_sluzby,@Typ_den,@Datum,@tporad
				END
			CLOSE C
			DEALLOCATE C

			--- nutno smazat null hodnoty z vysledek_temp
			PRINT '------------------ Deleting null values from vysledek_temp: ------------------------------'
			-- DELETE FROM dbo.vysledek_temp WHERE cas_jr IS NULL

			--- nutno vynulovat people pole
			PRINT '------------------ Zeroing people values in vysledek_temp: ------------------------------'
			UPDATE dbo.vysledek_temp SET people = 0

			----------------------------------------------------------------------------------------------------------
			DECLARE @peoplenr int
			DECLARE @celkem int
			DECLARE @odjelotemp int
			DECLARE @poraditemp int
			DECLARE @updatenext int
			DECLARE @rowcount int
			DECLARE @vozovna int
			DECLARE @casjr time

			-- transferred from previous
			DECLARE @dat_prijezdu date
			DECLARE @cas_prijezdu time
			DECLARE @dat_odjezdu date
			DECLARE @cas_odjezdu time
			DECLARE @doba_zas time
			DECLARE @prijelo int
			DECLARE @nastoupilo int
			DECLARE @vystoupilo int
			DECLARE @odjelo int

			PRINT '--------------------------- vozovna idication ----------------------------------'
			DECLARE @predchozi_lokace int
			DECLARE @predchozi_oznacovnik int
			DECLARE @prebytek int
			DECLARE @zarovnano_prebytek int
			DECLARE @predchozi_odjelo int
			DECLARE @predchozi_prebytek int
			DECLARE @predchozi_nastoupilo int
			DECLARE @predchozi_poradi int
			DECLARE C CURSOR FOR SELECT * FROM dbo.vysledek_temp ORDER BY Poradi
			OPEN C
			FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @ID_Lokace=@predchozi_lokace AND @Oznacovnik=@predchozi_oznacovnik -- predchozi zaznam je stejny --> jedna se o vozovnu
						BEGIN
						-- zapsat do pole vozovna pocet prebyvajicich lidi
						PRINT @predchozi_odjelo
						PRINT @Nazev_zastavky+' / '+CAST(@nastoupilo as varchar(10))+'+'+CAST(@predchozi_odjelo as varchar(10))
						PRINT 'UPDATE dbo.vysledek_temp SET Nastoupilo='+CAST(@nastoupilo+@predchozi_odjelo as varchar(10))+', vozovna='+CAST(@predchozi_odjelo as varchar(10))+' WHERE Poradi = '+CAST(@poradi as varchar(10))
						--UPDATE dbo.vysledek_temp SET Nastoupilo=@nastoupilo+@predchozi_nastoupilo, vozovna=@predchozi_odjelo-@predchozi_nastoupilo WHERE Poradi = @poradi
						PRINT 'UPDATE dbo.vysledek_temp SET Nastoupilo=0 WHERE Poradi = '+CAST(@poradi-1 as varchar(10))
						--UPDATE dbo.vysledek_temp SET Nastoupilo=0 WHERE Poradi = @poradi-1
						END
					SET @predchozi_lokace = @ID_Lokace
					SET @predchozi_oznacovnik = @Oznacovnik
					SET @predchozi_nastoupilo = @nastoupilo
					SET @predchozi_odjelo = @odjelo
					FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
				END
			CLOSE C
			DEALLOCATE C
			--- zjisteni prebytecnych lidi na vozovnach
			/*PRINT '------------------ Determining extra people numbers: ------------------------------'
			
			-------------------- citace nahodnych cisel
			DECLARE @nahodne_cislo int
			DECLARE @horni_interval int
			DECLARE @spodni_interval int
			DECLARE @tempprijelo int
			DECLARE @tempnastoupilo int
			DECLARE @tempvystoupilo int
			DECLARE @tempodjelo int
			DECLARE @tempdatum date

			SET @rowcount = 0
			SET @predchozi_poradi = 1
			SET @predchozi_prebytek = 0
			SET @predchozi_lokace = 0
			SET @predchozi_oznacovnik = 0

			DECLARE C CURSOR FOR SELECT * FROM dbo.vysledek_temp ORDER BY Poradi
			OPEN C
			FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @ID_Lokace=@predchozi_lokace AND @Oznacovnik=@predchozi_oznacovnik -- predchozi zaznam je stejny --> jedna se o vozovnu
						BEGIN
						-- zapsat do pole vozovna pocet prebyvajicich lidi
						SET @prebytek = @predchozi_odjelo - @predchozi_prebytek
						PRINT '----------------------------------------------------------------------------------------'
						PRINT 'UPDATE dbo.vysledek SET vozovna = ' + CAST(@predchozi_prebytek as varchar(10)) + ' WHERE Poradi = ('  + CAST(@poradi as varchar(10)) + ' - 1)'
						UPDATE dbo.vysledek_temp SET vozovna = @prebytek WHERE Poradi = (@poradi - 1)
						-- nahodne priradit prebyvajici lidi z promenne @prebytek
						SET @spodni_interval = @predchozi_poradi          -- The lowest random number
						SET @horni_interval = @poradi - 1    -- The highest random number 
						SET @zarovnano_prebytek = 1    -- citac zarovnanych osob
						IF @prebytek > 0
							BEGIN
							WHILE @zarovnano_prebytek <= @prebytek
								BEGIN
									SET @nahodne_cislo = @spodni_interval + CONVERT(INT, (@horni_interval-@spodni_interval+1)*RAND())
									PRINT 'SELECT Datum_prijezdu FROM dbo.vysledek_temp WHERE Poradi = ' + CAST(@nahodne_cislo as varchar(10))
									SET @tempdatum = (SELECT Datum_prijezdu FROM dbo.vysledek_temp WHERE Poradi = @nahodne_cislo)
									SET @tempnastoupilo = (SELECT Nastoupilo FROM dbo.vysledek_temp WHERE Poradi = @nahodne_cislo)
									SET @tempvystoupilo = (SELECT Vystoupilo FROM dbo.vysledek_temp WHERE Poradi = @nahodne_cislo)
									PRINT 'trying random number ' + CAST(@nahodne_cislo as varchar(10)) + ' - random between ' + CAST(@spodni_interval as varchar(10)) + ' and ' + CAST(@horni_interval as varchar(10)) + ' datum prijezdu - ' --- + CAST(@tempdatum as varchar(10))
									IF @tempdatum IS NOT NULL AND @tempnastoupilo > @tempvystoupilo -- > (@prebytek/(@horni_interval-(@spodni_interval-1)))
										BEGIN
											PRINT 'Random between ' + CAST(@spodni_interval as varchar(10)) + ' and ' + CAST(@horni_interval as varchar(10)) + ' / distributing ' + CAST(@prebytek as varchar(10)) + ' people - now ' + CAST(@zarovnano_prebytek as varchar(10)) + '.'
											PRINT 'UPDATE dbo.vysledek SET people = people + 1 WHERE Poradi = '  + CAST(@nahodne_cislo as varchar(10)) 
											UPDATE dbo.vysledek_temp SET people = people + 1 WHERE Poradi = @nahodne_cislo
											SET @zarovnano_prebytek = @zarovnano_prebytek + 1
										END
								END
							END
						SET @predchozi_poradi = @poradi
						SET @predchozi_prebytek = @predchozi_prebytek + @prebytek
					END
					SET @rowcount = @rowcount + 1
					SET @predchozi_lokace = @ID_Lokace
					SET @predchozi_oznacovnik = @Oznacovnik
					SET @predchozi_odjelo = @odjelo
					FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
				END
			CLOSE C
			DEALLOCATE C*/

			-- prepocitani lidi dle novych hodnot (posuny o x pokud by vychazely zaporne hodnoty a dalsi sachinace)
			/*PRINT '**************************************************'
			DECLARE @rozdil int
			DECLARE @tempshift int
			DECLARE @tempshiftvalue int
			DECLARE @nastoupiloshiftvalue int
			DECLARE @nexttempshiftvalue int
			DECLARE @nextnastoupilo int
			DECLARE @nextvystoupilo int
			DECLARE @nextrozdil int
			SET @tempprijelo = 0
			SET @tempshift = 0
			SET @tempshiftvalue = 0
			SET @rowcount = 0
			SET @predchozi_poradi = 0
			SET @nastoupiloshiftvalue = 0

			DECLARE C CURSOR FOR SELECT * FROM dbo.vysledek_temp ORDER BY Poradi
			OPEN C
			FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @tempvystoupilo = @vystoupilo + @peoplenr
				SET @tempnastoupilo = @nastoupilo
				SET @tempodjelo = @tempprijelo + @tempnastoupilo - @tempvystoupilo
				--PRINT '--- Prijelo = ' + CAST(@prijelo as varchar(10)) + ', Nastoupilo = ' + CAST(@nastoupilo as varchar(10)) + ', Vystoupilo = ' + CAST(@vystoupilo as varchar(10)) + ', Odjelo = ' + CAST(@odjelo as varchar(10)) + ', navic ' + CAST(@peoplenr as varchar(10))
				IF @tempshift > 0 -- pokud doslo k nejakemu posunu
					BEGIN
						IF @tempodjelo >= 0 -- je to tim, ze v predchozim cyklu neslo odecist, tim padem zkusime odecitat nyni
							BEGIN
								--SET @rozdil = @nastoupilo - @vystoupilo - @peoplenr
								IF @rozdil > 0 -- jakmile to pujde, tak odecitame (pricitame k vystoupilo)
									BEGIN
										IF @nastoupiloshiftvalue + @tempshiftvalue < @rozdil -- pokud jsou pricitaci hodnoty nizsi nez rozdil, odecteme je veschny
											BEGIN 
												SET @nastoupiloshiftvalue = @nastoupiloshiftvalue + @tempshiftvalue
												SET @tempvystoupilo = @tempvystoupilo + @nastoupiloshiftvalue
												SET @tempodjelo = @tempprijelo + @tempnastoupilo - @tempvystoupilo
												PRINT CAST(@poradi as varchar(10)) + 'A. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) + ', (N - ' + CAST(@nastoupiloshiftvalue + @peoplenr as varchar(10)) + ')'
												UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
												SET @nastoupiloshiftvalue = 0
												SET @tempshiftvalue = 0
												SET @tempshift = 0
											END
										ELSE  -- pokud nejsou, tak pouze odecteme, kolik pujde a zustane zbytek
											BEGIN
												SET @tempvystoupilo = @tempvystoupilo + @nastoupiloshiftvalue + @tempshiftvalue
												SET @nastoupiloshiftvalue = @nastoupiloshiftvalue + @tempshiftvalue - @rozdil
												SET @tempodjelo = @tempprijelo + @tempnastoupilo - @tempvystoupilo
												PRINT CAST(@poradi as varchar(10)) + 'B. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) + ', (N - ' + CAST(@rozdil as varchar(10)) + ')'
												UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
												SET @tempshiftvalue = 0
												IF @nastoupiloshiftvalue < 1
													SET @tempshift = 0
											END
									END
								ELSE --3 jinak predavame dale
									BEGIN
										PRINT CAST(@poradi as varchar(10)) + '3. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) --+ ', ( ' + CAST(@dat_prijezdu as varchar(10)) + ')'
										UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
									END
							END
						ELSE -- anebo se dostavame odecty jeste vice do minusu, proto se pridalo do nastoupilo - a nyni podruhe
							BEGIN
								SET @rozdil = -1 * @tempodjelo
								SET @nastoupiloshiftvalue = @nastoupiloshiftvalue + @tempshiftvalue + @rozdil
								SET @tempshiftvalue = @peoplenr
								PRINT CAST(@poradi as varchar(10)) + '4. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo + @rozdil as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo + @rozdil as varchar(10)) + ', (N + ' + CAST(@rozdil as varchar(10)) + ')'
								UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo + @rozdil, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo + @rozdil WHERE Poradi = @poradi
								SET @tempodjelo = @tempodjelo + @rozdil
								--PRINT '4. UPDATE dbo.vysledek SET Prijelo = ' + CAST(@tempprijelo as varchar(10)) + ', Vystoupilo = ' + CAST(@tempvystoupilo as varchar(10)) + ', Odjelo = ' + CAST(@tempodjelo as varchar(10)) + ' WHERE Poradi = ' + CAST(@poradi as varchar(10))
							END
					END
				ELSE -- indikator nerovnomernosti neni zapnut
					BEGIN
						IF @tempodjelo < 0 AND @peoplenr > 0 --2 - dostali jsme se do minusu, ale muzeme posunout odecet cloveka na dalsi
							BEGIN
								SET @tempshift = 1
								SET @tempshiftvalue = @peoplenr
								SET @tempodjelo = @tempprijelo + @tempnastoupilo - @vystoupilo
								IF @tempodjelo < 0 -- pokud vsak jsme i presto v minusu
									BEGIN
										SET @nastoupiloshiftvalue = -1 * @tempodjelo
										SET @tempodjelo = @tempprijelo + @tempnastoupilo + @nastoupiloshiftvalue - @vystoupilo -- mela by byt 0
										PRINT CAST(@poradi as varchar(10)) + 'Y. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo + @nastoupiloshiftvalue as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) + ', (N + ' + CAST(@nastoupiloshiftvalue as varchar(10)) + ')'
										UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo + @nastoupiloshiftvalue, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
									END
								ELSE
									BEGIN
										PRINT CAST(@poradi as varchar(10)) + '2. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) --+ ', ( ' + CAST(@dat_prijezdu as varchar(10)) + ')'
										UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
										--PRINT '2. UPDATE dbo.vysledek SET Prijelo = ' + CAST(@tempprijelo as varchar(10)) + ', Odjelo = ' + CAST(@tempodjelo as varchar(10)) + ', people = 0 WHERE Poradi = ' + CAST(@poradi as varchar(10))
										--UPDATE dbo.vysledek SET Prijelo = @tempprijelo, Odjelo = @tempodjelo, people = 0 WHERE Poradi = @poradi
									END
							END
						ELSE IF @tempodjelo < 0 AND @peoplenr = 0 --X - dostali jsme se do minusu, musime zmenit nastoupilo
							BEGIN
								SET @tempshift = 1
								SET @nastoupiloshiftvalue = -1 * @tempodjelo
								SET @tempodjelo = @tempprijelo + @nastoupilo + @nastoupiloshiftvalue - @vystoupilo
								PRINT CAST(@poradi as varchar(10)) + 'X. --- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo + @nastoupiloshiftvalue as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) + ', (N + ' + CAST(@nastoupiloshiftvalue as varchar(10)) + ')'
								UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo + @nastoupiloshiftvalue, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
								--UPDATE dbo.vysledek SET Prijelo = @tempprijelo, Nastoupilo = Nastoupilo + @nastoupiloshiftvalue, Odjelo = @tempodjelo, people = 0 WHERE Poradi = @poradi
							END
						ELSE -- vse v poradku, pouze se provede bilance
							BEGIN
								PRINT CAST(@poradi as varchar(10)) + '--- P ' + CAST(@prijelo as varchar(10)) + ', N ' + CAST(@nastoupilo as varchar(10)) + ', V ' + CAST(@vystoupilo as varchar(10)) + ', O ' + CAST(@odjelo as varchar(10)) + ', ( -' + CAST(@peoplenr as varchar(10)) + ') /// P ' + CAST(@tempprijelo as varchar(10)) + ', N ' + CAST(@tempnastoupilo as varchar(10)) + ', V ' + CAST(@tempvystoupilo as varchar(10)) + ', O ' + CAST(@tempodjelo as varchar(10)) --+ ', ( ' + CAST(@dat_prijezdu as varchar(10)) + ')'
								UPDATE dbo.vysledek_temp SET Prijelo = @tempprijelo, Nastoupilo = @tempnastoupilo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
								--PRINT '1. UPDATE dbo.vysledek SET Prijelo = ' + CAST(@tempprijelo as varchar(10)) + ', Vystoupilo = ' + CAST(@tempvystoupilo as varchar(10)) + ', Odjelo = ' + CAST(@tempodjelo as varchar(10)) + ' WHERE Poradi = ' + CAST(@poradi as varchar(10))
								--UPDATE dbo.vysledek SET Prijelo = @tempprijelo, Vystoupilo = @tempvystoupilo, Odjelo = @tempodjelo WHERE Poradi = @poradi
							END
					END
				SET @tempprijelo = @tempodjelo
				SET @predchozi_poradi = @poradi
				FETCH NEXT FROM C INTO @Vuz_cislo, @Nazev_zastavky, @ID_Lokace, @Oznacovnik, @dat_prijezdu, @cas_prijezdu, @dat_odjezdu, @cas_odjezdu, @doba_zas, @prijelo, @nastoupilo, @vystoupilo, @odjelo, @poradi, @Kurz, @Linka, @Spoj, @Smer, @casjr, @peoplenr, @vozovna
			END
			CLOSE C
			DEALLOCATE C*/
			--- vyplneni chybejicich poctu lidi na zastavkach pro chybejici zastavky
			PRINT '------------------ Filling out missing people numbers: ------------------------------'
			SET @rowcount = 0
			SET @odjelotemp = 0

			DECLARE C CURSOR FOR SELECT * FROM dbo.vysledek_temp ORDER BY Poradi
			OPEN C
			FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
			WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT 'Zastavka ' + @Nazev_zastavky + ' (' + CAST(@ID_Lokace as varchar(10)) + ') Prijelo ' + CAST(@prijelo as varchar(10)) + ' / nastoupilo '+ CAST(@nastoupilo as varchar(10)) + ' / vystoupilo ' + CAST(@vystoupilo as varchar(10))
				SET @celkem = CAST(@prijelo as int) + CAST(@nastoupilo as int) - CAST(@vystoupilo as int)
				--PRINT @prijelo
				IF @celkem IS NULL -- pro zastavky, kde se nezastavuje se nastavuje hodnota predchoziho poctu lidi
					BEGIN
						PRINT 'Zastavka ' + @Nazev_zastavky + ' - ' + CAST(@ID_Lokace as varchar(10)) + ' - pocty lidi updatovany'
						UPDATE dbo.vysledek_temp SET Prijelo=@odjelotemp, Nastoupilo=0, Vystoupilo=0, Odjelo=@odjelotemp WHERE Poradi = @poradi
					END
				ELSE -- nacteni do promenych pocet lidi ve vozidle pro odjezdu a poradi zastavky
					BEGIN
						SET @odjelotemp = CAST(@odjelo as int)
						SET @poraditemp = @poradi
						--PRINT /*'Zastavka ' + @Nazev_zastavky +*/ 'Celkem ' + CAST(@celkem as varchar(10)) + ' lidi - prijelo ' + CAST(@prijelo as varchar(10)) + '/ nastoupilo ' + CAST(@nastoupilo as varchar(10)) + '/ vystoupilo ' + CAST(@vystoupilo as varchar(10)) 
					END
				SET @rowcount = @rowcount + 1
				FETCH NEXT FROM C INTO @Vuz_cislo,@Nazev_zastavky,@ID_Lokace,@Oznacovnik,@dat_prijezdu,@cas_prijezdu,@dat_odjezdu,@cas_odjezdu,@doba_zas,@prijelo,@nastoupilo,@vystoupilo,@odjelo,@poradi,@Kurz,@Linka,@Spoj,@Smer,@casjr,@peoplenr,@vozovna
			END
			CLOSE C
			DEALLOCATE C
			---------------------------------------------------------------------------------------------------------------
			INSERT INTO dbo.vysledek_final SELECT * FROM dbo.vysledek_temp

			SELECT @nrows = COUNT(Vehicle_Name) FROM dbo.vysledek_temp
			PRINT 'UPDATE @ListofRides SET fullrows='+CAST(@nrows as varchar(10))+' WHERE nid='+CAST(@nid as varchar(10))
			UPDATE @ListofRides SET fullrows=@nrows WHERE nid=@nid
			DELETE FROM dbo.vysledek_temp
	
		END
	select @nid = @nid + 1
END
PRINT '********************************* script end *********************************'
--select */*, ISNULL(t.Prijelo, (SELECT TOP 1 Odjelo FROM vysledek WHERE ID_Lokace < t.ID_Lokace AND Prijelo IS NOT NULL ORDER BY /*ID_Lokace*/ Poradi DESC ))*/ from vysledek_temp t /*WHERE Datum_prijezdu IS NULL*/ ORDER BY Poradi
SELECT * FROM @ListofRides ORDER BY NDen;
--SELECT * FROM dbo.vysledek_temp ORDER BY Poradi