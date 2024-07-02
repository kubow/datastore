[Meltano: Extract & Load with joy](https://meltano.com/)

```python
pip install meltano
meltano init my-meltano-project
# 1. / add the extractor
meltano explore extractor
meltano add extractor tap-csv
meltano invoke tap-csv --discover  # verify data ingesting works fine
meltano config tap-csv  # verify configuration
meltano select tap-github --list --all  # select what to extract
# 2. / add the loader
meltano add loader target-snowflake
meltano invoke target-snowflake --initialize
```

Examples
[Extract csv data and load it to PostgreSQL using Meltano ELT - DEV Community](https://dev.to/zompro/extract-csv-data-and-load-it-to-postgresql-using-meltano-elt-4ipf)

