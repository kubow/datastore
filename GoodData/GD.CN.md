# GoodData Cloud Native (TIGER)

The cloud-native analytics platform with a powerful engine, elegant interactive visualizations, and self-service tools.
[GoodData.CN - cloud native analytics platform | GoodData](https://www.gooddata.com/developers/cloud-native/)

Built to scale with microservices. Deployed in containers next to your data. Analytics calculations decoupled from user interactions. GoodData is the platform developers love. Because architecture matters.

- Auto-generated SQL
- Semantic Abstractions
- Built-in Multitenancy
- Drag&Drop Tools
- Advanced Embedding

[Documentation | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/#connect)

GD.CN parts:
- Analytics Engine (MAQL)
- Metadata layer (LDM + calculations)
- Declarative APIs
- UI apps (self-service analytics)
Versioning system:
- Github
- Gitlab

- REST API (OpenAPI 3.0 specification)
	- Entities - CRUDon each metadata entity
		- /api/vX/entites
		- JSON:API standard, slightly customized
		- in-house built metadata-lib, endpoints generated
	- Declarative - full get/replace of complex entities
		- /api/vX/layout
	- Actions - RPC calls (scan data source, execute report)
		- /api/vX/actions
- gRPC (inter process communication), Apache Pulsar for messaging
- JDBC for integration with internal metadata database + customer databases

Platform microservices implemented with:
- Kotlin laguage (JVM) + SpringBoot
- Gradle used to build microservices

In future replaces Redis with Quiver (internal developped based on Apache Arrow)

#### SDK

https://www.gooddata.com/developers/cloud-native/doc/cloud/

pythonSDK
UI.SDK (Javascript) - common from BEAR and TIGER


## Installation

[Deploy & Install | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/):
- Public Cloud services
- [Kubernetes](https://kubernetes.io/) (GD.CN Production version)
	- [HELM](https://helm.sh/) (Kubernetes packagemanager) 
- Docker (community) [GD.CN Image @ Docker Hub](https://hub.docker.com/r/gooddata/gooddata-cn-ce/), [Install GD.CN](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/community-edition/)

Under the hood:
- Nginx
- Redis 6.0.16 (00000000/0) 64 bit
- PostgreSQL 13.8 (Debian 13.8-0+deb11u1) on x86_64-pc-linux-gnu
- Spring Boot (v2.6.9) runs services:
	- Auth Service :: HTTP port = 9050/9051
	- Result Cache :: HTTP port = 9040/9041
	- Metadata :: HTTP port = 9007/9008
	- Calcique :: HTTP port = 9011/9012 (Apache Calcite clone)
	- SQL executor :: HTTP port = 9100/9101
	- AFM Exec API :: HTTP port = 9000/9001
	- Scan Model :: HTTP port = 9060/9061



```bash
# kubernetes way

# docker way
docker pull gooddata/gooddata-cn-ce:latest
docker run -i -t -p 3000:3000 -p 5300:5300 -v gd-volume:/data gooddata/gooddata-cn-ce:latest  # --name find out why not work
docker images --digests
```


### Security

Authentifications:
- Auth0
- Google
- Okta


## Model Building

Scan physical model and build a semantic layer on top of the data.

![[GD_CloudNative_ModelData.png]]
[Model Data](https://www.gooddata.com/developers/cloud-native/doc/2.1/model-data/)
[Build LDM](https://www.gooddata.com/developers/cloud-native/doc/2.1/getting-started/build-ldm/)


```
{  
  "data": {  
    "attributes": {  
      "name": "prod-db",  
      "url": "jdbc:postgresql://localhost:5432/prod",  
      "schema": "public",  
      "type": "POSTGRESQL"  
    },  
    "id": "prod-ds",  
    "type": "data-source"  
  }  
}
```

# Data Analysis
Choose the right visualization for your metric calculation and execute your first analytics insight.

- Calculation way:
```
-- Active Users:  
SELECT COUNT(User) WHERE User Status = "Active"  
-- Montly Active Users:  
SELECT Active Users BY Month  
-- Average MAU:  
SELECT AVG(Monthly Active Users)
```
- Visualization way (through the visual interface)
- React code way:
```
import "@gooddata/sdk-ui-charts/styles/css/main.css";  
import { ColumnChart } from "@gooddata/sdk-ui-charts";  
import { Ldm } from "./ldm";  
  
const style = { height: 300 };  
  
<div style={style}>  
    <ColumnChart  
        measures={[Ldm.$AverageMAU]}  
        viewBy={Ldm.DateYear}  
    />  
</div>
```

[GoodData Python SDK](https://www.gooddata.com/developers/cloud-native/doc/cloud/api-and-sdk/python-sdk/)
[GoodData Python SDK Documentation](https://gooddata-sdk.readthedocs.io/en/latest/)
