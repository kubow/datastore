## Install

[PostgreSQL: Downloads](https://www.postgresql.org/download/)

[PostgreSQL 16: hodně malých vylepšení a optimalizací - Root.cz](https://www.root.cz/clanky/postgresql-16-hodne-malych-vylepseni-a-optimalizaci/?utm_source=rss&utm_medium=text&utm_campaign=rss)

[Install on Ubuntu 22](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart)
[How to download and install PostgreSQL (Windows)](https://commandprompt.com/education/how-to-download-and-install-postgresql/)


[Configure postgreSQL for the first time](https://stackoverflow.com/questions/1471571/how-to-configure-postgresql-for-the-first-time)
[database - How to login and authenticate to Postgresql after a fresh install? - Stack Overflow](https://stackoverflow.com/questions/2172569/how-to-login-and-authenticate-to-postgresql-after-a-fresh-install)


```bash
# check if running
pgrep -u postgres -fa -- -D
# connect to the deault database (after fresh installation)
sudo -u postgres psql template1
# at the psql command line
ALTER USER postgres with encrypted password 'xxxxxxx';
# restart the service
sudo /etc/init.d/postgresql restart
psql -U postgres -c 'SHOW config_file'  # get location of your config files
```

Inside the psql console
- [Find the hostname and port](https://stackoverflow.com/questions/5598517/find-the-host-name-and-port-using-psql-commands)
- 


### Upgrade

[Public Schema Security Upgrade in PostgreSQL 15](https://www.percona.com/blog/public-schema-security-upgrade-in-postgresql-15/)


### Clients

[Most popular PostgreSQL GUIs in 2022: the (almost) scientific list](https://blog.forestadmin.com/best-postgres-gui/)
