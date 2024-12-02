--This procedure takes all materialized views in your database and refreshes them at once.

IF EXISTS(SELECT * FROM sys.sysprocedure WHERE proc_name = 'RefreshMaterializedViews') THEN DROP PROCEDURE dba.RefreshMaterializedViews END IF;

CREATE PROCEDURE dba.RefreshMaterializedViews()
BEGIN

    DECLARE ls_newline CHAR(2);
    DECLARE li_i INTEGER;
    DECLARE ai_error INTEGER;
    DECLARE ls_view_name VARCHAR(100);
    DECLARE ls_owner_name VARCHAR(100);
    DECLARE sql LONG VARCHAR;

    DECLARE LOCAL TEMPORARY TABLE lt_views (
        table_id                INTEGER,
        table_name              VARCHAR(100),
        owner_name              VARCHAR(100),
        PRIMARY KEY (table_id)
    );

    SET ls_newline = CHAR(13) || CHAR(10);
    SET li_i = 0;

    -- insert materialized views into temp table
    INSERT INTO lt_views ( table_id, table_name, owner_name )
    SELECT  table_id, TRIM(table_name), u.name
    FROM    systable AS t
            INNER JOIN
            sysusers AS u
            ON u.uid = t.creator
    WHERE   table_type = 'MAT VIEW'
    ORDER BY table_name;

    -- loop
    WHILE EXISTS(SELECT * FROM lt_views) LOOP

        SET li_i = li_i + 1;
        SELECT FIRST table_name, owner_name INTO ls_view_name, ls_owner_name FROM lt_views;

        IF ls_view_name <> '' THEN

            -- only if proc send_message exists ...
            -- CALL send_message('View name: ' || ls_owner_name || '.' || ls_view_name);

            SET sql = sql || 'REFRESH MATERIALIZED VIEW ' || ls_owner_name || '.' || ls_view_name || ';' || ls_newline;

            SET ai_error = SQLCODE;
            IF ai_error = 0 THEN
                DELETE FROM lt_views WHERE table_name = ls_view_name
                    AND owner_name = ls_owner_name;
            END IF;

        END IF;

        SET ls_view_name = '';

    END LOOP;

    -- now execute the complete SQL
    EXECUTE IMMEDIATE WITH QUOTES sql;

    -- drop temp table
    DROP TABLE lt_views;

END;

GRANT EXECUTE ON dba.RefreshMaterializedViews TO wawi