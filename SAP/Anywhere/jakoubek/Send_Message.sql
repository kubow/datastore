-- Procedure Send_Message
-- send a string to the user's console (iSQL) and the server log
-- useful for outputting debug infos from other procedures
IF EXISTS(SELECT * FROM sys.sysprocedure WHERE proc_name = 'Send_Message') THEN DROP PROCEDURE dba.Send_Message END IF;

CREATE PROCEDURE dba.Send_Message(IN par_string VARCHAR(128))
BEGIN
  DECLARE ls_text VARCHAR(128);

  SET ls_text = db_name() || '-' || STRING(par_string,' (',CONVERT(VARCHAR(12), NOW(*), 8), ' ', DATEFORMAT(CURRENT DATE,'DD.MM.YYYY'), ')');

  MESSAGE ls_text TYPE INFO TO CLIENT;
  MESSAGE ls_text TO CONSOLE;

END;