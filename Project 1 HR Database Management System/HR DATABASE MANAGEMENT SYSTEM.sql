CREATE DATABASE HRDMS

USE HRDMS

-- 1. Create REGIONS (Independent Table)
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(25) DEFAULT NULL
);
USE HRDMS
Select * From coun
-- 2. Create COUNTRIES (Depends on Regions)
CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40) DEFAULT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions (region_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. Create LOCATIONS (Depends on Countries)
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(40) DEFAULT NULL,
    postal_code VARCHAR(12) DEFAULT NULL,
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25) DEFAULT NULL,
    country_id CHAR(2) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (country_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. Create JOBS (Independent Table)
CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(8, 2) DEFAULT NULL,
    max_salary DECIMAL(8, 2) DEFAULT NULL
);

-- 5. Create DEPARTMENTS (Depends on Locations)
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    location_id INT DEFAULT NULL,
    FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Create EMPLOYEES (Depends on Jobs, Departments, and Self-Reference for Manager)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(20) DEFAULT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) DEFAULT NULL,
    hire_date DATE NOT NULL,
    job_id INT NOT NULL,
    salary DECIMAL(8, 2) NOT NULL,
    manager_id INT DEFAULT NULL,
    department_id INT DEFAULT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id) -- Self Join
);

 -- 7. Create DEPENDENTS (Depends on Employees)
