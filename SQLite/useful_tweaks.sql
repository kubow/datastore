
--Attach another database
ATTACH DATABASE file_name AS database_name;
-- Conditionals
CASE WHEN key='value1' THEN 'something' WHEN key='value2' THEN 'somethingelse'
--Single quote
cast(X'27' as text)
--Double quote
cast(X'22' as text)
--Capitalize First letter 
SELECT Czech, UPPER(SUBSTR(Czech,1,1)) || LOWER(SUBSTR(Czech,2,LENGTH(Czech))) AS Rest FROM seznam;
UPDATE seznam SET Czech=UPPER(SUBSTR(Czech,1,1)) || LOWER(SUBSTR(Czech,2,LENGTH(Czech)));
--Injection
--http://atta.cked.me/home/sqlite3injectioncheatsheet