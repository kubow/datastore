[Modern Data Orchestrator Platform | Dagster](https://dagster.io/)

## Install
- [Running Dagster locally | Dagster Docs](https://docs.dagster.io/deployment/oss/deployment-options/running-dagster-locally)
- [dagster-dbt integration reference | Dagster Docs](https://docs.dagster.io/integrations/libraries/dbt/reference#loading-dbt-models-from-a-dbt-project)



## Running

```shell
dagster dev

```


## Project structure

- **demo/assets.py**: Computations and data units.
- **demo/definitions.py**: Orchestration configuration.
- **demo/schedules.py**: Job schedules and sensors.
- **demo/projects.py**: Project utils, config, helpers.
- **demo_tests/**: Test cases for Dagster components.
- **pyproject.toml**: Project metadata and dependencies.
- **setup.py**: Installation and distribution instructions.