CREATE TABLE dependents (
    dependent_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship VARCHAR(25) NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

Select e.department_id, d.department_name, count(e.employee_id) as no_of_employees 
from employees e
JOIN departments d on d.department_id= e.department_id
Group BY e.department_id, d.department_name;

-- Insert Regions
INSERT INTO regions (region_id, region_id) VALUES (1,'Europe'), (2,'Americas'), (3,'Asia'), (4,'Middle East and Africa');

-- Insert Countries 
INSERT INTO countries  (country_id, country_name, region_id) VALUES 
 ('AR','Argentina',2), 
 ('AU','Australia',3), 
 ('BE','Belgium',1),
 ('BR','Brazil',2),
 ('CA','Canada',2),
 ('CH','Switzerland',1),
 ('CN','China',3),
 ('DE','Germany',1),
 ('DK','Denmark',1),
 ('EG','Egypt',4),
 ('FR','France',1),
 ('HK','HongKong',3),
 ('IL','Israel',4),
 ('IN','India',3),
 ('IT','Italy',1),
 ('JP','Japan',3),
 ('KW','Kuwait',4),
 ('MX','Mexico',2),
 ('NG','Nigeria',4), 
 ('NL','Netherlands',1),
 ('SG','Singapore',3),
 ('UK','United Kingdom',1),
 ('US','United States of America',2),
 ('ZM','Zambia',4),
 ('ZW','Zimbabwe',4);

 -- Insert Locations

 INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
 (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),
 (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),
 (1700,'2004 Charade Rd','98199','Seattle','Washington','US'),
 (1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),
 (2400,'8204 Arthur St',NULL,'London',NULL,'UK'),
 (2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'),
 (2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');

 -- Insert Jobs
 
 INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
  (1,'Public Accountant',4200.00,9000.00),
  (2,'Accounting Manager',8200.00,16000.00),
  (3,'Administration Assistant',3000.00,6000.00),
  (4,'President',20000.00,40000.00),
  (5,'Administration Vice President',15000.00,30000.00),
  (6,'Accountant',4200.00,9000.00),
  (7,'Finance Manager',8200.00,16000.00),
  (8,'Human Resources Representative',4000.00,9000.00),
  (9,'Programmer',4000.00,10000.00),
  (10,'Marketing Manager',9000.00,15000.00),
  (11,'Marketing Representative',4000.00,9000.00),
  (12,'Public Relations Representative',4500.00,10500.00),
  (13,'Purchasing Clerk',2500.00,5500.00),
  (14,'Purchasing Manager',8000.00,15000.00),
  (15,'Sales Manager',10000.00,20000.00),
  (16,'Sales Representative',6000.00,12000.00),
  (17,'Shipping Clerk',2500.00,5500.00),
  (18,'Stock Clerk',2000.00,5000.00),
  (19,'Stock Manager',5500.00,8500.00);

  -- Insert Departments

 INSERT INTO departments (department_id, department_name, location_id) VALUES
 (1,  'Administration',     1700),
 (2,  'Marketing',          1800),
 (3,  'Purchasing',         1700),
 (4,  'Human Resources',    2400),
 (5,  'Shipping',           1500),
 (6,  'IT',                 1400),
 (7,  'Public Relations',   2700),
 (8,  'Sales',              2500),
 (9,  'Executive',          1700),
 (10, 'Finance',            1700),
 (11, 'Accounting',         1700);

 -- Insert Employees 

 INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id,department_id) VALUES
(100,'Steven','King','steven.king@sqltutorial.org','515.123.4567','1987-06-17',4,24000.00,NULL,9),
(101,'Neena','Kochhar','neena.kochhar@sqltutorial.org','515.123.4568','1989-09-21',5,17000.00,100,9),
(102,'Lex','De Haan','lex.de haan@sqltutorial.org','515.123.4569','1993-01-13',5,17000.00,100,9),
(103,'Alexander','Hunold','alexander.hunold@sqltutorial.org','590.423.4567','1990-01-03',9,9000.00,102,6),
(104,'Bruce','Ernst','bruce.ernst@sqltutorial.org','590.423.4568','1991-05-21',9,6000.00,103,6),
(105,'David','Austin','david.austin@sqltutorial.org','590.423.4569','1997-06-25',9,4800.00,103,6),
(106,'Valli','Pataballa','valli.pataballa@sqltutorial.org','590.423.4560','1998-02-05',9,4800.00,103,6),
(107,'Diana','Lorentz','diana.lorentz@sqltutorial.org','590.423.5567','1999-02-07',9,4200.00,103,6),
(108,'Nancy','Greenberg','nancy.greenberg@sqltutorial.org','515.124.4569','1994-08-17',7,12000.00,101,10),
(109,'Daniel','Faviet','daniel.faviet@sqltutorial.org','515.124.4169','1994-08-16',6,9000.00,108,10),
(110,'John','Chen','john.chen@sqltutorial.org','515.124.4269','1997-09-28',6,8200.00,108,10),
(111,'Ismael','Sciarra','ismael.sciarra@sqltutorial.org','515.124.4369','1997-09-30',6,7700.00,108,10),
(112,'Jose Manuel','Urman','jose manuel.urman@sqltutorial.org','515.124.4469','1998-03-07',6,7800.00,108,10),
(113,'Luis','Popp','luis.popp@sqltutorial.org','515.124.4567','1999-12-07',6,6900.00,108,10),
(114,'Den','Raphaely','den.raphaely@sqltutorial.org','515.127.4561','1994-12-07',14,11000.00,100,3),
(115,'Alexander','Khoo','alexander.khoo@sqltutorial.org','515.127.4562','1995-05-18',13,3100.00,114,3),
(116,'Shelli','Baida','shelli.baida@sqltutorial.org','515.127.4563','1997-12-24',13,2900.00,114,3),
(117,'Sigal','Tobias','sigal.tobias@sqltutorial.org','515.127.4564','1997-07-24',13,2800.00,114,3),
(118,'Guy','Himuro','guy.himuro@sqltutorial.org','515.127.4565','1998-11-15',13,2600.00,114,3),
(119,'Karen','Colmenares','karen.colmenares@sqltutorial.org','515.127.4566','1999-08-10',13,2500.00,114,3),
(120,'Matthew','Weiss','matthew.weiss@sqltutorial.org','650.123.1234','1996-07-18',19,8000.00,100,5),
(121,'Adam','Fripp','adam.fripp@sqltutorial.org','650.123.2234','1997-04-10',19,8200.00,100,5),
(122,'Payam','Kaufling','payam.kaufling@sqltutorial.org','650.123.3234','1995-05-01',19,7900.00,100,5),
(123,'Shanta','Vollman','shanta.vollman@sqltutorial.org','650.123.4234','1997-10-10',19,6500.00,100,5),
(126,'Irene','Mikkilineni','irene.mikkilineni@sqltutorial.org','650.124.1224','1998-09-28',18,2700.00,120,5),
(145,'John','Russell','john.russell@sqltutorial.org',NULL,'1996-10-01',15,14000.00,100,8),
(146,'Karen','Partners','karen.partners@sqltutorial.org',NULL,'1997-01-05',15,13500.00,100,8),
(176,'Jonathon','Taylor','jonathon.taylor@sqltutorial.org',NULL,'1998-03-24',16,8600.00,100,8),
(177,'Jack','Livingston','jack.livingston@sqltutorial.org',NULL,'1998-04-23',16,8400.00,100,8),
(178,'Kimberely','Grant','kimberely.grant@sqltutorial.org',NULL,'1999-05-24',16,7000.00,100,8),
(179,'Charles','Johnson','charles.johnson@sqltutorial.org',NULL,'2000-01-04',16,6200.00,100,8),
(192,'Sarah','Bell','sarah.bell@sqltutorial.org','650.501.1876','1996-02-04',17,4000.00,123,5),
(193,'Britney','Everett','britney.everett@sqltutorial.org','650.501.2876','1997-03-03',17,3900.00,123,5),
(200,'Jennifer','Whalen','jennifer.whalen@sqltutorial.org','515.123.4444','1987-09-17',3,4400.00,101,1),
(201,'Michael','Hartstein','michael.hartstein@sqltutorial.org','515.123.5555','1996-02-17',10,13000.00,100,2),
(202,'Pat','Fay','pat.fay@sqltutorial.org','603.123.6666','1997-08-17',11,6000.00,201,2),
(203,'Susan','Mavris','susan.mavris@sqltutorial.org','515.123.7777','1994-06-07',8,6500.00,101,4),
(204,'Hermann','Baer','hermann.baer@sqltutorial.org','515.123.8888','1994-06-07',12,10000.00,101,7),
(205,'Shelley','Higgins','shelley.higgins@sqltutorial.org','515.123.8080','1994-06-07',2,12000.00,101,11);

-- I have added one more record to the employees table because one of the dependent records belongs to employee ID 206, which was not available in the table.

 INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id,department_id) VALUES
(206,'Michael','Gietz','michael.gietz@sqltutorial.org','515.999.9999','2000-02-01',16,6000.00,100,9);

-- Insert Dependents 

INSERT INTO dependents (dependent_id, first_name, last_name, relationship, employee_id) VALUES
(1,'Penelope','Gietz','Child',206),
(2,'Nick','Higgins','Child',205),
(3,'Ed','Whalen','Child',200),
(4,'Jennifer','King','Child',100),
(5,'Johnny','Kochhar','Child',101),
(6,'Bette','De Haan','Child',102),
(7,'Grace','Faviet','Child',109),
(8,'Matthew','Chen','Child',110),
(9,'Joe','Sciarra','Child',111),
(10,'Christian','Urman','Child',112),
(11,'Zero','Popp','Child',113),
(12,'Karl','Greenberg','Child',108),
(13,'Uma','Mavris','Child',203),
(14,'Vivien','Hunold','Child',103),
(15,'Cuba','Ernst','Child',104),
(16,'Fred','Austin','Child',105),
(17,'Helen','Pataballa','Child',106),
(18,'Dan','Lorentz','Child',107),
(19,'Bob','Hartstein','Child',201),
(20,'Lucille','Fay','Child',202),
(21,'Kirsten','Baer','Child',204),
(22,'Elvis','Khoo','Child',115),
(23,'Sandra','Baida','Child',116),
(24,'Cameron','Tobias','Child',117),
(25,'Kevin','Himuro','Child',118),
(26,'Rip','Colmenares','Child',119),
(27,'Julia','Raphaely','Child',114),
(28,'Woody','Russell','Child',145),
(29,'Alec','Partners','Child',146),
(30,'Sandra','Taylor','Child',176);

-- TASK 1:

-- 1) WRITE A QUERY FOR SELECT STATEMENTS :-

