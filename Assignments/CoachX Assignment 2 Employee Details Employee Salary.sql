CREATE DATABASE COACHX;

USE Coachx;

CREATE TABLE EmployeeDetails (
 EmpId INT PRIMARY KEY,
 FullName VARCHAR(100),
 ManagerId INT,
 DateOfJoining DATE,
 City VARCHAR(100)
);

CREATE TABLE EmployeeSalary (
 EmpId INT,
 Project VARCHAR(50),
 Salary DECIMAL(10, 2),
 Variable DECIMAL(10, 2),
 FOREIGN KEY (EmpId) REFERENCES
EmployeeDetails(EmpId)
);

--Table 1: EmployeeDetails

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId,
DateOfJoining, City) VALUES
(101, 'Alice Johnson', 321, '2022-05-15', 'New York'),
(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'),
(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'),
(104, 'David Williams', 876, '2019-11-05', 'Houston'),
(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'),
(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'),
(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'),
(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'),
(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'),
(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'),
(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'),
(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'),
(113, 'Mia White', 876, '2019-06-03', 'Columbus'),
(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'),
(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'),
(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'),
(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'),
(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'),
(119, 'Steve Clark', 876, '2021-03-19', 'Washington'),
(120, 'Tina Lewis', 321, '2019-08-31', 'Boston');

--Table 2: EmployeeSalary
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
(101, 'P1', 7500, 500),
(102, 'P2', 9200, 700),
(103, 'P1', 6700, 600),
(104, 'P3', 8300, 900),
(105, 'P2', 7800, 800),
(106, 'P3', 9100, 1000),
(107, 'P1', 6200, 400),
(108, 'P2', 8800, 750),
(109, 'P3', 9500, 1100),
(110, 'P1', 7200, 650),
(111, 'P2', 8700, 850),
(112, 'P3', 9300, 1200),
(113, 'P1', 7900, 550),
(114, 'P2', 6800, 450),
(115, 'P3', 8400, 900),
(116, 'P1', 7600, 500),
(117, 'P2', 8900, 1000),
(118, 'P3', 9200, 1100),
(119, 'P1', 8100, 600),
(120, 'P2', 8300, 750);

-- Basics and Intermediate Questions

-- PART !

-- Q1: SQL Query to fetch records that are present in one table but not in another table
-- Interpretation: Fetch EmployeeDetails records where EmpId is not in EmployeeSalary
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- Note: Based on provided data, all EmpIds (101–120) exist in both tables, so this returns no rows.
-- Alternative using LEFT JOIN:
SELECT ED.EmpId, ED.FullName, ED.ManagerId, ED.DateOfJoining, ED.City
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.EmpId IS NULL;


-- Q2: SQL query to fetch all the employees who are not working on any project
-- Interpretation: Employees in EmployeeDetails with no corresponding record in EmployeeSalary
SELECT ED.EmpId, ED.FullName, ED.ManagerId, ED.DateOfJoining, ED.City
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.Project IS NULL;

-- Note: Since all EmpIds (101–120) have a project in EmployeeSalary, this returns no rows.

-- Q3: SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-- Result: Employees with EmpId 102, 109, 114, 118 (joined in 2020).

-- Q4: Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary
SELECT ED.EmpId, ED.FullName, ED.ManagerId, ED.DateOfJoining, ED.City
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Note: Returns all 20 employees (EmpId 101–120) since all have salary records.

-- Q5: Write an SQL query to fetch a project-wise count of employees
SELECT ES.Project, COUNT(ES.EmpId) AS EmployeeCount
FROM EmployeeSalary ES
GROUP BY ES.Project
ORDER BY EmployeeCount DESC;

-- Result: 
-- P1: 7 employees
-- P2: 7 employees
-- P3: 6 employees

-- Q6: Fetch employee names and salaries even if the salary value is not present for the employee
SELECT ED.FullName, ES.Salary
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Note: Since all employees have salary records, no NULL salaries appear. If an employee had no salary record, Salary would be NULL.

-- Q7: Write an SQL query to fetch all the Employees who are also managers
SELECT ED1.EmpId, ED1.FullName
FROM EmployeeDetails ED1
WHERE ED1.EmpId IN (SELECT DISTINCT ManagerId FROM EmployeeDetails ED2);

-- Result: Returns EmpId 321, 876, 986 if they exist in EmployeeDetails. Based on provided data, no employees have EmpId matching ManagerId (321, 876, 986), so this returns no rows.

-- Q8: Write an SQL query to fetch duplicate records from EmployeeDetails
-- Interpretation: Find records with duplicate FullName (or other fields, but FullName is most likely)
SELECT FullName, COUNT(*) AS Count
FROM EmployeeDetails
GROUP BY FullName
HAVING COUNT(*) > 1;

-- Note: Based on provided data, all FullNames are unique, so this returns no rows.
-- Alternative for complete row duplicates:
SELECT EmpId, FullName, ManagerId, DateOfJoining, City, COUNT(*) AS Count
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

-- Q9: Write an SQL query to fetch only odd rows from the table
-- Interpretation: Fetch odd-numbered rows from EmployeeDetails (based on row number)
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
    FROM EmployeeDetails
) AS NumberedRows
WHERE RowNum % 2 = 1;

-- Alternarive
SELECT * 
FROM EmployeeDetails 
WHERE EmpId % 2 = 1;

-- Result: Returns rows for EmpId 101, 103, 105, 107, 109, 111, 113, 115, 117, 119.

-- Q10: Write a query to find the 3rd highest salary from a table without top or limit keyword
SELECT Salary
FROM EmployeeSalary ES1
WHERE 2 = (
    SELECT COUNT(DISTINCT Salary)
    FROM EmployeeSalary ES2
    WHERE ES2.Salary > ES1.Salary
);

-- PART 2

-- Ques.1: Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – „986‟
SELECT EmpId, FullName
FROM EmployeeDetails
WHERE ManagerId = 986;

-- Result: Employees Charlie Brown (103), Frank Miller (106), Ivy Taylor (109), Liam Jackson (112), Olivia Martin (115), Rachel Rodriguez (118)

-- Ques.2: Write an SQL query to fetch the different projects available from the EmployeeSalary table
SELECT DISTINCT Project
FROM EmployeeSalary;

-- Result: P1, P2, P3

-- Ques.3: Write an SQL query to fetch the count of employees working in project „P1‟
SELECT COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
WHERE Project = 'P1';

-- Result: 7 employees

-- Ques.4: Write an SQL query to find the maximum, minimum, and average salary of the employees
SELECT 
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary,
    AVG(Salary) AS AvgSalary
FROM EmployeeSalary;

-- Result: MaxSalary: 9500.00, MinSalary: 6200.00, AvgSalary: 8175.00

-- Ques.5: Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000
SELECT EmpId
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

-- Result: EmpId 102, 106, 109, 112, 118 (salaries: 9200, 9100, 9500, 9300, 9200)

-- Ques.6: Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM EmployeeDetails
WHERE City = 'Toronto' AND ManagerId = 321;

-- Result: No employees (none live in Toronto based on provided data)

-- Ques.7: Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM EmployeeDetails
WHERE City = 'California' OR ManagerId = 321;

-- Result: Employees Alice Johnson (101), Eve Davis (105), Hank Moore (108), Karen Thomas (111), Noah Harris (114), Quinn Martinez (117), Tina Lewis (120) (all have ManagerId 321; none live in California)

-- Ques.8: Write an SQL query to fetch all those employees who work on Projects other than P1
SELECT ED.EmpId, ED.FullName
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.Project != 'P1';

-- Result: Employees Bob Smith (102), David Williams (104), Eve Davis (105), Frank Miller (106), Hank Moore (108), Ivy Taylor (109), Karen Thomas (111), Liam Jackson (112), Noah Harris (114), Olivia Martin (115), Quinn Martinez (117), Rachel Rodriguez (118), Tina Lewis (120) (projects P2 or P3)

-- Ques.9: Write an SQL query to display the total salary of each employee adding the Salary with Variable value
SELECT 
    ES.EmpId, 
    ED.FullName, 
    (ES.Salary + ES.Variable) AS TotalSalary
FROM EmployeeSalary ES
INNER JOIN EmployeeDetails ED ON ES.EmpId = ED.EmpId;

-- Result: TotalSalary for each employee (e.g., Alice Johnson: 7500 + 500 = 8000.00, Bob Smith: 9200 + 700 = 9900.00, etc.)

-- Ques.10: Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters
SELECT EmpId, FullName
FROM EmployeeDetails
WHERE FullName LIKE '__hn%';

-- PART 3

-- Ques.1: Write an SQL query to fetch all the EmpIds which are present in either of the tables – „EmployeeDetails‟ and „EmployeeSalary‟
SELECT EmpId FROM EmployeeDetails
UNION
SELECT EmpId FROM EmployeeSalary;

-- Result: EmpId 101–120 (all EmpIds from both tables, no duplicates due to UNION)

-- Ques.2: Write an SQL query to fetch common records between two tables
-- Interpretation: Fetch records where EmpId exists in both tables
SELECT ED.*, ES.Project, ES.Salary, ES.Variable
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Result: All 20 records (EmpId 101–120) since all EmpIds exist in both tables

-- Ques.3: Write an SQL query to fetch records that are present in one table but not in another table
-- Interpretation: Fetch EmployeeDetails records not in EmployeeSalary
SELECT EmpId, FullName, ManagerId, DateOfJoining, City
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- Result: No records (all EmpIds 101–120 exist in both tables)
-- Alternative using LEFT JOIN:
SELECT ED.EmpId, ED.FullName, ED.ManagerId, ED.DateOfJoining, ED.City
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.EmpId IS NULL;

-- Ques.4: Write an SQL query to fetch the EmpIds that are present in both the tables – „EmployeeDetails‟ and „EmployeeSalary
SELECT ED.EmpId
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Result: EmpId 101–120 (all EmpIds are present in both tables)

-- Ques.5: Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary
SELECT EmpId
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- Result: No EmpIds (all EmpIds 101–120 exist in EmployeeSalary)

-- Ques.6: Write an SQL query to fetch the employee‟s full names and replace the space
-- Interpretation: Replace space in FullName with an underscore
SELECT REPLACE(FullName, ' ', '_') AS ModifiedFullName
FROM EmployeeDetails;

-- Result: e.g., Alice_Johnson, Bob_Smith, Charlie_Brown, etc.

-- Ques.7: Write an SQL query to fetch the position of a given character(s) in a field
-- Interpretation: Find position of 'a' in FullName
SELECT FullName, CHARINDEX('a', FullName) AS PositionOfA
FROM EmployeeDetails;

-- Result: Position of first 'a' in each name (e.g., Alice Johnson: 1, Bob Smith: 0, Charlie Brown: 3)

-- Ques.8: Write an SQL query to display both the EmpId and ManagerId together
-- Interpretation: Concatenate EmpId and ManagerId with a separator
SELECT CONCAT(EmpId, '-', ManagerId) AS EmpId_ManagerId
FROM EmployeeDetails;

-- Result: e.g., 101-321, 102-876, 103-986, etc.

-- Ques.9: Write a query to fetch only the first name (string before space) from the FullName column of the EmployeeDetails table
SELECT SUBSTRING(FullName, 1, CHARINDEX(' ', FullName) - 1) AS FirstName
FROM EmployeeDetails;

-- Result: Alice, Bob, Charlie, David, Eve, etc.

-- Ques.10: Write an SQL query to uppercase the name of the employee and lowercase the city values
SELECT UPPER(FullName) AS UpperFullName, LOWER(City) AS LowerCity
FROM EmployeeDetails;

-- Result: e.g., ALICE JOHNSON, new york; BOB SMITH, los angeles; etc.

-- PART 4

-- Ques.1: Write an SQL query to find the count of the total occurrences of a particular character – „n‟ in the FullName field
SELECT FullName,
       (LEN(FullName) - LEN(REPLACE(LOWER(FullName), 'n', ''))) AS N_Count
FROM EmployeeDetails;

-- Result: Counts 'n' (case-insensitive) in each FullName (e.g., Alice Johnson: 3, Bob Smith: 0, Charlie Brown: 1)

-- Ques.2: Write an SQL query to update the employee names by removing leading and trailing spaces
UPDATE EmployeeDetails
SET FullName = TRIM(FullName);

-- Result: Removes leading/trailing spaces from FullName. No effect in provided data since no names have extra spaces.

-- Ques.3: Fetch all the employees who are not working on any project
SELECT ED.EmpId, ED.FullName, ED.ManagerId, ED.DateOfJoining, ED.City
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.Project IS NULL;

-- Result: No records (all EmpIds 101–120 have projects in EmployeeSalary)

-- Ques.4: Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000
SELECT ED.FullName, ES.Salary
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
WHERE ES.Salary BETWEEN 5000 AND 10000;

-- Result: All 20 employees (salaries range from 6200 to 9500)

-- Ques.5: Write an SQL query to find the current date-time
SELECT GETDATE() AS CurrentDateTime;

-- Result: Returns current date-time (e.g., '2025-04-16 12:34:56' depending on system time)

-- Ques.6: Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-- Result: Bob Smith (102), Ivy Taylor (109), Noah Harris (114), Rachel Rodriguez (118)

-- Ques.7: Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table
SELECT *
FROM EmployeeDetails ED
INNER JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Result: All 20 employees (EmpId 101–120) since all have salary records

-- Ques.8: Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order
SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project
ORDER BY EmployeeCount DESC;

-- Result: P1: 7, P2: 7, P3: 6 (P1 and P2 tie, P3 follows)

-- Ques.9: Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present
SELECT ED.FullName, ES.Salary
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- Result: All 20 employees with their salaries (no NULLs since all have salary records)

-- Ques.10: Write an SQL query to join 3 tables
-- Note: Only 2 tables (EmployeeDetails, EmployeeSalary) provided. Assuming a hypothetical third table (e.g., ManagerDetails) for demonstration:
-- Hypothetical ManagerDetails table: ManagerId, ManagerName
CREATE TABLE ManagerDetails (
    ManagerId INT PRIMARY KEY,
    ManagerName VARCHAR(100)
);
-- Sample join with 3 tables
SELECT ED.EmpId, ED.FullName, ES.Salary, MD.ManagerName
FROM EmployeeDetails ED
JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId
JOIN ManagerDetails MD ON ED.ManagerId = MD.ManagerId;

-- Result: Cannot execute without ManagerDetails table. so, no records