-- encode integers into a short and easy to read string

CREATE OR REPLACE FUNCTION dba.RecordLocatorEncode(IN par_number INTEGER)
RETURNS VARCHAR(10)
BEGIN

    DECLARE li_number INTEGER;
    DECLARE ls_result VARCHAR(10);

    DECLARE LOCAL TEMPORARY TABLE assign(
        id INTEGER DEFAULT AUTOINCREMENT,
        keynumber integer,
        stringvalue char(1) NULL,
        PRIMARY KEY (id)
    );

    SET li_number = par_number;

    WHILE li_number > 0 LOOP
        INSERT INTO assign ( keynumber ) VALUES ( MOD(li_number, 32) );
        SET li_number = ROUND(li_number/32, 0);
    END LOOP;

    UPDATE assign
    SET stringvalue = (CASE keynumber
        WHEN 0 THEN '2'
        WHEN 1 THEN '3'
        WHEN 2 THEN '4'
        WHEN 3 THEN '5'
        WHEN 4 THEN '6'
        WHEN 5 THEN '7'
        WHEN 6 THEN '8'
        WHEN 7 THEN '9'
        WHEN 8 THEN 'A'
        WHEN 9 THEN 'C'
        WHEN 10 THEN 'D'
        WHEN 11 THEN 'E'
        WHEN 12 THEN 'F'
        WHEN 13 THEN 'G'
        WHEN 14 THEN 'H'
        WHEN 15 THEN 'I'
        WHEN 16 THEN 'J'
        WHEN 17 THEN 'K'
        WHEN 18 THEN 'L'
        WHEN 19 THEN 'M'
        WHEN 20 THEN 'N'
        WHEN 21 THEN 'O'
        WHEN 22 THEN 'P'
        WHEN 23 THEN 'Q'
        WHEN 24 THEN 'R'
        WHEN 25 THEN 'T'
        WHEN 26 THEN 'U'
        WHEN 27 THEN 'V'
        WHEN 28 THEN 'W'
        WHEN 29 THEN 'X'
        WHEN 30 THEN 'Y'
        WHEN 31 THEN 'Z'
        END
    );

    SELECT LIST(stringvalue, '' ORDER BY id DESC) INTO ls_result
    FROM assign;

    RETURN ls_result;

    DROP TABLE assign;

END;