-- A. To get data from all the rows and columns in the employees table:

SELECT*FROM employees;

-- B. select data from the employee id, first name, last name, and hire date of all rows in the employees table:

SELECT employee_id, first_name, last_name, hire_date
FROM employees;

-- C. to get the first name, last name, salary, and new salary:
-- D. Increase the salary two times and named as New_SALARY from employees table

SELECT first_name, last_name, salary, (salary*2) New_Salary
FROM employees;

-- 2) WRITE A QUERY FOR ORDER BY STATEMENTS :-

-- A. returns the data from the employee id, first name, last name, hire date, and salary column of the employees table:

SELECT employee_id, first_name, last_name, hire_date, salary
FROM employees
ORDER By employee_id;

-- B. to sort employees by first names in alphabetical order:

SELECT *
FROM employees
ORDER By first_name ASC;

-- C. to sort the employees by the first name in ascending order and the last name in descending order:

SELECT *
FROM employees
ORDER By first_name ASC, last_name DESC;

-- D. to sort employees by salary from high to low:

SELECT *
FROM employees
ORDER By salary DESC;

-- E. to sort the employees by values in the hire_date column from:

SELECT *
FROM employees
ORDER By hire_date ASC;

-- F. sort the employees by the hire dates in descending order:

SELECT *
FROM employees
ORDER By hire_date DESC;

-- 3) WRITE A QUERY FOR DISTINCT STATEMENTS :-

-- A. selects the salary data from the salary column of the employees table and sorts them from high to low:

SELECT DISTINCT salary 
FROM employees 
ORDER BY salary DESC;

-- B. select unique values from the salary column of the employees table:

SELECT DISTINCT salary 
FROM employees;

-- C. selects the job id and salary from the employees table:

SELECT job_id, salary
FROM employees;

-- D. to remove the duplicate values in job id and salary:

SELECT DISTINCT job_id, salary
FROM employees;

-- E. returns the distinct phone numbers of employees:

SELECT DISTINCT phone_number 
FROM employees;

-- 4) WRITE A QUERY FOR TOP N STATEMENTS :-

