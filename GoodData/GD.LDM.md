Logical Data Model / Semantic Model

- the data model that is optimized for analytical use
- very simplified data model, that maps on underlying datasource

[Create a Logical Data Model | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/model-data/create-logical-data-model/)



API request
```shell
curl $HOST_URL/api/v1/actions/dataSources/demo-ds/generateLogicalModel \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "Authorization: Bearer $API_TOKEN" \
-X POST \
-d '{
    "separator": "__", 
    "viewPrefix": "mtt", 
    "grainPrefix": "gr", 
    "secondaryLabelPrefix": "ls", 
    "referencePrefix": "r"
    }' \
| jq . > ldm.json
```