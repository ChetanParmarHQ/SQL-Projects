-- TASK 1

-- Create Database
CREATE DATABASE SGVU;
USE SGVU;

-- Create College_Table
CREATE TABLE College_Table (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(100),
    College_Area VARCHAR(100)
);

-- Create Department_Table with Foreign Key referencing College_Table
CREATE TABLE Department_Table (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Dept_Facility VARCHAR(100),
    College_ID INT,
    FOREIGN KEY (College_ID) REFERENCES College_Table(College_ID)
);

-- Create Professor_Table
CREATE TABLE Professor_Table (
    Professor_ID INT PRIMARY KEY,
    Professor_Name VARCHAR(100),
    Professor_Subject VARCHAR(100)
);

-- Create Student_Table with Foreign Key referencing Professor_Table
CREATE TABLE Student_Table (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Student_Stream VARCHAR(100),
    Professor_ID INT,
    FOREIGN KEY (Professor_ID) REFERENCES Professor_Table(Professor_ID)
);

-- Insert 10 Records into College_Table
INSERT INTO College_Table (College_ID, College_Name, College_Area) VALUES
(1, 'Engineering College', 'North Campus'),
(2, 'Management College', 'South Campus'),
(3, 'Science College', 'East Campus'),
(4, 'Arts College', 'West Campus'),
(5, 'Law College', 'Central Campus'),
(6, 'Pharmacy College', 'North Campus'),
(7, 'Education College', 'South Campus'),
(8, 'Agriculture College', 'East Campus'),
(9, 'Commerce College', 'West Campus'),
(10, 'Medical College', 'Central Campus');

-- Insert 10 Records into Department_Table
INSERT INTO Department_Table (Dept_ID, Dept_Name, Dept_Facility, College_ID) VALUES
(1, 'Computer Science', 'Advanced Labs', 1),
(2, 'Mechanical Engineering', 'Workshops', 1),
(3, 'MBA', 'Conference Rooms', 2),
(4, 'Physics', 'Research Labs', 3),
(5, 'History', 'Library Archives', 4),
(6, 'Pharmacy', 'Drug Testing Labs', 6),
(7, 'Education', 'Teaching Aids', 7),
(8, 'Agriculture', 'Greenhouses', 8),
(9, 'Commerce', 'Computer Labs', 9),
(10, 'Medical Sciences', 'Simulation Labs', 10);

-- Insert 10 Records into Professor_Table
INSERT INTO Professor_Table (Professor_ID, Professor_Name, Professor_Subject) VALUES
(1, 'Dr. Anil Sharma', 'Computer Networks'),
(2, 'Prof. Sunita Rao', 'Thermodynamics'),
(3, 'Dr. Vikram Singh', 'Marketing'),
(4, 'Prof. Neha Gupta', 'Quantum Physics'),
(5, 'Dr. Rajesh Kumar', 'Ancient History'),
(6, 'Prof. Priya Mehta', 'Pharmacology'),
(7, 'Dr. Sanjay Patel', 'Pedagogy'),
(8, 'Prof. Anjali Verma', 'Crop Science'),
(9, 'Dr. Manoj Jain', 'Accounting'),
(10, 'Dr. Kavita Desai', 'Anatomy');

-- Insert 10 Records into Student_Table
INSERT INTO Student_Table (Student_ID, Student_Name, Student_Stream, Professor_ID) VALUES
(1, 'Amit Kumar', 'Computer Science', 1),
(2, 'Sneha Sharma', 'Mechanical Engineering', 2),
(3, 'Rahul Gupta', 'MBA', 3),
(4, 'Pooja Singh', 'Physics', 4),
(5, 'Vikas Yadav', 'History', 5),
(6, 'Neha Patel', 'Pharmacy', 6),
(7, 'Ravi Verma', 'Education', 7),
(8, 'Ankita Rao', 'Agriculture', 8),
(9, 'Suresh Jain', 'Commerce', 9),
(10, 'Komal Desai', 'Medical Sciences', 10);

-- TASK 2

USE SGVU;

-- 1. Information of College_ID and College_Name from College_Table
SELECT College_ID, College_Name
FROM College_Table;

-- 2. Show Top 5 rows from Student_Table
-- For SQL Server
SELECT TOP 5 *
FROM Student_Table;

-- 3. Name of Professor whose ID is 5
SELECT Professor_Name
FROM Professor_Table
WHERE Professor_ID = 5;

-- 4. Convert the name of the Professor into Upper Case
SELECT UPPER(Professor_Name) AS Professor_Name_Upper
FROM Professor_Table;

-- 5. Names of students whose name starts with 'A'
SELECT Student_Name
FROM Student_Table
WHERE Student_Name LIKE 'A%';

-- 6. Names of colleges whose name ends with 'a'
SELECT College_Name
FROM College_Table
WHERE College_Name LIKE '%a';

-- 7. Add one Salary Column in Professor_Table
ALTER TABLE Professor_Table
ADD Salary DECIMAL(10, 2);

-- Update Salary values for Professors (assuming some sample salaries)
UPDATE Professor_Table
SET Salary = CASE Professor_ID
    WHEN 1 THEN 75000.00
    WHEN 2 THEN 80000.00
    WHEN 3 THEN 90000.00
    WHEN 4 THEN 85000.00
    WHEN 5 THEN 70000.00
    WHEN 6 THEN 78000.00
    WHEN 7 THEN 82000.00
    WHEN 8 THEN 76000.00
    WHEN 9 THEN 88000.00
    WHEN 10 THEN 95000.00
    ELSE Salary -- optional but recommended
END;


