# GoodData Cloud Native
The cloud-native analytics platform with a powerful engine, elegant interactive visualizations, and self-service tools.
[GoodData.CN - cloud native analytics platform | GoodData](https://www.gooddata.com/developers/cloud-native/)

Built to scale with microservices. Deployed in containers next to your data. Analytics calculations decoupled from user interactions. GoodData is the platform developers love. Because architecture matters.

- Auto-generated SQL
- Semantic Abstractions
- Built-in Multitenancy
- Drag&Drop Tools
- Advanced Embedding

[GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/)

## Installation
[Deploy & Install | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/deploy-and-install/)

Docker way
[gooddata/gooddata-cn-ce - Docker Image | Docker Hub](https://hub.docker.com/r/gooddata/gooddata-cn-ce/)

docker pull gooddata/gooddata-cn-ce  
docker run -i -t -p 3000:3000 -p 5432:5432 -v gd-volume:/data gooddata/gooddata-cn-ce:latest

## Model Building
Scan physical model and build a semantic layer on top of the data.
