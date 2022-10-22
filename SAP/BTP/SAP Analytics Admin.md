# SAC Administration tasks

[SAP Analytics Cloud - Official Product Tutorials - SAP Analytics Cloud - Support Wiki](https://wiki.scn.sap.com/wiki/display/BOC/SAP+Analytics+Cloud+-+Official+Product+Tutorials#SAPAnalyticsCloudOfficialProductTutorials-GettingStarted)
[SAP Analytics Cloud – Administration Cockpit | SAP Blogs](https://blogs.sap.com/2021/11/19/sap-analytics-cloud-administration-cockpit/)

[SAP Analytics Cloud for planning : our implementation best advices | SAP Blogs](https://blogs.sap.com/2021/07/27/sap-analytics-cloud-for-planning-our-implementation-best-advices/)

Administration tasks of SAP Analytics Cloud include:

- File Management
- Content Management
- Monitoring and Auditing
- User Management and Security

### Managing Files and Folders

Stories, input forms, boardroom agendas, sample content, and other content, such as uploaded files, can all be accessed from the Files page. The Files page displays your private files (files that are not shared with other users), plus folders for public files and input forms. Create folders to organize your files. You can upload Microsoft Office, text, CSV, and PDF files. Permissions can be defined on files when sharing.
The owner has full permissions.
To share files and folders that you have created, grant the following permissions (note that some permissions apply only to folders):

- Read
- Update
- Create files
- Create folders
- Maintain
- Delete
- Share


### Content Management

Importing and Exporting Content as Files

In Deployment, you can create and manage exports and imports of content using .tgz files. You can use these files to copy your objects between tenants.

### Content Deployment Guidelines

SAP Analytics Cloud supports easy export and import of content to and from a file.

If there are dependencies between content, the dependent content is automatically selected (it can be deselected), unless it is a location dimension if you have geo-enrichment in your model. This location dimension must be manually selected.

Only public content can be exported.

An export created from a tenant on SAP Analytics Cloud version X can only be imported into another SAP Analytics Cloud tenant on version X or version X+1. The is no backward compatibility.

In a development tenant, choose New Export.

Select objects for export, remembering that object selection has automatic dependency. For example, if you select a model for export, all its perspectives will be selected automatically.

Choose whether data (master data for perspective, transaction data for the model) shall be exported.

Choose Export, and choose Export to Local File.

**Restrictions for Exporting Data as a CSV File**

The following limitations apply to table exports that have the scope set to all and to chart exports:

- Maximum number of columns: 60.
- Maximum number of cells of data: 3 million.
- Any filters applied to the chart are applied to the data export.
- The export does not contain information on which filters or datasources are used.
- Formatting (such as cell color, font styles, and so on) will not be exported.
- Hyperlinks are removed.
- Hierarchies are flattened.

Note

It is not recommended to use exports to archive content. Content can only be imported in the same version of the application from which it was exported, or the subsequent version. After your system is upgraded again, you cannot import the content.

## Performance
[Monitor System Usage | SAP Help Portal](https://help.sap.com/docs/SAP_ANALYTICS_CLOUD/00f68c2e08b941f081002fd3691d86a7/58ae68146c6d4ba19105ed89a63b0189.html?locale=en-US)
[2511489 - Troubleshooting performance issues in SAP Analytics Cloud (Collective KBA) - SAP ONE Support Launchpad](https://launchpad.support.sap.com/#/notes/2511489/E)
[Performance Best Practices and Troubleshooting | SAP Analytics Cloud | SAP Community](https://community.sap.com/topics/cloud-analytics/best-practices-troubleshooting#performance-best-practices)

Recent Action-triggered Performance Improvements:

- Progressive Chart Rendering
- Optimized Story Building Performance
- Reduce Model Metadfata (hiding unnecessary Dimensions & Measures)
- Browser Caching for Story and Boardroom
- Unrestricted Drilling when applied filters (Time Range Widget Filters)
- Optimized Table Format

Blogs
[SAP Analytics Cloud Performance Analysis Tool | SAP Blogs](https://blogs.sap.com/2021/01/08/sap-analytics-cloud-performance-analysis-tool/)
[SAP Analytics Cloud Network Statistics | SAP Blogs](https://blogs.sap.com/2020/12/10/sap-analytics-cloud-network-statistics/)
[SAP Analytics Cloud Backend Runtime Analysis and Statistics | SAP Blogs](https://blogs.sap.com/2020/07/21/sap-analytics-cloud-backend-runtime-analysis-and-statistics/)
[SAP Analytics Cloud Performance Statistics and Analysis | SAP Blogs](https://blogs.sap.com/2020/09/24/performance-statistics-and-analysis/)
[SAP Analytics Cloud Data Action Performance Statistics and Analysis | SAP Blogs](https://blogs.sap.com/2021/04/13/sap-analytics-cloud-data-action-performance-statistics-and-analysis/)
[Webinar Series: Performance best practices and troubleshooting tips for SAP Analytics Cloud | SAP Blogs](https://blogs.sap.com/2021/08/12/webinar-series-performance-best-practices-and-troubleshooting-tips-for-sap-analytics-cloud/)
[Experience Performance and Usability Improvements with SAP Analytics Cloud Stories | SAP Blogs](https://blogs.sap.com/2021/07/26/experience-performance-and-usability-improvements-with-sap-analytics-cloud-stories/)

Videos
[Best Practices for SAP Analytics Cloud Backend and Analytics Designer Performance (on24.com)](https://event.on24.com/eventRegistration/EventLobbyServletV2?target=reg20V2.jsp&eventid=3344624&sessionid=1&key=9B85CAF4A865D92D4C6319FE0077AF51&groupId=2768380&partnerref=KBA&sourcepage=register)
[Improving your SAP Analytics Cloud Stories Performance and Usability](https://event.on24.com/eventRegistration/EventLobbyServlet?target=reg20.jsp&referrer=&eventid=3289938&sessionid=1&key=ACCBCBEB3485D015EA99CCF80105C8C5&regTag=&V2=false&sourcepage=register)
[SAP Analytics Cloud - Critical Capabilities and Features - YouTube](https://www.youtube.com/watch?v=IiFGpE4tssw&t=1379s) (performance monitoring in action)


## Monitoring and Auditing

- Model -> Preferences
- Security -> Data Changes

SAP Analytics Cloud logs all activities users perform on business objects, for example, making changes to a model. The contents of an audit log tell you who did what and when, allowing tracking of user activity. This audit log does not replace the trace feature, which can log system errors.
In addition, SAP Analytics Cloud can log failed attempts to create, delete, and change objects in the following situations:

- Missing authorization
- Disallowed or invalid change
- Viewing activity log data

The data changes feature can optionally track the planning process down to the values changed. Unlike the audit log, this must be specifically requested, because it involves more storage.

### Monitoring Reports

You can use the monitoring reports and data available to monitor the real-time statistics and usage of the system. Let’s use the SAC Content Usage story to monitor performance. The SAC Content Usage story can be activated from Content Network → Sample.
The story contains four tabs:

- Story Information
- Model Information
- User Information
- Session Information

To install a copy of the SAC Content Usage story, you need to install the **SAP Analytics Cloud Usage Tracking Content** package in SAP Analytics Cloud.
The SAP Analytics Cloud Usage Tracking Content package contains four models and one story. The models cover the domains of users, files, other objects and activities. They are connected to your system and provide specific information about your tenant.

- SAC Usage Activities
	- Information about user's activities within SAC (System -> Activities table)
- SAC Usage Files
	- Information about objects from the Files area of SAC.
	- Can be linked to the Activities model using **Obecjt ID** dimension.
	- It can be also linked to the Users model using the **Created By User ID** dimension.
- SAC Usage Other Objects
	- Additional information about files and other object types including dependencies.
	- Can be linked to the Activities model using the **Object ID** dimension.
	- It can be also linked to the Users model using the **Created By User ID** dimension.
- SAC Usage Users
	- Information about users, roles and teams within SAC.
	- Can be linked to the Activities model using the **User ID** dimension.
- SAC Usage Sessions
	- Information about sessions in SAC.
	- Can be linked to the Activities model using the **Session ID** dimension.

The SAP Analytics Cloud Usage Tracking Content package resides in the Content Library of the Files area. To access the Content Library, your user will need a role that has the Maintain privilege on Lifecycle. From there, you can find the package titled SAP Analytics Cloud Usage Tracking Content.

This Usage Tracking Content is based on internal data, which means for it to work properly, the content must be current. In the Publishing tab under Import Schedule, select Automatically update new content to ensure that the models show accurate data.

Due to the nature of this content, some sensitive data will be available such as information on users’ private files and users’ activities. For this reason, we recommend you do not make this story public. Instead, limit the audience to only Administrator or Monitor type roles.

As an additional safeguard, SAP has made access to the data a specific privilege. Only users who have a role that has Read privilege on Activity Log will be able to see the data. TheActivity Log displays the same kind of data that is displayed in this model.

To monitor system performance, go to the Navigation Bar and choose to System → Monitor.

In the cloud, SAP does the real administration in this area, but usage information is always available to be reviewed by administrators on your tenant.

To help control costs, you can review usage information from the System Usage by Storage area.


## Content Network and Best Practice Content

The delivered content for SAP Analytics Cloud is immense. The benefits of using delivered content include:

- Faster implementations
- The ability to copy and customize the content

For more information on SAP Analytics Cloud online help, maintaining business content, and best practices on planning content, you can use the SAP Help Portal. To get access to the delivered content for SAP Analytics Cloud, you can use the Content Network.

### SAP SuccessFactors Workforce Planning example

The following figure shows how a start page can be linked with other stories. You can use the launchpad to access stories.

- Forecast Preparation
- Output targets
- Hires
- Retirements
- Terminations
- Risk Response Preparation

The workforce planning content is activated in the training system:

- From the Navigation Bar chooseFiles → Public.
- Go to SACP30_<Current Collection ##> → Content → SAP_HR_SF_Workforce_Planning.
- Go to Strategic → SAP__HR_ANA_SWFP_LP_ADMIN.

Use the SAP Best Practices Explorer to find packages that contain implementation aids.

To access the SAP Best Practices Explorer, see: [https://rapid.sap.com/bp/](https://rapid.sap.com/bp/)




