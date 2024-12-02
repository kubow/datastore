/* Filename:    FormatNumber.sql
 * Author  :    Oliver Jakoubek <info@jakoubek.net>, 2019-05-02
 * Purpose :    Formats a number as a German currency value in SAP SQL Anywhere
 *              2 decimal places, comma as decimal delimiter, points as thousand delimiter, NO currency
 * Usage   :    -
 * Output  :    -
 */

IF EXISTS(SELECT * FROM sys.sysprocedure WHERE proc_name = 'FormatNumber') THEN DROP PROCEDURE dba.FormatNumber END IF;

CREATE FUNCTION dba.FormatNumber(par_value VARCHAR(100), par_decimalplaces INTEGER DEFAULT 2)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN

  DECLARE formatted_number VARCHAR(100);
  DECLARE i INTEGER;
  DECLARE j INTEGER;

  IF ISNUMERIC(par_value) = 0 THEN
    RETURN NULL;
  END IF;

  IF par_decimalplaces < 0 THEN
    SET par_decimalplaces = 0;
  END IF;

  SET par_value = STR(par_value, 100, par_decimalplaces);
  SET par_value = TRIM(par_value);

  SET i = LENGTH(par_value);
  SET j = 0;

  WHILE i > 0 LOOP
    SET formatted_number = SUBSTR(par_value, i, 1) || formatted_number;
    IF (LOCATE(formatted_number, '.') > 0) OR (LOCATE(par_value, '.') = 0) THEN
      IF SUBSTR(par_value, i, 1) <> '.' THEN
        SET j = j + 1;
      END IF;
    END IF;
    IF (j = 3) AND (i > 1) THEN
      SET formatted_number = ',' || formatted_number;
      SET j = 0;
    END IF;
    SET i = i - 1;
  END LOOP;

  SET formatted_number = REPLACE(formatted_number, '.', '|');
  SET formatted_number = REPLACE(formatted_number, ',', '.');
  SET formatted_number = REPLACE(formatted_number, '|', ',');

  RETURN formatted_number;

END;

GRANT EXECUTE ON dba.FormatNumber TO dba