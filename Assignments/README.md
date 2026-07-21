# SQL Assignments

A collection of SQL assignments completed as part of the CoachX training program. Each assignment builds a small database, loads sample data, and solves a set of query challenges that move from basics to advanced topics. Every assignment includes a `.sql` script and a `.pdf` brief with the questions.

Maintained by **Chetan Parmar**.

---

## About this directory

This folder groups hands-on SQL exercises using Microsoft SQL Server. The assignments cover the full range of practical database skills: creating databases and tables, inserting records, filtering and sorting, joins, aggregation, subqueries, views, stored procedures, and triggers.

---

## Assignments

| # | Assignment | Database and tables | Focus |
|---|------------|---------------------|-------|
| 1 | Items and Products Database | Brands, Products (ITEMS_TABLE, PRODUCTS_SALES_TABLE) | Basics to super-advanced: filtering, joins, subqueries, procedures, triggers |
| 2 | Employee Details and Employee Salary | COACHX (EmployeeDetails, EmployeeSalary, ManagerDetails) | Classic SQL interview questions and multi-table logic |
| 3 | University DBMS | SGVU (College, Department, Professor, Student) | DDL, string and date functions, joins, views, procedures |
| 4 | SELECT, Update, Insert Queries | Uni (types, authors, students, books, borrows) | Library schema with 36 query and data-modification exercises |

---

## Assignment details

### 1. Items and Products Database
Creates two databases (Brands and Products) with an items table and a product sales table, then works through four difficulty tiers:
- **Basics:** create, insert, delete, SELECT, WHERE filters, DISTINCT, COUNT.
- **Intermediate:** totals, highest sales year, per-country aggregates, MAX profit, subqueries, primary keys.
- **Advanced:** INNER, FULL OUTER and LEFT joins, top N, GROUP BY, string splitting, conditional aggregates.
- **Super-advanced:** correlated subqueries, stored procedures, a trigger to auto-update gross sales, and string and date functions.

### 2. Employee Details and Employee Salary
Builds an employee, salary, and manager schema and answers common SQL interview style questions: records in one table but not another, employees without projects, joins across tables, project-wise employee counts, the third highest salary without TOP or LIMIT, odd rows, and employees reporting to a given manager.

### 3. University DBMS
Models a university with college, department, professor, and student tables linked by foreign keys. Organised into three tasks:
- **Task 1:** create the schema and insert 10 records per table.
- **Task 2:** SELECT queries, string and date functions, adding and altering columns, and totals.
- **Task 3:** joins, handling NULLs, creating a view, a stored procedure by professor ID, and renaming a table.

### 4. SELECT, Update, Insert Queries
Uses a library database (types, authors, students, books, borrows) to practise a broad set of query skills across 36 exercises: filtering with WHERE, IN, LIKE and BETWEEN, sorting, TOP N, CONCAT, date functions, grouping, and INSERT and UPDATE statements.

---

## Directory structure

```
Assignments/
|-- CoachX Assignment 1 Items Product DB.sql
|-- Assignment 1 Items Product DB.pdf
|-- CoachX Assignment 2 Employee Details Employee Salary.sql
|-- Assignment 2 Employee Details Employee Salary.pdf
|-- CoachX Assignment 3 University DBMS.sql
|-- Assignment 3 University DBMS.pdf
|-- CoachX Assignment 4 SELECT, Update, Insert Queries.sql
|-- Assignment 4 SELECT, Update, Insert Queries.pdf
|-- README.md
```

---

## How to use

1. Open the `.pdf` brief for the assignment you want to review to read the questions.
2. Open the matching `.sql` script in SQL Server Management Studio (SSMS) or Azure Data Studio.
3. Run the create and insert sections first to build the database and load data.
4. Run the query blocks in order. Each query is labelled with a comment showing which question it answers.

---

## Tools and skills

- **Database:** Microsoft SQL Server
- **Client:** SQL Server Management Studio (SSMS) / Azure Data Studio
- **Language:** SQL (T-SQL)
- **Skills covered:** DDL and DML, filtering and sorting, joins, aggregation and grouping, subqueries, views, stored procedures, triggers, and string and date functions

---

## Author

**Chetan Parmar**

GitHub: [@ChetanParmarHQ](https://github.com/ChetanParmarHQ)

---

*These assignments are part of a wider SQL portfolio focused on practical database skills.*

