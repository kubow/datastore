-- Exchange rate client for SAP SQL Anywhere
-- Oliver Jakoubek <info@jakoubek.net>, April 2019
-- https://github.com/jakoubek/sqlanywhere-exchangerateclient


-- create the table *exchange_rate*
DROP TABLE IF EXISTS exchange_rate;

CREATE TABLE exchange_rate (
    id                  INTEGER PRIMARY KEY DEFAULT AUTOINCREMENT,
    cur_date            DATE DEFAULT CURRENT DATE,
    cur_exchange_rate   DOUBLE,
    updated_at          TIMESTAMP DEFAULT CURRENT TIMESTAMP
);


-- create the web client function
CREATE OR REPLACE FUNCTION webclient_get_exchange_rate(IN apikey CHAR(32), IN curreny CHAR(3))
RETURNS LONG VARCHAR
    URL 'http://apilayer.net/api/live?access_key=!apikey&currencies=!curreny'
    TYPE 'HTTP:GET'
    HEADER 'User-Agent:SATest'
    CERTIFICATE 'file=*';


-- create the main procedure
CREATE OR REPLACE PROCEDURE fetch_exchange_rate()
BEGIN

    -- adjust these two settings
    DECLARE ls_api_key CHAR(32) = 'Your32CharApiKeyFromCurrencylaye';
    DECLARE ls_currency CHAR(3) = 'CHF';

    DECLARE ls_api_response_json LONG VARCHAR;
    DECLARE ld_exchange_rate DOUBLE;

    SELECT webclient_get_exchange_rate(ls_api_key, ls_currency) INTO ls_api_response_json;

    CALL sp_parse_json('@jsonval', ls_api_response_json);

    IF (@jsonval).success = 1 THEN

        -- optionally change name of key element to currency (i.e. USDEUR)
        SELECT (@jsonval).quotes.USDCHF INTO ld_exchange_rate;

        IF EXISTS(SELECT 1 FROM exchange_rate WHERE cur_date = CURRENT DATE) THEN
            UPDATE exchange_rate SET cur_exchange_rate = ld_exchange_rate, updated_at = CURRENT TIMESTAMP;
        ELSE
            INSERT INTO exchange_rate ( cur_exchange_rate ) VALUES ( ld_exchange_rate );
        END IF;

    ELSE
        MESSAGE 'API call returned an error' TO CONSOLE;

    END IF;

    DROP VARIABLE IF EXISTS @jsonval;

END;


-- create event for time-controlled launch
DROP EVENT IF EXISTS "dba"."ExchangeRateFetcher";

CREATE EVENT "dba"."ExchangeRateFetcher"
SCHEDULE "Schedule_Daily" START TIME '14:00' EVERY 24 HOURS ON ( 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' )
START DATE '2019-04-01'
DISABLE
HANDLER
BEGIN

    CALL fetch_exchange_rate();

END;
COMMENT ON EVENT "dba"."ExchangeRateFetcher" IS 'Fetches the current exchange rate for the given currency and saves in the table exchange_rate.';