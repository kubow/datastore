# Temporal

Durable execution platform for long-running workflows and reliable application orchestration.

https://temporal.io/

## Position

- Workflow engine, not a database or analytics engine.
- Complements data orchestrators such as [Airflow](../Apache/Apache%20Airflow.md), [Dagster](../dagster.md), [Kestra](../Kestra/kestra.md), and [Prefect](../Prefect/Prefect.md).
- Strong when workflows are business/application processes with retries, timers, compensation, and durable state.

## Notes

- Workflows are written in general-purpose languages.
- Provides durable timers, retries, signals, queries, and task queues.
- Useful for orchestration that must survive process failure without custom state machines.

