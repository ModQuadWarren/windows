-- SELECT & FROM statements (Using AdventureWorks2022 DB
-- Basic syntax (test connection to SQL server - doesn't retrieve DB data)
SELECT 1;

-- Return a Name
SELECT 'Adam';

-- Return a record with 2 attribute columns
SELECT 'Adam', 1;

-- Choose which column(s)/Table(s) to pull data from
SELECT Name, GroupName
FROM HumanResources.Department;

-- Change column viewing order
SELECT GroupName, Name
FROM HumanResources.Department;

-- Add Columns to query
SELECT GroupName, Name, ModifiedDate, DepartmentID
FROM HumanResources.Department;

-- Show ALL columns in table
-- Avoid using with SP (stored-procedure) or app code as it's potentially unsecure
SELECT *
FROM HumanResources.Department;

-- Filter records with WHERE
-- Query all depts in the R&D group
SELECT *
FROM HumanResources.Department
WHERE GroupName = 'Research and Development';

-- Query all depts in multiple Groups
SELECT *
FROM HumanResources.Department
WHERE GroupName IN('Research and Development' , 'Quality Assurance')