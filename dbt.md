[What is dbt? (getdbt.com)](https://www.getdbt.com/product/what-is-dbt/)
- transformation workflow that compiles and runs your analytics code against your data platform.
- modularize and centralize your analytics code
- provide data team with guardrails
- collaborate on data models

[dbt-labs/metricflow: MetricFlow allows you to define, build, and maintain metrics in code.](https://github.com/dbt-labs/metricflow)
[GitHub - elementary-data/elementary: The dbt-native data observability solution for data & analytics engineers. Monitor your data pipelines in minutes. Available as self-hosted or cloud service with premium features.](https://github.com/elementary-data/elementary)

### dbt in pipeline

- each run collect 3 files (manifest.json, ..)
- parse it
- store


[dbt Cloud (getdbt.com)](https://cloud.getdbt.com/login/)

[Stronger together: Python, dataframes, and SQL | dbt Developer Blog (getdbt.com)](https://docs.getdbt.com/blog/polyglot-dbt-python-dataframes-sql?utm_content=225361991&utm_medium=social&utm_source=linkedin&hss_channel=lcp-10893210)

[DBT: A new way to transform data and build pipelines](https://medium.com/the-telegraph-engineering/dbt-a-new-way-to-handle-data-transformation-at-the-telegraph-868ce3964eb4)

```shell
pip install dbt-core
dbt init --profile-dir dbt_demo/
dbt debug  # validate all set up properly
dbt compile  # check renderring (target folder)
dbt build
dbt docs generate
dbt docs serve
```

## Project Folder Structure

- **dbt_project.yml**: Configuration file for your project.
- **~/.dbt/profiles.yml**: Database connection settings.
- **sources.yml**: Preexisting views or tables.
- **schema.yml**: Where dbt models are created.
- **models/**: Transformation models (SQL files).
- **seeds/**: Files to be loaded as tables.
- **macros/**: Reusable SQL macros.
- **tests/**: Tests for data validation and integrity.
- **analysis/**: Optional analytical queries for exploration.
- **logs/**: Run logs for debugging.
- **target/**: Compiled SQL and results of runs.


Practical tips
https://medium.com/photobox-technology-product-and-design/practical-tips-to-get-the-best-out-of-data-building-tool-dbt-part-1-8cfa21ef97c5
https://medium.com/photobox-technology-product-and-design/practical-tips-to-get-the-best-out-of-data-build-tool-dbt-part-2-a3581c76723c
https://medium.com/photobox-technology-product-and-design/practical-tips-to-get-the-best-out-of-data-build-tool-dbt-part-3-38cefad40e59
