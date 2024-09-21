
Altinity Operator sets up ClickHouse from CHI resource definitions

- ClickHouse Installation Resource `kubectl -f apply demo.yaml`
- kube-system namespace (docker image)
- favorite namespace (Replicas and Load Balancer)

You can transfer passwords using Kubernetes secrets

[ClickHouse® Confidential: Using Kubernetes Secrets with the Altinity Operator - Altinity | Run open source ClickHouse® better](https://altinity.com/blog/clickhouse-confidential-using-kubernetes-secrets-with-the-altinity-operator)

```yaml
apiVersion: "clickhouse.altinity.com/v1" 
kind: "ClickHouseInstallation" 
metadata: 
	name: "secure" 
spec: 
	configuration: 
		users: 
			default/password_sha256: "5333…7a721" 
			root/networks/ip: "::/0" 
			root/password_sha256: "5333…7a721" 
			root/profile: "default" 
			root/access_management: 1 
		clusters: 
			#Etc.
```