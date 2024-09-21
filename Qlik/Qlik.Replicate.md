Log based replication

- Only change data is read from transaction logs
- Reduces impact on the source database

Two modes of replication

- Full Load
    - Automatically creates and loads the target
- Change processing (CDC)
    - Captures changes in the source as thay occur and applies to the target in near-real-time

CDC 3 components

- Usually done by reading transaction logs on source side
- One thread reads the changes from source fro all tables, It takes only the changes the related to the tables defined in the task. It does that by keeping a list of “object ids”

Source capture - reading changes from source

Sorter - source changes are passed to the sorter component, which decides if and how to pass the changes to target

Target Apply - after changes are sent from sorter to the target component, target component applies transformation abd sends to target

Cached events - events that are happening during the Full load of the relevant tables (Event time)

Qlik web console addiotional - Replicate console manager

Need to install additional client in order to connect to end-point (both sources and targets)

Based on functionality of SQLite - have to digest deeper (? can be parallel)

JAVA is used for special tasks and targets (salesforce/mongoDB)