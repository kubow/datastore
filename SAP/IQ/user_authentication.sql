--Configure PAM on your Linux or UNIX system. For this example, assume a PAM service name PamRule.2.
--Add the PAM value to the LOGIN_MODE database option:
SET OPTION PUBLIC.login_mode = PAMUA3.
--Create a login policy that assigns values to pam_servicename and (optionally) pam_failover_to_std:
CREATE LOGIN POLICY pam_policy
pam_servicename = PamRule
pam_failover_to_std = ON4.
--Assign the login policy to the users of PAMUA:
ALTER USER pam_userID LOGIN POLICY pam_policy
--Verify that users can log on using PAM user authentication:
dbping –c
'uid=pam_userID;pwd=<pam_user_password>;links=tcpip(host=iq_server;port=6263);eng=IQdb'
–d