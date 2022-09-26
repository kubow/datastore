set temporary option Query_Plan = 'ON';
set temporary option Query_Detail = 'ON';
set temporary option Query_Timing = 'ON';
set temporary option Query_Plan_After_Run = 'ON';
set temporary option Query_Plan_As_HTML = 'ON';
set temporary option Index_Advisor = 'ON';
set temporary option Query_Plan_Text_Access ='ON' ;
--set temporary option REVERT_TO_VI5_OPTIMIZED = 'OFF';
--set temporary option Query_Name = '<Query_name>';
--set temporary option DML_Options10 = 'ON';
--set temporary option Query_Plan_As_HTML_Directory = '<html_plans_directory>';


SELECT
    DepartmentName, EmployeeID, Surname, GivenName, Salary
FROM
        groupo.Employees
    JOIN
        groupo.Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE
    ManagerID=501;


---
SET temporary option DDL_Information = ‘ON’ ;
SET temporary option DML_Options10 = ‘ON’;
SET temporary option Index_Advisor = ‘ON’;
SET temporary option Query_Plan_After_Run = ‘ON’;
SET temporary option Query_Detail = ‘ON’;
SET temporary option Query_Name = ‘query name here’;
SET temporary option Query_Plan = ‘ON’ ;
SET temporary option Query_Plan_As_HTML = ‘ON’;
SET temporary option Query_Plan_As_Html_Directory = ‘directory/path‘;
SET temporary option QUERY_PLAN_TEXT_ACCESS = ‘ON’ ;
SET temporary option Query_Timing = ‘ON’ ;
SET temporary option QUERY_PLAN_MIN_TIME Option = <num milliseconds>