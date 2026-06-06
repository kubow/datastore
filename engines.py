import sqlite3
from pathlib import Path

ENGINE_FILES = {
    "Airbyte/Airbyte.md": "Airbyte",
    "Amazon/AWS Athena.md": "Athena",
    "Amazon/AWS Aurora.md": "Amazon Aurora",
    "Amazon/AWS DynamoDB.md": "DynamoDB",
    "Amazon/AWS Glue.md": "AWS Glue",
    "Amazon/AWS RedShift.md": "Redshift",
    "Amazon/AWS S3.md": "S3",
    "Apache/Apache Beam.md": "Apache Beam",
    "Apache/Apache Cassandra.md": "Cassandra",
    "Apache/Apache CouchDB.md": "CouchDB",
    "Apache/Apache Derby.md": "Derby",
    "Apache/Apache Doris.md": "Apache Doris",
    "Apache/Apache Drill.md": "Drill",
    "Apache/Apache Druid.md": "Druid",
    "Apache/Apache Flink.md": "Apache Flink",
    "Apache/Apache HBase.md": "HBase",
    "Apache/Apache Hadoop.md": "Apache Hadoop",
    "Apache/Apache Hive.md": "Hive",
    "Apache/Apache Hudi.md": "Apache Hudi",
    "Apache/Apache Iceberg.md": "Apache Iceberg",
    "Apache/Apache Kafka.md": "Apache Kafka",
    "Apache/Apache Kudu.md": "Kudu",
    "Apache/Apache NiFi.md": "Apache NiFi",
    "Apache/Apache Paimon.md": "Apache Paimon",
    "Apache/Apache Parquet.md": "Apache Parquet",
    "Apache/Apache Pinot.md": "Pinot",
    "Apache/Apache Presto.md": "Presto",
    "Apache/Apache Pulsar.md": "Apache Pulsar",
    "Apache/Apache Solr.md": "Apache Solr",
    "Apache/Apache Spark.md": "Apache Spark",
    "AutoMQ.md": "AutoMQ",
    "ClickHouse/ClickHouse.md": "ClickHouse",
    "CockroachDB/CockroachDB.md": "CockroachDB",
    "Couchbase/Couchbase.md": "Couchbase",
    "CrateDB/CrateDB.md": "CrateDB",
    "Databricks/Databricks.md": "Databricks",
    "DeltaLake/Delta Lake.md": "Delta Lake",
    "Dremio/Dremio.md": "Dremio",
    "Duck/DuckDB.md": "DuckDB",
    "Elasticsearch/Elasticsearch.md": "Elasticsearch",
    "Exasol/Exasol.md": "Exasol",
    "Fivetran/Fivetran.md": "Fivetran",
    "Google/Google BigQuery.md": "BigQuery",
    "Google/Google Cloud Spanner.md": "Cloud Spanner",
    "Google/Google Dataflow.md": "Dataflow",
    "Google/Google Firestore.md": "Firestore",
    "IBM/DB2.md": "DB2",
    "InfluxDB/InfluxDB.md": "InfluxDB",
    "MS/MS Azure Cosmos DB.md": "Cosmos DB",
    "MS/MS Azure Data Factory.md": "Azure Data Factory",
    "MS/MS Azure SQL.md": "Azure SQL Database",
    "MS/MS Azure Synapse.md": "Azure Synapse Analytics",
    "MS/Access/MS Access.md": "Access",
    "MS/SQLServ/Microsoft SQL Server.md": "Microsoft SQL Server",
    "MariaDB/MariaDB.md": "MariaDB",
    "MarkLogic/MarkLogic.md": "MarkLogic",
    "Milvus/Milvus.md": "Milvus",
    "Minio/Minio.md": "MinIO",
    "MongoDB/MongoDB.md": "MongoDB",
    "Neo4J/Neo4J.md": "Neo4j",
    "OpenSearch/OpenSearch.md": "OpenSearch",
    "Oracle/MySQL.md": "MySQL",
    "Oracle/Oracle BerkeleyDB.md": "BerkeleyDB",
    "Oracle/Oracle Database.md": "Oracle Database",
    "PostgreSQL/GreenPlum.md": "Greenplum",
    "PostgreSQL/PostgreSQL.md": "PostgreSQL",
    "Prefect/Prefect.md": "Prefect",
    "Prometheus/Prometheus.md": "Prometheus",
    "Qdrant/Qdrant.md": "Qdrant",
    "QuestDB/QuestDB.md": "QuestDB",
    "REDIS/Redis.md": "Redis",
    "SAP/ASE/SAP ASE.md": "Adaptive Server Enterprise",
    "SAP/Anywhere/SQL Anywhere.md": "SQL Anywhere",
    "SAP/HANA/SAP HANA.md": "SAP HANA",
    "SAP/IQ/SAP IQ.md": "SAP IQ",
    "SQLite/RQLite.md": "rqlite",
    "SQLite/SQLite.md": "SQLite",
    "ScyllaDB/ScyllaDB.md": "ScyllaDB",
    "SingleStore/SingleStore.md": "SingleStore",
    "Snowflake/Snowflake.md": "Snowflake",
    "StarRocks/StarRocks.md": "StarRocks",
    "TDEngine/TDEngine.md": "TDengine",
    "Temporal/Temporal.md": "Temporal",
    "Teradata/Teradata.md": "Teradata Vantage",
    "TigerBeetle.md": "TigerBeetle",
    "TimescaleDB/TimescaleDB.md": "TimescaleDB",
    "Trino/Trino.md": "Trino",
    "Vertica/Vertica.md": "Vertica",
    "Weaviate/Weaviate.md": "Weaviate",
    "dbt.md": "dbt",
}

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('engines.db')
cursor = conn.cursor()

# Create a table to store markdown filenames
cursor.execute('''
CREATE TABLE IF NOT EXISTS files (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    filename TEXT UNIQUE,
    product_name TEXT
)
''')
conn.commit()

def sync_engine_files(directory):
    """Keep files limited to curated storage and processing engine notes."""
    missing_files = [
        filename for filename in ENGINE_FILES
        if not (Path(directory) / filename).exists()
    ]
    if missing_files:
        raise FileNotFoundError(f"Missing engine note files: {missing_files}")

    existing_engines = {row[0] for row in cursor.execute('SELECT ename FROM engines')}
    missing_engines = sorted(set(ENGINE_FILES.values()) - existing_engines)
    if missing_engines:
        raise ValueError(f"Missing engines for note files: {missing_engines}")

    cursor.execute('DELETE FROM files')
    cursor.executemany(
        'INSERT INTO files (filename, product_name) VALUES (?, ?)',
        ENGINE_FILES.items(),
    )
    conn.commit()


sync_engine_files('.')

# Close the database connection
conn.close()
