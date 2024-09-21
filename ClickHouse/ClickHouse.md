https://clickhouse.com/
Column oriented DBMS for OLAP + Real-Time analytics created originally by Yandex (now open sourced under Apache 2.0, also as a [Cloud service](./Clickhouse%20Cloud.md))
- designed to handle large volumes of data at high speed. 
- uses columnar storage and data compression techniques to optimize query performance
- distributed architecture that allows it to scale horizontally, making it well-suited for big data applications.
- Runs on bare metal to cloud / Shared nothing architecture
- Parallel and vectorized execution

Main product parts:
- [System](./ClickHouse%201%20System.md)
- [Installation](./ClickHouse%202%20Install.md)
- [Maintenance](./ClickHouse%203%20Maintenance.md)

Extra parts
- [Altinity](./ClickHouse.Altinity.md): Deployments Manager
- [SQL Dialect](./ClickHouse.SQL.md)
- [Clients](./ClickHouse.Client.md)

![[ClickHouse overview.png]]


[Working with Time Series Data in ClickHouse](https://clickhouse.com/blog/working-with-time-series-data-and-functions-ClickHouse)

Uber replaced Elasticsearch with ClickHouse for logging, a good primary key could be a compound key like PRIMARY KEY(log_level, ..., timestamp)

Companies using ClickHouse for logs:
- Cloudflare: [https://blog.cloudflare.com/log-analytics-using-clickhouse/](https://blog.cloudflare.com/log-analytics-using-clickhouse/)
- Uber: [https://www.uber.com/blog/logging/](https://www.uber.com/blog/logging/)
- Ebay: [https://tech.ebayinc.com/engineering/ou-online-analytical-processing](https://tech.ebayinc.com/engineering/ou-online-analytical-processing/)