-- A. returns all rows in the employees table sorted by the first_name column

SELECT*
FROM employees
ORDER By first_name;

-- B. to return the first 5 rows in the result set returned by the SELECT clause:

SELECT TOP 5 *
FROM employees

-- C. to return five rows starting from the 4th row:

SELECT *
FROM employees
ORDER By employee_id
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY;

-- D. gets the top five employees with the highest salaries.

SELECT TOP 5 *
FROM employees
ORDER By salary DESC;

-- E. to get employees who have the 2nd highest salary in the company

SELECT *
FROM employees
ORDER By salary DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY;

-- 5) WRITE A QUERY FOR WHERE CLAUSE and COMPARISON OPERATORS :-

-- A. query finds employees who have salaries greater than 14,000 and sorts the results sets based on the salary in descending order.

SELECT *
FROM employees
WHERE salary > 14000
ORDER By salary DESC;

-- B. query finds all employees who work in the department id 5.

SELECT *
FROM employees
WHERE department_id = 5;

-- C. query finds the employee whose last name is Chen

SELECT *
FROM employees
WHERE last_name = 'Chen';

-- D. To get all employees who joined the company after January 1st, 1999

SELECT *
FROM employees
WHERE hire_date > '1999-01-01';

-- E. to find the employees who joined the company in 1999,

SELECT *
FROM employees
WHERE YEAR(hire_date) = '1999';

-- F. statement finds the employee whose last name is Himuro

SELECT *
FROM employees
WHERE last_name = 'Himuro';

-- G. the query searches for the string Himuro in the last_name column of the employees table.

SELECT *
FROM employees
WHERE last_name LIKE '%Himuro%';

-- H. to find all employees who do not have phone numbers:

SELECT *
FROM employees
WHERE phone_number IS NULL;


-- I. returns all employees whose department id is not 8.

SELECT *
FROM employees
WHERE department_id != 8;

-- J. finds all employees whose department id is not eight and ten.

SELECT *
FROM employees
WHERE department_id NOT IN (10,8);

-- K. to find the employees whose salary is greater than 10,000,

SELECT *
FROM employees
WHERE salary > 10000;

-- L. finds employees in department 8 and have the salary greater than 10,000:

SELECT *
FROM employees
WHERE department_id = 8 AND salary > 10000;

-- M. the statement below returns all employees whose salaries are less than 10,000.

SELECT *
FROM employees
WHERE salary < 10000;

-- N. finds employees whose salaries are greater than or equal 9,000:

SELECT *
FROM employees
WHERE salary >= 9000;

-- O. finds employees whose salaries are less than or equal to 9,000:

SELECT *
FROM employees
WHERE salary <= 9000;

-- 6) WRITE A QUERY FOR:-

-- Created courses table as it does not existed before

CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_name VARCHAR (25) DEFAULT NULL);

-- A. adds a new column named credit_hours to the courses table.

ALTER TABLE courses
ADD credit_hours INT;

-- B. adds the fee and max_limit columns to the courses table and places these columns after the course_name column.

-- Note this is only possible in MySQL

/* ALTER TABLE courses
ADD fee DECIMAL(10,2) AFTER course_name,
ADD max_limit INT AFTER fee; */
ALTER TABLE courses
ADD fee DECIMAL(10,2),
    max_limit INT;

-- C. changes the attribute of the fee column to NOT NULL

ALTER TABLE courses
ALTER COLUMN fee DECIMAL(10,2) NOT NULL;

-- D. to remove the fee column of the courses table

ALTER TABLE courses
DROP COLUMN fee;

-- E. removes the max_limit and credit_hours of the courses table.

ALTER TABLE courses
DROP COLUMN max_limit, credit_hours;

-- 6) WRITE A QUERY FOR (Foreign Key Constraints ):-

CREATE TABLE projects (
 project_id INT PRIMARY KEY,
 project_name VARCHAR(255),
 start_date DATE NOT NULL,
 end_date DATE NOT NULL
);

CREATE TABLE project_milestones(
 milestone_id INT PRIMARY KEY,
 project_id INT,
 milestone_name VARCHAR(100)
);


-- A. to add an SQL FOREIGN KEY constraint to the project_milestones table to enforce the relationship between the projects and project_milestones tables
-- B. Suppose the project_milestones already exists without any predefined foreign key and you want to define a FOREIGN KEY constraint for the project_id column so write a Query to add a FOREIGN KEY constraint to existing table

ALTER TABLE project_milestones
ADD CONSTRAINT FK_ProjectMilestones_Projects FOREIGN KEY (project_id) REFERENCES projects(project_id);

-- TASK 2:

-- 1) WRITE A QUERY FOR LOGICAL OPERATORS and OTHER ADVANCED OPERATORS:-

