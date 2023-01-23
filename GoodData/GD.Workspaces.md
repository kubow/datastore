is an environment (endpoint, bucket or previously called project) where you build analytics (organize, analyze and present data).

[Workspace | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/manage-deployment/concepts/workspace/)
[Workspace and User Administration - Gooddata Enterprise](https://help.gooddata.com/doc/enterprise/en/workspace-and-user-administration)


can be created via UI:
[Create a Workspace | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/getting-started/create-workspace/)

alternatively using python SDK:
```python
from gooddata_sdk import GoodDataSdk, CatalogWorkspace

host = "<GOODDATA_URI>"
token = "<API_TOKEN>"
sdk = GoodDataSdk.create(host, token)

# Create new workspace entity locally
my_workspace_object = CatalogWorkspace("demo", name="demo")
# Create workspace
sdk.catalog_workspace.create_or_update(my_workspace_object)
```

or by using an API:
```shell
curl $HOST_URL/api/v1/entities/workspaces \
  -H "Content-Type: application/vnd.gooddata.api+json" \
  -H "Accept: application/vnd.gooddata.api+json" \
  -H "Authorization: Bearer <API_TOKEN>" \
  -X POST \
  -d '{
      "data": {
          "attributes": {
              "description": "My first workspace created using the API.",
              "name": "demo"
          },
          "id": "demo",
          "type": "workspace"
      }
  }' | jq .
```