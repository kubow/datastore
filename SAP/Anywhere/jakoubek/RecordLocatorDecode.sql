--decode integers into a short and easy to read string

CREATE OR REPLACE FUNCTION dba.RecordLocatorDecode(IN par_recordlocator VARCHAR(10))
RETURNS INTEGER
BEGIN

    DECLARE li_i INTEGER;
    DECLARE ls_char CHAR(1);
    DECLARE li_number INTEGER;

    DECLARE LOCAL TEMPORARY TABLE assign(
        id INTEGER DEFAULT AUTOINCREMENT,
        stringvalue char(1),
        keynumber integer NULL,
        PRIMARY KEY (id)
    );

    SET li_number = 0;
    SET li_i = 0;

    WHILE li_i < LENGTH(par_recordlocator) LOOP
        SET li_i = li_i + 1;
        SET ls_char = SUBSTRING(par_recordlocator, li_i, 1);
        INSERT INTO assign ( stringvalue ) VALUES ( ls_char );
    END LOOP;

    UPDATE assign
    SET     keynumber = (CASE stringvalue
        WHEN '0' THEN 21
        WHEN '1' THEN 15
        WHEN 'S' THEN 12
        WHEN 'B' THEN 22
        WHEN '2' THEN 0
        WHEN '3' THEN 1
        WHEN '4' THEN 2
        WHEN '5' THEN 3
        WHEN '6' THEN 4
        WHEN '7' THEN 5
        WHEN '8' THEN 6
        WHEN '9' THEN 7
        WHEN 'A' THEN 8
        WHEN 'C' THEN 9
        WHEN 'D' THEN 10
        WHEN 'E' THEN 11
        WHEN 'F' THEN 12
        WHEN 'G' THEN 13
        WHEN 'H' THEN 14
        WHEN 'I' THEN 15
        WHEN 'J' THEN 16
        WHEN 'K' THEN 17
        WHEN 'L' THEN 18
        WHEN 'M' THEN 19
        WHEN 'N' THEN 20
        WHEN 'O' THEN 21
        WHEN 'P' THEN 22
        WHEN 'Q' THEN 23
        WHEN 'R' THEN 24
        WHEN 'T' THEN 25
        WHEN 'U' THEN 26
        WHEN 'V' THEN 27
        WHEN 'W' THEN 28
        WHEN 'X' THEN 29
        WHEN 'Y' THEN 30
        WHEN 'Z' THEN 31
        END
    );

    FOR elementLoop AS element
    CURSOR FOR
        SELECT keynumber FROM assign ORDER BY id
    DO
        SET li_number = (li_number * 32) + keynumber; 
    END FOR;

    RETURN li_number;

    DROP TABLE assign;

END;