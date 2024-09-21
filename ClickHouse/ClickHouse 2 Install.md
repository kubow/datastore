
[ClickHouse Quick Start | ClickHouse Docs](https://clickhouse.com/docs/en/getting-started/quick-start)
or more extensive
[Install ClickHouse | ClickHouse Docs](https://clickhouse.com/docs/en/install)

```shell
curl https://clickhouse.com/ | sh
sudo ./clickhouse install
cd /etc/clickhouse-server # config files
sudo clickhouse start  # start clickhouse server
clickhouse-client
cat /var/log/clickhouse-server/clickhouse-server.err.log  # browse errorlog
```