-- PART 1:-

-- A. finds all employees whose salaries are greater than 5,000 and less than 7,000:

SELECT *
FROM employees
WHERE salary > 5000 AND salary < 7000;

-- B. finds employees whose salary is either 7,000 or 8,000:

SELECT *
FROM employees
WHERE salary IN (7000,8000);

-- C. finds all employees who do not have a phone number:

SELECT *
FROM employees
WHERE phone_number IS NULL;

-- D. finds all employees whose salaries are between 9,000 and 12,000.

SELECT *
FROM employees
WHERE salary BETWEEN 9000 AND 12000;

-- E. finds all employees who work in the department id 8 or 9.

SELECT *
FROM employees
WHERE department_id IN (8,9);

-- F. finds all employees whose first name starts with the string jo

SELECT *
FROM employees
WHERE first_name LIKE 'jo%';

-- G. finds all employees with the first names whose the second character is h

SELECT *
FROM employees
WHERE first_name LIKE '_h%';

-- H. finds all employees whose salaries are greater than all salaries of employees in the department 8:

SELECT *
FROM employees
WHERE salary > ALL(
SELECT salary
FROM employees
WHERE department_id = 8);

-- Part 2:-

-- A. finds all employees whose salaries are greater than the average salary of every department:

SELECT *
FROM employees
WHERE salary > ALL(SELECT AVG(salary) FROM employees GROUP By department_id);

-- C. to find all employees whose salaries are between 2,500 and 2,900:

SELECT *
FROM employees
WHERE salary BETWEEN 2500 AND 2900;

-- D. to find all employees whose salaries are not in the range of 2,500 and 2,900:

SELECT *
FROM employees
WHERE NOT salary BETWEEN 2500 AND 2900;

-- E. to find all employees who joined the company between January 1, 1999, and December 31, 2000:

SELECT *
FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2000-12-31';

-- F. to find employees who have not joined the company from January 1, 1989 to December 31, 1999:

SELECT * 
FROM employees
WHERE NOT hire_date BETWEEN '1989-01-01' AND '1999-12-31';

-- G. to find employees who joined the company between 1990 and 1993:

SELECT *
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1993;

-- Part 3:-

-- A. to find all employees whose first names start with Da

SELECT *
FROM employees
WHERE first_name LIKE 'Da%';

-- B. to find all employees whose first names end with er

SELECT *
FROM employees
WHERE first_name LIKE '%er';

-- C. to find employees whose last names contain the word an:

SELECT *
FROM employees
WHERE last_name LIKE '%an%';

-- D. retrieves employees whose first names start with Jo and are followed by at most 2 characters:

SELECT *
FROM employees
WHERE first_name LIKE 'Jo'
OR first_name LIKE 'Jo_'
OR first_name LIKE 'JO__';

-- E. to find employees whose first names start with any number of characters and are followed by at most one character
-- Note: This question is phrased ambiguously in the PDF. 
-- Standard interpretation for wildcard practice is utilizing the underscore (_).
-- Below matches any name with at least one character.

SELECT * FROM employees WHERE first_name LIKE '%_';


-- F. to find all employees whose first names start with the letter S but not start with Sh:

SELECT * 
FROM employees
WHERE first_name LIKE 'S%'
AND NOT first_name LIKE 'Sh%';

-- Part 4:-

-- A. retrieves all employees who work in the department id 5.

SELECT *
FROM employees
WHERE department_id = 5;

-- B. To get the employees who work in the department id 5 and with a salary not greater than 5000

SELECT *
FROM employees
WHERE department_id = 5
AND salary <= 5000;

-- C. statement gets all the employees who are not working in the departments 1, 2, or 3

SELECT *
FROM employees
WHERE department_id NOT IN (1,2,3);

-- D. retrieves all the employees whose first names do not start with the letter D.

SELECT *
FROM employees
WHERE first_name NOT LIKE 'D%';

-- E. to get employees whose salaries are not between 5,000 and 1,000.

SELECT *
FROM employees
WHERE salary NOT BETWEEN 1000 AND 5000;

-- Part 5:-

-- A. Write a query to get the employees who do not have any dependents by above image

SELECT *
FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM dependents);

-- B. To find all employees who do not have the phone numbers

SELECT *
FROM employees
WHERE phone_number IS NULL;

-- C. To find all employees who have phone numbers

SELECT *
FROM employees
WHERE phone_number IS NOT NULL;

-- TASK 3:

-- JOINS:

-- Write a Query to
-- A. To get the information of the department id 1,2, and 3

SELECT*
FROM departments
WHERE department_id IN (1,2,3);

-- B. To get the information of employees who work in the department id 1, 2 and 3

