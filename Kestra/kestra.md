[Kestra, Open Source Declarative Data Orchestration](https://kestra.io/)


## Initialize

```shell
docker run --pull=always --rm -it -p 8080:8080 --user=root \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v /tmp:/tmp kestra/kestra:latest-full server local
```

Alternative - go to this directory and run

```shell
docker compose up
```

## Connecting

- [DataGrip | MotherDuck Docs](https://motherduck.com/docs/integrations/sql-ides/datagrip/)
- [DBeaver | MotherDuck Docs](https://motherduck.com/docs/integrations/sql-ides/dbeaver/)