-- 8. Add one Contact Column in Student_Table
ALTER TABLE Student_Table
ADD Contact VARCHAR(15);

-- Update Contact values for Students (assuming sample contact numbers)
UPDATE Student_Table
SET Contact = CASE Student_ID
    WHEN 1 THEN '9876543210'
    WHEN 2 THEN '8765432109'
    WHEN 3 THEN '7654321098'
    WHEN 4 THEN '6543210987'
    WHEN 5 THEN '5432109876'
    WHEN 6 THEN '4321098765'
    WHEN 7 THEN '3210987654'
    WHEN 8 THEN '2109876543'
    WHEN 9 THEN '1098765432'
    WHEN 10 THEN '0987654321'
END;

-- 9. Find the total Salary of Professors
SELECT SUM(Salary) AS Total_Salary
FROM Professor_Table;

-- 10. Change datatype of any one column of any one Table
-- Changing College_Area in College_Table from VARCHAR(100) to TEXT
ALTER TABLE College_Table
ALTER COLUMN College_Area TEXT;

-- TASK 3

USE SGVU;

-- 1. Show first 5 records from Students table and Professor table Combined
-- Using a JOIN to combine Student_Table and Professor_Table
SELECT TOP 5 
    s.Student_ID, 
    s.Student_Name, 
    s.Student_Stream, 
    s.Professor_ID, 
    p.Professor_Name, 
    p.Professor_Subject
FROM Student_Table s
JOIN Professor_Table p ON s.Professor_ID = p.Professor_ID;


	-- 2. Apply Inner Join on all 4 tables together

	-- Add Dept_ID column to Professor_Table as a Foreign Key
ALTER TABLE Professor_Table
ADD Dept_ID INT;

-- Set the Foreign Key constraint
ALTER TABLE Professor_Table
ADD CONSTRAINT FK_Professor_Dept
FOREIGN KEY (Dept_ID) REFERENCES Department_Table(Dept_ID);

-- Assign sample Dept_ID values to existing professors (matching their subjects to departments)
UPDATE Professor_Table
SET Dept_ID = CASE Professor_ID
    WHEN 1 THEN 1  -- Computer Science (Dr. Anil Sharma - Computer Networks)
    WHEN 2 THEN 2  -- Mechanical Engineering (Prof. Sunita Rao - Thermodynamics)
    WHEN 3 THEN 3  -- MBA (Dr. Vikram Singh - Marketing)
    WHEN 4 THEN 4  -- Physics (Prof. Neha Gupta - Quantum Physics)
    WHEN 5 THEN 5  -- History (Dr. Rajesh Kumar - Ancient History)
    WHEN 6 THEN 6  -- Pharmacy (Prof. Priya Mehta - Pharmacology)
    WHEN 7 THEN 7  -- Education (Dr. Sanjay Patel - Pedagogy)
    WHEN 8 THEN 8  -- Agriculture (Prof. Anjali Verma - Crop Science)
    WHEN 9 THEN 9  -- Commerce (Dr. Manoj Jain - Accounting)
    WHEN 10 THEN 10 -- Medical Sciences (Dr. Kavita Desai - Anatomy)
    WHEN 11 THEN 11 -- Data Science (Dr. Unknown - NULL)
    WHEN 12 THEN 12 -- AI (NULL - Machine Learning)
END;
SELECT c.College_ID, c.College_Name, d.Dept_ID, d.Dept_Name, p.Professor_ID, p.Professor_Name, s.Student_ID, s.Student_Name
FROM College_Table c
INNER JOIN Department_Table d ON c.College_ID = d.College_ID
INNER JOIN Professor_Table p ON p.Dept_ID = d.Dept_ID
INNER JOIN Student_Table s ON s.Professor_ID = p.Professor_ID;


-- 3. Show Some NULL values from Department_Table and Professor_Table
-- Insert records with NULL values for demonstration
INSERT INTO Department_Table (Dept_ID, Dept_Name, Dept_Facility, College_ID) VALUES
(11, 'Data Science', NULL, 1),
(12, 'AI', NULL, 2);

INSERT INTO Professor_Table (Professor_ID, Professor_Name, Professor_Subject, Salary) VALUES
(11, 'Dr. Unknown', NULL, NULL),
(12, NULL, 'Machine Learning', 72000.00);

-- Query to show NULL values
SELECT Dept_ID, Dept_Name, Dept_Facility
FROM Department_Table
WHERE Dept_Facility IS NULL
UNION
SELECT Professor_ID, Professor_Name, Professor_Subject
FROM Professor_Table
WHERE Professor_Name IS NULL OR Professor_Subject IS NULL OR Salary IS NULL;

-- 4. Create a View from College_Table for college names starting with 'C'
CREATE VIEW Colleges_Starting_With_C AS
SELECT College_ID, College_Name, College_Area
FROM College_Table
WHERE College_Name LIKE 'C%';

-- Query to display the view
SELECT * FROM Colleges_Starting_With_C;

-- 5. Create Stored Procedure for Professor_Table to show records by Professor_ID
CREATE PROCEDURE GetProfessorByID
    @prof_id INT
AS
BEGIN
    SELECT Professor_ID, Professor_Name, Professor_Subject, Salary
    FROM Professor_Table
    WHERE Professor_ID = @prof_id;
END;

-- Example call to the stored procedure
Exec GetProfessorByID @prof_id = 5;

-- 6. Rename College_Table to College_Tables_Data
 EXEC sp_rename 'College_Table', 'College_Tables_Data';
 -- revert back
 EXEC sp_rename 'College_Tables_Data', 'College_Table';


