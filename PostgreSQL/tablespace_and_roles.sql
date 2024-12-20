CREATE ROLE "LeakMonitorUsers"
  NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE "LeakMonitorApp" LOGIN
  ENCRYPTED PASSWORD 'md508e785ba9ea839b366ea8af261d883bd'
  NOSUPERUSER NOINHERIT CREATEDB NOCREATEROLE;

CREATE ROLE "LeakMonitorUser1" LOGIN
  ENCRYPTED PASSWORD 'md5773d627f36f2e53b7b9162e505254bb2'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
GRANT "LeakMonitorUsers" TO "LeakMonitorUser1";

CREATE TABLESPACE leak_monitor_ts
  OWNER "LeakMonitorApp"
  LOCATION 'c:/Postgre_data/pg_tblspc';
COMMENT ON TABLESPACE leak_monitor_ts IS 'Tablespace for Leakage Monitor database';