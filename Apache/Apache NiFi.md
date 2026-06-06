# Apache NiFi

Flow-based data movement and automation tool for routing, transforming, and managing data flows.

https://nifi.apache.org/

## Position

- Data integration and flow automation.
- More operational and flow-oriented than [Airflow](./Apache%20Airflow.md), [Dagster](../dagster.md), or [Prefect](../Prefect/Prefect.md).
- Often used near the ingestion edge, where systems, files, APIs, queues, and databases need controlled movement.

## Notes

- Visual flow design with processors and queues.
- Built-in back pressure, prioritization, provenance, and retry behavior.
- Good fit for ingestion, routing, lightweight transformation, and controlled handoff into Kafka, object storage, or databases.