SELECT *, DP.department_name, DP.location_id
FROM employees ED
INNER JOIN departments DP ON DP.department_id = ED.department_id
WHERE ED.department_id IN (1,2,3);

-- Write a Query to get the first name, last name, job title, and department name of employees who work in department id 1, 2, and 3.

SELECT ED.first_name, ED.last_name,JB.job_title, DP.department_name
FROM employees ED
INNER JOIN departments DP ON DP.department_id = ED.department_id
INNER JOIN jobs JB ON JB.job_id = ED.job_id
WHERE ED.department_id IN (1,2,3);

-- SQL LEFT JOIN clause

-- A. To query the country names of US, UK, and China (USED country code CN for China)

SELECT *
FROM countries
WHERE country_id IN ('US', 'UK', 'CN');

-- B. query retrieves the locations located in the US, UK and China:

SELECT *
FROM locations
WHERE country_id IN ('US', 'UK', 'CN');

-- C. To join the countries table with the locations table

SELECT c.country_name, l.street_address, l.city
FROM locations l
LEFT JOIN countries c ON c.country_id = l.country_id;

-- D. to find the country that does not have any locations in the locations table

SELECT c.country_name
FROM countries c
LEFT JOIN locations l ON c.country_id = l.country_id
WHERE l.location_id IS NULL;

-- Write a query to join 3 tables: regions, countries, and locations

SELECT R.region_name, c.country_name, l.city
FROM regions R
INNER JOIN countries c ON c.region_id = R.region_id
INNER jOIN locations l ON c.country_id = l.country_id;

-- SQL self-join

-- The manager_id column specifies the manager of an employee. Write a query statement to joins the employees table to itself to query the information of who reports to whom.

SELECT CONCAT(e.first_name, ' ',e.last_name) AS Employee, CONCAT(m.first_name,' ',m.last_name)AS Manager
FROM employees e
INNER JOIN employees m ON e.manager_id = m.employee_id

-- Now write a Query To include the president in the result set:-

SELECT CONCAT(e.first_name, ' ',e.last_name) AS Employee, CONCAT(m.first_name,' ',m.last_name)AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id

-- SQL FULL OUTER JOIN clause

-- Creating Tables
CREATE TABLE fruits (
fruit_id INT PRIMARY KEY,
fruit_name VARCHAR (255) NOT NULL,
basket_id INTEGER
);

CREATE TABLE baskets (
basket_id INT PRIMARY KEY,
basket_name VARCHAR (255) NOT NULL
);

-- Inserting Records

INSERT INTO baskets (basket_id, basket_name)
VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

INSERT INTO fruits (
fruit_id,
fruit_name,
basket_id
)
VALUES
(1, 'Apple', 1),
(2, 'Orange', 1),
(3, 'Banana', 2),
(4, 'Strawberry', NULL);

--A. Write a query to returns each fruit that is in a basket and each basket that has a fruit, but also returns each fruit that is not in any basket and each basket that does not have any fruit.

SELECT 
    f.fruit_name, 
    b.basket_name
FROM fruits f
FULL OUTER JOIN baskets b ON f.basket_id = b.basket_id;

-- B. Write a query to find the empty basket, which does not store any fruit
SELECT 
    f.fruit_name, 
    b.basket_name
FROM fruits f
FULL OUTER JOIN baskets b ON f.basket_id = b.basket_id
WHERE f.fruit_id IS NULL;

-- C. Write a query which fruit is not in any basket

SELECT 
    f.fruit_name, 
    b.basket_name
FROM fruits f
FULL OUTER JOIN baskets b ON f.basket_id = b.basket_id
WHERE b.basket_id IS NULL;

-- SQL CROSS JOIN clause

-- Creating Table

CREATE TABLE sales_organization (
sales_org_id INT PRIMARY KEY,
sales_org VARCHAR (255)
);

CREATE TABLE sales_channel (
channel_id INT PRIMARY KEY,
channel VARCHAR (255)
);

-- Inserting Records

INSERT INTO sales_organization (sales_org_id, sales_org)
VALUES
(1, 'Domestic'),
(2, 'Export');

INSERT INTO sales_channel (channel_id, channel)
VALUES
(1, 'Wholesale'),
(2, 'Retail'),
(3, 'eCommerce'),
(4, 'TV Shopping');

-- Write a Query To find the all possible sales channels that a sales organization

SELECT 
    so.sales_org, 
    sc.channel
FROM sales_organization so
CROSS JOIN sales_channel sc;

-- TASK 4:

-- SQL GROUP BY clause

-- A. to group the values in department_id column of the employees table:

SELECT department_id
FROM employees
GROUP By department_id;


-- B. to count the number of employees by department:
-- C. returns the number of employees by department

SELECT department_id, COUNT(*) AS NoOfEmployee
FROM employees
GROUP By department_id;

