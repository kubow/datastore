# SAC Security Concepts

[SAP Analytics Cloud – Security Concepts and Best Practice | SAP Blogs](https://blogs.sap.com/2019/06/21/sap-analytics-cloud-security-concepts-and-best-practice/)
[SAP Analytics Cloud - Security Concepts and Best Practice - SAP Analytics Cloud - Community Wiki](https://wiki.scn.sap.com/wiki/display/BOC/SAP+Analytics+Cloud+-+Security+Concepts+and+Best+Practice)
[SAP Analytics Cloud for Planning: a few – no longer kept – secrets about Security | SAP Blogs](https://blogs.sap.com/2021/04/22/sap-analytics-cloud-for-planning-a-few-no-longer-kept-secrets-about-security/)
[Explaining Security (sap.com)](https://learning.sap.com/learning-journey/explore-sap-analytics-cloud/explaining-security)

3 main concepts:

- HTTPS
- CORS
- SAML

Data Import requres these components to be installaed inside customer network:

- Cloud Connector (only one if connecting through SAP BPC NW or OData)
- SAP Analytics Cloud Agent (to connect various on-premise sources with JDBC driver)

Data security is defined on a Model level.

## Live Connections Workflow

[SAP Analytics Cloud - Live Connection and Security - Best Practices - SAP Analytics Cloud - Community Wiki](https://wiki.scn.sap.com/wiki/display/BOC/SAP+Analytics+Cloud+-+Live+Connection+and+security+-+Best+Practices)
[Creating SAP Analytics Cloud Live Connection to SAP HANA Database on SAP Cloud Platform | SAP Blogs](https://blogs.sap.com/2017/12/29/creating-sap-analytics-cloud-live-connection-to-sap-hana-database-on-sap-cloud-platform/)
[Live Data Connection Overview Diagram | SAP Help Portal](https://help.sap.com/docs/SAP_ANALYTICS_CLOUD/00f68c2e08b941f081002fd3691d86a7/5b4dad4d97664c41ae63bf1153e5e91e.html?locale=en-US)
[2653326 - Connecting to Live data does not work from the SAP Analytics Cloud mobile app](https://userapps.support.sap.com/sap/support/knowledge/en/2653326)


## SAML Workflow

[SAML authentication in SAP Analytics Cloud | SAP Blogs](https://blogs.sap.com/2017/07/13/saml-authentication-in-sap-analytics-cloud/)
[SAP Analytics cloud SAML SSO with BTP Cloud Identity services – Identity Authentication End to End From SAP Analytics cloud to the Live BW system | SAP Blogs](https://blogs.sap.com/2021/07/19/sap-analytics-cloud-saml-sso-with-btp-cloud-identity-services-identity-authentication-end-to-end-from-sap-analytics-cloud-to-the-live-bw-system/)
[Single Sign On (SSO) in SAP Analytics Cloud using SAML - Visual BI Solutions](https://visualbi.com/blogs/sap/sap-analytics-cloud/single-sign-sso-sap-analytics-cloud-using-saml/)
[2571892 - How to configure SAP Analytics Cloud SAML SSO using Azure Active Directory Services](https://userapps.support.sap.com/sap/support/knowledge/en/2571892)

## CORS related

[2482807 - SAP Analytics Cloud Live connections requiring a Secure HTTPS Browser configuration with CORS enabled](https://userapps.support.sap.com/sap/support/knowledge/en/2482807)

## Security Rights
[SAP Analytics Cloud – Roles & Access Management | SAP Blogs](https://blogs.sap.com/2020/03/15/sap-analytics-cloud-roles-access-management/)
[SAP Analytics Cloud - Security Rights - SAP Analytics Cloud - Community Wiki](https://wiki.scn.sap.com/wiki/display/BOC/SAP+Analytics+Cloud+-+Security+Rights)

SAP Analytics Cloud uses the user management and authentication mechanisms provided with SAP Cloud Identity Management.

There are three basic ways of creating users in the system. Creating users via SCIM API's and Dynamic User Creation using custom SAML IDP, manual, and by importing from a file.

- Users
- Roles
- Teams

### Pre-delivered standard application roles

- System Owner (superadmin full privileges, only one assigned to this role)
- Admin (full privileges, access all functional areas, data read access)
- Modeller (full access to all models and dimensions)
- Planner/Reporter (data access granted separately)
- Viewer (planning read only, cannot change anything)
- BI Admin (full privileges, can access all functional areas, data read access)
- BI Connector Creator (can create BI content and models)
- BI Content Viewer (BI read only, cannot change anything)
- SAP BTP Content Creator (access to SAP BTP as a datasource)
- SAP BTP Content Viewer
- Boardroom Creator
- Boardroom Viewer

### Teams in SAC

You can also control access to information using teams.

- A team is a group of users.
- A user can belong to multiple teams.
- If a role is assigned to a team, then all the members of the team inherit that role.
- Each team has a team folder, which can only be accessed by the users in that team.

### Assigning Roles to Teams

You can indirectly assign the role to the users by assigning the role to a team. You can do the following in any order:

- Assign users to teams.
- Assign roles to teams.

### Controlling acces to Stories

Administrators can define who has what type of access to SAC stories and related elements.

- **Catalog Access** (Supplemental use case)
	- Publish stories to catalogs by team
	- Users have view access (assuming a BI creator role)
- **Bookmarks** (supplemental shareable)
	- View, edit, full | teams and/or users
	- Private vs. global
- **Sharing** (Ad-hoc use case)
	- Share stories with a user or a team
	- Acess: view, edit, full
- **Folder Access** (main use case)
	- Create a folder in the public area
	- Share the folder with a user or a team
	- The assigned user/team has access to stories & related models in their folder
	- If the folder is shared vith VIEW access, users cannot edit the story
	- If the folder is shared vith EDIT access, users can edit the story

## Workspaces

Workspaces are virtual spaces that an SAP Analytics Cloud administrator can set up to mimic your organization's departments, lines of business, regional structure, or any other organizational setup. Workspaces let you organize content for access by different teams of users, and they can share and collaborate on content within the confines of the workspace.

Workspace administrators can use the workspace management tool to create, manage, or delete new workspaces. Because the workspace is essentially a partition of the SAC file repository, the content and administration of the workspace can be customized for a smaller group of SAC users without adjusting the overall content and administration for the entire SAC tenant. For example, workspaces can be created in which departments can create their own data models and stories that no other SAC user can access.

If users are assigned to workspaces, they will be prompted to choose My Files or their assigned workspace when creating models and stories. If a workspace is deleted, all of the content will be deleted and cannot be recovered. However, the ability to delete a workspace is tightly controlled.

- Users in a workspace can share content
- Content developer can collaborate
- Content for production is moved to the public folder