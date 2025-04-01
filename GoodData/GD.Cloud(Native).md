# GoodData Cloud (Panther) / Cloud Native (TIGER)

The analytics platform with a powerful engine, elegant interactive visualizations, and self-service tools. Built to scale with microservices. Deployed in containers next to your data. Analytics calculations decoupled from user interactions. GoodData is the platform developers love.
[GoodData.CN - cloud native analytics platform | GoodData](https://www.gooddata.com/developers/cloud-native/)

Cloud Native is Cloud with different hosting option

### Features

| **Main**                                                                                                 | **Versioning systems** | **Authentification**                |
| -------------------------------------------------------------------------------------------------------- | ---------------------- | ----------------------------------- |
| Auto-generated SQL                                                                                       | GitHub                 | Auth0                               |
| Semantic Abstractions                                                                                    | GitLab                 | Google                              |
| Built-in Multitenancy                                                                                    |                        | Okta                                |
| Drag&Drop Tools                                                                                          |                        |                                     |
| Advanced Embedding [>](https://www.gooddata.com/developers/cloud-native/doc/cloud/embed-visualizations/) |                        | \* anything that is SAML compatible |

[Documentation | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/#connect)

GD.CN parts:
- **Analytics Engine** (MAQL)
	- gRPC (inter process communication), Apache Pulsar for messaging
	- JDBC for integration with internal metadata database + customer databases
	- Platform implementation: Kotlin laguage (JVM) + SpringBoot & Gradle to build microservices
- **Metadata layer** (LDM + calculations)
	- In future Quiver replaces Redis (internal developped based on Apache Arrow)
- **Declarative API** (REST API - [OpenAPI Specification - Version 3.0.3 | Swagger](https://swagger.io/specification/#))
	- Entities - CRUD on each metadata entity
		- /api/vX/entites
		- JSON:API standard, slightly customized
		- in-house built metadata-lib, endpoints generated
	- Declarative - full get/replace of complex entities
		- /api/vX/layout
	- Actions - RPC calls (scan data source, execute report)
		- /api/vX/actions
- **UI apps** (self-service analytics)
	- extendable via UI.SDK (React.js) - common for BEAR and TIGER
	- pythonSDK

## Installation

[Deploy & Install | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/):
- Public Cloud services
- [Kubernetes](https://kubernetes.io/) (GD.CN Production version)
	- [HELM](https://helm.sh/) (Kubernetes packagemanager) 
- Docker (community) [GD.CN Image @ Docker Hub](https://hub.docker.com/r/gooddata/gooddata-cn-ce/), [Install GD.CN](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/community-edition/)

Under the hood :
- Nginx
- Redis 6.0.16 (00000000/0) 64 bit
- PostgreSQL 13.8 (Debian 13.8-0+deb11u1) on x86_64-pc-linux-gnu
- Spring Boot (v2.6.9) runs services:
	- Auth Service :: HTTP port = 9050/9051
	- Result Cache :: HTTP port = 9040/9041
	- Metadata :: HTTP port = 9007/9008
	- Calcique :: HTTP port = 9011/9012 ([Apache Calcite](../Apache/Apache%20Calcite.md) clone)
	- SQL executor :: HTTP port = 9100/9101
	- AFM Exec API :: HTTP port = 9000/9001
	- Scan Model :: HTTP port = 9060/9061


### Installing pre-built image

Links found in [Installation](#installation) under Docker point.

```bash
# kubernetes way

# docker way
docker pull gooddata/gooddata-cn-ce:latest
docker run -i -t -p 3000:3000 -p 5300:5300 -v gd-volume:/data gooddata/gooddata-cn-ce:latest  # --name find out why not work
docker images --digests
```

### Installing UI.SDK (React.js) application

https://github.com/gooddata/gooddata-create-gooddata-react-app

```bash
npx @gooddata/create-gooddata-react-app my-app --backend tiger  #GD.Cloud / GD.CN on localhost
#? What is your hostname? <Use your domain URL> / <GD.CN endpoint incl. protocol, typically http://localhost:3000/>
#? What is your application's desired flavor? JavaScript / Typescript
cd my-app
# install packages (yarn automatically) # yarn start # not at this point - we need first
export TIGER_API_TOKEN="" # a value obtained from /settings/personal access token
yarn refresh-md
yarn start # npm start
```

For common React.js modifications follow [[GD.UI|this link]].

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


## Caching

Cache = stored results (precompted, compressed, .... point in time) = staorage costs ... only around 2-3% size of raw data
The more real-time you got the less caching happens

- Report executed for the first time:
	- request executed ? is in cache
	- request processed 
	- result is cached
	- result sent to client
- The same report is executed again:
	- request executed ? is in cache
	- result sent to client

[Cache Management | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/connect-data/cache-management/)

Beta: [Enable Pre-aggregation Caching | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/connect-data/cache-management/enable-pre-aggregation-caching/)
Dremio: Bug with caching? still there

Preaggregation Tables - inside datasource maintained by SQL query (optional - by default turned off)
Raw Results - without sorting
Final Results - with sorting