-- D. to sort the departments by headcount:

SELECT department_id, COUNT(*) AS NoOfEmployee
FROM employees
GROUP By department_id
ORDER By NoOfEmployee DESC;

-- E. to find departments with headcounts are greater than 5:

SELECT department_id, COUNT(*) AS NoOfEmployee
FROM employees
GROUP By department_id
HAVING COUNT(*) > 5
ORDER By NoOfEmployee DESC;

-- F. returns the minimum, maximum and average salary of employees in each department

SELECT department_id, MIN(salary) AS Minimum_Salary, MAX(salary) AS Maximum_Salary, AVG(salary) AS Average_Salary
FROM employees
GROUP By department_id;

-- G. To get the total salary per department,

SELECT department_id ,SUM(salary) AS TotalSalary
FROM employees
GROUP By department_id;

-- H. groups rows with the same values both department_id and job_id columns in the same group then return the rows for each of these groups

SELECT department_id, job_id, COUNT(employee_id) AS headcount
FROM employees
GROUP By department_id,job_id;

-- SQL HAVING clause

-- A. To get the managers and their direct reports, and to group employees by the managers and to count the direct reports.

SELECT M.employee_id AS Manager_id, M.first_name AS Manager_Name, COUNT(E.employee_id) AS direct_report_count
FROM employees E
JOIN employees M ON E.manager_id = M.employee_id
GROUP By M.employee_id, M.first_name;

-- B. To find the managers who have at least five direct reports

SELECT M.employee_id AS Manager_id, M.first_name AS Manager_Name, COUNT(E.employee_id) AS direct_report_count
FROM employees E
JOIN employees M ON E.manager_id = M.employee_id
GROUP By M.employee_id, M.first_name
HAVING COUNT(E.employee_id) >= 5;

-- C. calculates the sum of salary that the company pays for each department and selects only the departments with the sum of salary between 20000 and 30000.

SELECT department_id, SUM(salary) AS TotalSalary
FROM employees
GROUP By department_id
HAVING SUM(salary) BETWEEN 20000 AND 30000;

-- D. To find the department that has employees with the lowest salary greater than 10000

SELECT department_id, MIN(salary) AS MinimumSalary
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 10000;

-- E. To find the departments that have the average salaries of employees between 5000 and 7000

SELECT department_id, AVG(salary) AS AverageSalary
FROM employees
GROUP By department_id
HAVING AVG(salary) BETWEEN 5000 AND 7000;

-- TASK 5:

-- 1) SQL UNION operator

-- Write a Query to combine the first name and last name of employees and dependents

SELECT 
    first_name + ' ' + last_name AS FullName,
    'Employee' AS Person_Type
FROM employees

UNION ALL

SELECT 
    first_name + ' ' + last_name AS FullName,
    'Dependent' AS Person_Type
FROM dependents;

-- 2) SQL INTERSECT operator

--Write a Query to Applies the INTERSECT operator to the A and B tables and sorts the combined result set by the id column in descending order.

-- Will not work as Table A and B not availble

SELECT id FROM A
INTERSECT
SELECT id FROM B
ORDER BY id DESC;

-- 3) SQL EXISTS operator

-- A. finds all employees who have at least one dependent.
SELECT employee_id, first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM dependents d 
    WHERE d.employee_id = e.employee_id
);

-- B . finds employees who do not have any dependents:

SELECT employee_id, first_name, last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM dependents d 
    WHERE d.employee_id = e.employee_id
);

-- 4) SQL CASE expression

-- A. Suppose the current year is 2000. How to use the simple CASE expression to get the work anniversaries of employees by 

SELECT 
    first_name, 
    last_name, 
    hire_date,
    CASE 
        WHEN DATEPART(year, hire_date) = 2000 THEN 'New Hire'
        ELSE CONCAT(DATEDIFF(year, hire_date, '2000-01-01'), ' Years Anniversary')
    END AS anniversary_status
FROM employees;

-- B. Write a Query If the salary is less than 3000, the CASE expression returns “Low”. If the salary is between 3000 and 5000, it returns “average”. When the salary is greater than 5000, the CASE expression returns “High”

SELECT first_name, salary, 
CASE
	WHEN salary < 3000 THEN 'Low'
	WHEN salary BETWEEN 3000 AND 5000 THEN 'Average'
	WHEN salary > 5000 THEN 'High'
END AS Salary_level
FROM employees;

-- 5) SQL UPDATE statement

-- Suppose the employee id 192 Sarah Bell changed her last name from Bell to Lopez and you need to update her record in the employees table.

UPDATE employees
SET last_name = 'Lopez'
WHERE employee_id = '192';

-- FINAL TASK (Advanced Queries)

-- A. Combine Above two queries using subquery inorder find all departments located at the location whose id is 1700 and find all employees that belong to the location 1700 by using the department id list of the previous query

