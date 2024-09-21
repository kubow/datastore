
- LDAP: Can operate as password store or a user directory with users and roles
- Certificate-Based Auth: ClickHouse supports mTLS with authentication via client X509 certs
- Kerberos: Can authenticate users
- Compression Codecs (LZ4, ZTSD, ...)

## Security Settings

- `/etc/clickhouse-server/` default config location
	- `config.xml` default file
	- `users.xml` (default user has no password!)
	- `users.d/xml_user.xml` user definition
	- `config.d/user_directories.xml` for LDAP
- `/etc/clickhouse-keeper/keeper_config.xml` for replication
- manually connect XML file using `--config-file=` or `-C`.
- `/var/lib/clickhouse/access/file.sql/` current SQL commands
- [Users and Roles Settings | ClickHouse Docs](https://clickhouse.com/docs/en/operations/settings/settings-users)
- **RBAC**: Role-Based Access Control (XML User Management = no roles)
	- XML users in local storage (less feature rich but developer friendly)
	- Replicated users in [ClickHouse Keeper](https://clickhouse.com/docs/en/guides/sre/keeper/clickhouse-keeper)
	- Kubernetes deployments can use XML / RBAC combinations
	- Use `ON CLUSTER` clause to define RBAC in clusters

[![](https://mermaid.ink/img/pako:eNp9kcFOwzAMhl8l8olJ2wv0gNRR4IQ0NrjQcLAat41o48lxQGjbuxPWaQc2kVP-fF_sKN5Bw46ggHbgr6ZHUfNS2WDyKusNqfrQRbMSbv1A72axuN2XMXLjUckZ5b1Z1mvOaLpzVz8nVjyK5sKcnOpmJf4zl-sozibxUTD8sZaX5L5-jSSnTtUVPpGH_95wcsrrEOYwkozoXf6R3a9qQXsayUKRtw7lw4INh-xhUt58hwaKFodIcxBOXX9Oaety2cpjJzieT7cY3phzVkk5kvPK8jQN4DiHww84l4JA?type=png)](https://mermaid.live/edit#pako:eNp9kcFOwzAMhl8l8olJ2wv0gNRR4IQ0NrjQcLAat41o48lxQGjbuxPWaQc2kVP-fF_sKN5Bw46ggHbgr6ZHUfNS2WDyKusNqfrQRbMSbv1A72axuN2XMXLjUckZ5b1Z1mvOaLpzVz8nVjyK5sKcnOpmJf4zl-sozibxUTD8sZaX5L5-jSSnTtUVPpGH_95wcsrrEOYwkozoXf6R3a9qQXsayUKRtw7lw4INh-xhUt58hwaKFodIcxBOXX9Oaety2cpjJzieT7cY3phzVkk5kvPK8jQN4DiHww84l4JA)

## Create Profiles

- XML [Settings Profiles | ClickHouse Docs](https://clickhouse.com/docs/en/operations/settings/settings-profiles)
- [CREATE SETTINGS PROFILE | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/statements/create/settings-profile)

```sql
CREATE SETTINGS PROFILE IF NOT EXISTS u2_profile
SETTINGS
	max_threads = 2 MIN 1 MAX 4
	max_memory_usage = 10000000 MIN 1000000 MAX 200000000
READONLY;
```

## Create Roles

```sql
CREATE ROLE IF NOT EXISTS u2_role
	SETTINGS PROFILE 'u2_profile';

REVOKE ALL FROM u2_role;

GRANT SHOW DATABASES ON system.* TO u2_role;
GRANT SELECT ON system.* TO u2_role;

CREATE QUOTA IF NOT EXISTS u2_quota
FOR INTERVAL 30 second
	MAX queries 5,
	MAX result_rows 1000000
TO u2_role
```

- Quotas for Queries, Inserts, Selects, Errors, Results, Reads and Execution time
- [CREATE ROW POLICY | ClickHouse Docs](https://clickhouse.com/docs/en/sql-reference/statements/create/row-policy#docusaurus_skipToContent_fallback) (to enforce Rules)

## Creating Users

[Goodbye XML, Hello SQL! ClickHouse User Management Goes Pro | Altinity](https://altinity.com/blog/goodbye-xml-hello-sql-clickhouse-user-management-goes-pro)

### SQL User Management

```sql
-- BASIC
CREATE USER IF NOT EXISTS name1
    IDENTIFIED WITH sha256_password BY 'topsecret'
    HOST LOCAL -- OR ANY
    SETTINGS PROFILE 'default';
    -- DEFAULT ROLE u2_role

-- ON A CLUSTER
CREATE USER IF NOT EXISTS name1
    ON CLUSTER '{cluster}' -- IMPORTANT
    IDENTIFIED WITH sha256_password BY 'topsecret'
    HOST LOCAL
    SETTINGS PROFILE 'default';

-- where is my user?
select currentUser()
```

### old-school using XML

- [How to make clickhouse take new users.xml file? - Stack Overflow](https://stackoverflow.com/questions/45062749/how-to-make-clickhouse-take-new-users-xml-file)
- [ClickHouse/programs/server/users.xml at master · ClickHouse/ClickHouse](https://github.com/ClickHouse/ClickHouse/blob/master/programs/server/users.xml)

```xml
<users>  
	<!-- If user name was not specified, 'default' user is used. -->  
	<user_name>  
		<password></password>  
		<!-- Or -->  
		<password_sha256_hex></password_sha256_hex>  
		  
		<ssh_keys>  
			<ssh_key>  
				<type>ssh-ed25519</type>  
				<base64_key>..</base64_key>  
			</ssh_key>  
		</ssh_keys>   
		
		<access_management>0|1</access_management>  
		<networks incl="networks" replace="replace">  
		</networks>  
		  
		<profile>profile_name</profile>  
		  
		<quota>default</quota>  
		<default_database>default</default_database>  
		<databases>  
			<database_name>  
				<table_name>  
					<filter>expression</filter>  <!-- row policy --> 
				</table_name>  
			</database_name>  
		</databases>  
		<!-- Xou can grant privileges directly to users --> 
		<grants>  
			<query>GRANT SELECT ON system.*</query>  
		</grants>  
	</user_name>  
<!-- Other users settings -->  
</users>
```

## Passwords

### Hashed password

```shell
PASSWORD=$(base64 < /dev/urandom | head -c8); \
echo "$PASSWORD"; \
echo -n "$PASSWORD" | sha256sum | tr -d '-' 
TPo6F7vT
# continued hash....
clickhouse-connect --user=u_sha256 --password=TPo6F7vT
```

