# SQL-Projects

A collection of SQL projects that turn raw datasets into clear, decision-ready answers using structured queries. Each project lives in its own folder with its SQL script, supporting documents, and a dedicated README.

Maintained by **Chetan Parmar**.

---

## About this repository

This repository is a growing portfolio of hands-on SQL work. Every project follows the same idea: take a real or sample dataset, model it in a relational database, and answer practical business questions through progressively richer queries (retrieval, filtering, joins, aggregation, and subqueries).

The repository also includes an **Assignments** directory with focused SQL practice tasks that build core database skills from basics to advanced topics.

New projects will be added over time, each as a self-contained folder.

---

## Projects

| # | Project | Description | Tech | Status |
|---|---------|-------------|------|--------|
| 1 | [HR Database Management System](./Project%201%20HR%20Database%20Management%20System) | A relational HR database modelling employees, departments, jobs, and geography, queried end to end with SQL. | SQL / MS SQL Server | Complete |

*More projects coming soon.*

---

## Assignments

The [Assignments](./Assignments) directory contains four CoachX SQL assignments, each with a `.sql` script and a `.pdf` brief.

| # | Assignment | Focus |
|---|------------|-------|
| 1 | Items and Products Database | Filtering, joins, subqueries, stored procedures, and triggers |
| 2 | Employee Details and Employee Salary | Classic SQL interview questions and multi-table logic |
| 3 | University DBMS | DDL, string and date functions, joins, views, and procedures |
| 4 | SELECT, Update, Insert Queries | Library schema with query and data-modification exercises |

See the README inside the Assignments folder for full details.

---

## Repository structure

```
SQL-Projects/
|
|-- Project 1 HR Database Management System/
|   |-- HR Database Management System.sql     # All SQL queries and solutions
|   |-- HR Database Management System.pdf     # Project brief and documentation
|   |-- Entity-Relationships.jpg              # ER diagram of the schema
|   |-- README.md                             # Project-specific README
|
|-- Assignments/
|   |-- CoachX Assignment 1 Items Product DB.sql
|   |-- Assignment 1 Items Product DB.pdf
|   |-- CoachX Assignment 2 Employee Details Employee Salary.sql
|   |-- Assignment 2 Employee Details Employee Salary.pdf
|   |-- CoachX Assignment 3 University DBMS.sql
|   |-- Assignment 3 University DBMS.pdf
|   |-- CoachX Assignment 4 SELECT, Update, Insert Queries.sql
|   |-- Assignment 4 SELECT, Update, Insert Queries.pdf
|   |-- README.md                             # Assignments overview
|
|-- README.md                                 # You are here
```

Each future project will follow the same pattern:

```
Project N <Name>/
|-- <Name>.sql        # Query script
|-- <Name>.pdf        # Brief or documentation (optional)
|-- README.md         # Project overview
|-- assets/           # Diagrams, screenshots, exports (optional)
```

---

## How to use these projects

1. Open the folder for the project or assignment you are interested in.
2. Read that folder's README for context, schema, and objectives.
3. Open the `.sql` file in your SQL client (SQL Server Management Studio, Azure Data Studio, or similar).
4. Run the setup or schema section first, then execute the query blocks in order.
5. Compare your results with the findings described in the README.

---

## Tools and technologies

- **Database:** Microsoft SQL Server
- **Client:** SQL Server Management Studio (SSMS) / Azure Data Studio
- **Language:** SQL (T-SQL)
- **Skills covered:** data retrieval, filtering, operators, joins, grouping and aggregation, set operations, conditional logic, and subqueries

---

## Roadmap

- [x] Project 1: HR Database Management System
- [x] Assignments: four CoachX SQL practice sets
- [ ] Additional SQL projects (data analysis, reporting, and case studies)

---

## Author

**Chetan Parmar**

GitHub: [@ChetanParmarHQ](https://github.com/ChetanParmarHQ)

---

*This repository is maintained as a learning and portfolio project. Feedback and suggestions are always welcome.*