SELECT *
FROM employees E
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700);

-- B. to find all employees who do not locate at the location 1700:

SELECT *
FROM employees
WHERE department_id NOT IN (SELECT department_id FROM departments WHERE location_id = 1700);

-- C. finds the employees who have the highest salary:

SELECT TOP 1 *
FROM employees
ORDER By salary DESC;

SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

-- D. finds all employees who salaries are greater than the average salary of all employees:

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)

-- E. finds all departments which have at least one employee with the salary is greater than 10,000:

SELECT department_id, department_name
FROM departments d
WHERE EXISTS(SELECT 1 FROM employees e WHERE e.department_id = d.department_id AND e.salary > 10000);

-- F. finds all departments that do not have any employee with the salary greater than 10,000:

SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS(SELECT 1 FROM employees e WHERE e.department_id = d.department_id AND e.salary > 10000);

-- G. to find the lowest salary by department:

SELECT department_id, MIN(salary) AS MinimumSalary
FROM employees
GROUP By department_id

-- H. finds all employees whose salaries are greater than the lowest salary of every department:

SELECT *
FROM employees
WHERE salary > ALL (SELECT MIN(salary) FROM employees GROUP BY department_id);

-- I. finds all employees whose salaries are greater than or equal to the highest salary of every department

SELECT *
FROM employees
WHERE salary >= ALL (SELECT MAX(salary) FROM employees GROUP BY department_id);

-- J. returns the average salary of every department

SELECT department_id, AVG(salary) AS AverageSalary
FROM employees
GROUP By department_id;

-- K. to calculate the average of average salary of departments :

SELECT AVG(avg_salary) AS average_of_averages
FROM (
    SELECT AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_averages;

-- L. finds the salaries of all employees, their average salary, and the difference between the salary of each employee and the average salary.
use 
SELECT first_name, last_name, salary, (SELECT AVG(salary) FROM employees) AS AverageSalary, salary - (SELECT AVG(salary) FROM employees) AS SalaryDifference
FROM employees





/*

1. Payroll Skew & Salary Variance
With a company-wide average salary of $8,002.50, our distribution is heavily "top-heavy."

The Outlier Problem: Steven King (+15,997.50 variance) and the executive team (Kochhar and De Haan at +8,997.50) significantly pull the mean upward.

The Compression Zone: We have a cluster of employees (Khoo, Baida, Tobias, Himuro, Colmenares) sitting $5,000+ below the average.

Data Insight: When the variance is this wide, the "Average Salary" is a deceptive metric. We should be looking at the Median Salary for a truer sense of what a typical employee earns. The negative variance for 60% of the staff suggests a potential morale or retention risk at the junior-to-mid levels.

2. Management Span & Operational Bottlenecks
The join between employees and their managers reveals a major "Span of Control" issue.

Steven (ID 100) is currently managing 15 direct reports.

Data Insight: In high-performance environments, once a manager exceeds 8–10 reports, they lose the ability to provide meaningful 1-on-1 development. Steven is likely a bottleneck for departmental approvals.

Optimization: We should look at promoting high-performers under Steven (like Neena or Nancy, who already manage 5 people each) to absorb some of his direct reports.

3. Departmental Spend vs. Strategy
Grouping by department_id shows where our capital is actually flowing:

High-Cost Centers: Department 9 (Executive) at $64,000 and Department 8 (Sales) at $57,700 represent the bulk of our OpEx.

The Skeleton Crews: Department 1 (Administration) at $4,400 and Department 11 (Accounting) at $12,000 seem lean compared to the size of the total payroll they have to process.

Data Insight: We are spending nearly 10x more on Sales than on HR/Admin. While Sales drives revenue, we need to ensure our "back-office" infrastructure (Departments 1, 4, and 11) can support the administrative load of the higher-headcount departments.

4. Geographic "Ghost" Footprint
The LEFT JOIN between countries and locations highlights a significant discrepancy.

The Gap: We have 21 countries registered in our database (from Argentina to Zimbabwe), but our employee distribution is concentrated in just a few locations (US, UK, CA, DE).

Data Insight: Maintaining entities in 21 countries without active employees or locations is "Administrative Bloat." Every country on that list requires legal and tax compliance.

Key Recommendations
Leveling: Review the "Negative Variance" group. If these are "Programmers" or "Accountants," they are likely being underpaid relative to the internal average, making them easy targets for recruiters.

Structural Reorg: Offload at least 5 of Steven’s direct reports to mid-level managers to improve decision-making speed.

Entity Consolidation: Investigate the cost of maintaining the "Ghost" countries. If there’s no immediate plan to hire in Nigeria or Switzerland, we should consider de-registering those entities to save on compliance costs.*/