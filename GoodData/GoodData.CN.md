# GoodData Cloud Native
The cloud-native analytics platform with a powerful engine, elegant interactive visualizations, and self-service tools.
[GoodData.CN - cloud native analytics platform | GoodData](https://www.gooddata.com/developers/cloud-native/)

Built to scale with microservices. Deployed in containers next to your data. Analytics calculations decoupled from user interactions. GoodData is the platform developers love. Because architecture matters.

- Auto-generated SQL
- Semantic Abstractions
- Built-in Multitenancy
- Drag&Drop Tools
- Advanced Embedding

[Documentation | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/#connect)

## Installation
[Deploy & Install | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/)

Docker way
[gooddata/gooddata-cn-ce - Docker Image | Docker Hub](https://hub.docker.com/r/gooddata/gooddata-cn-ce/)
``` 
docker pull gooddata/gooddata-cn-ce  
docker run -i -t -p 3000:3000 -p 5432:5432 -v gd-volume:/data gooddata/gooddata-cn-ce:latest
```


## Model Building
Scan physical model and build a semantic layer on top of the data.

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

