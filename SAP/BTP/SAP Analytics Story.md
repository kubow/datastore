# SAC Data Analysis and Presentation
- [[#Story Explorer]]
- [[#Data Analyzer]]
- [[#Presentation]]
- [[#Collaboration]]


## Story Explorer
[Data Visualization (Stories) | SAP Help Portal](https://help.sap.com/docs/SAP_ANALYTICS_CLOUD/00f68c2e08b941f081002fd3691d86a7/29e0feaf17584e118ef30e6102008224.html)
[Stories, Reporting, and Data Exploration | SAP Analytics Cloud | SAP Community](https://community.sap.com/topics/cloud-analytics/stories-reporting-exploration)


## Data Analyzer
[Data Analyzer | SAP Help Portal](https://help.sap.com/docs/SAP_ANALYTICS_CLOUD/00f68c2e08b941f081002fd3691d86a7/3bd79ad3e58442e7a5499fd9c547cbb3.html)
[Launch Data Analyzer and Start Ad-Hoc Analysis | SAP Help Portal](https://help.sap.com/docs/SAP_ANALYTICS_CLOUD/00f68c2e08b941f081002fd3691d86a7/67afbf41f24f4cb48ca7bd72d5e40d94.html)

Vision: “One standalone exploration experience for ad-hoc analysis with support of all key data sources and the ability to save, share and export the results independently.”
- Standalone with easy access from the side navigation bar
- Save insights, share and publish
- Contextual exploration from story and application
- Explore data conversationally, visually, or within a table


## Presentation

- SAP Digital Boardroom
- SAC Cloud Mobile
- Scheduling delivery


## Collaboration
### The SAC Calendar

Use the calendar to organize your workflows with calendar events: You can create different types of tasks and assign people to work on them and others to review the work. You can use processes to manage multiple events.

The calendar provides following features to view, create, and manage your tasks:
- Collaborate
- Status & Tracking
- Schedule Tasks
- Reviewers
- Reminders
- Due dates

You use the calendar to view, create, and manage your processes and tasks. Directly integrated applications in the calendar make it easier for you to accomplish your due tasks and receive an overview of your data.

### Comments

Commenting is a great way to offer feedback on specific elements in a story. Select the element you wish to comment on, choose the comment icon, and enter your message. Comments can be addressed to specific team members by tagging them with the @ symbol. Comments can be added to different locations of the object/report, such as per widget or per story, depending on where the commenting was started.

Comments can be made on a story page, a widget, or a data point in a table. Comments can be 1,000 characters long.

#### Data Point Comments

There are two ways to add data point comments:
- By adding a comment on cells
- By adding a commenting column

You can save comments on cells from any type of acquired model. When a story is opened, comment mode is on by default.

Comments are not activated by model or dimension.

When commenting on a data point, the data context is taken into account. Only users who share the data context can view the comment. The data context is composed of the following:
- All dimensions visible on the table.
- Page, chart, and story filters.
- Data access control and role-level security.

The comment will display in other tables and stories that apply the same filter combinations to the dimension. For example, if you leave a comment on a restricted measure, based on account values that apply a filter on the region dimension to limit the member to North America, the comment will display in other tables or stories that apply the same filters to limit the region dimension to North America.

You can add comments to data cells sourced from restricted measures in a table, however these measures cannot be based on any underlying restricted or calculated measures.

Another way to manage data point comments is by using a dedicated commenting column in your table. This column can be used to view and add comments.

To add a column for comments, right-click on the column header and choose Add Calculation → Comment → Single(for multiple comment columns, choose Repeating).

The dedicated commenting column is created as a new member of the same dimension and hierarchy level as the member it references. You can change this context by referencing a different column in the commenting formula. Changing the drill state or adding a dimension can impact the context of the referenced cell.

Only the most recent comment in a thread will display in a comment column cell. To view an entire comment thread, double-click in the corresponding cell.

When column-based comments are used, data point comments are not allowed on the table widget.

If you collapse a hierarchy, existing data point comments may no longer be fully visible. Instead, the green wedge in the cell will display as transparent. To access the comment, drill down the hierarchy until a green wedge is displayed.

A data point comment also displays the original value of the cell if the data value has changed.
