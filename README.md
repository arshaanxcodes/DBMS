# Database Management Systems (DBMS) Laboratory

## Course Information
- **Course**: Database Management Systems (DBMS) Lab
- **Degree**: B.Tech Computer Science & Engineering
- **Database Engine**: MySQL 8.0 (InnoDB Storage Engine)

---

## Laboratory Index: Experiments 1–6

| Experiment | Title | Core Concepts | Status |
| :--- | :--- | :--- | :--- |
| **Experiment 1** | Entity-Relationship (ER) Modeling | Conceptual design, Indian e-commerce domain, weak entities, multi-valued/composite attributes, specialization hierarchy, structural constraints | Completed |
| **Experiment 2** | Relational Schema & Referential Integrity | DDL table creation, primary/foreign keys, `NOT NULL`, `UNIQUE`, `ON DELETE CASCADE`, `ON DELETE SET NULL`, constraint enforcement, sample data | Completed |
| **Experiment 3** | DDL, DML & Basic SQL Query Operations | 5 departments, 32 employees, 10 projects, selection, projection, aggregates, `GROUP BY`, `HAVING`, `CASE`, `ORDER BY` | Completed |
| **Experiment 4** | Advanced Joins, Subqueries & Execution Plans | `INNER JOIN`, `LEFT JOIN`, `SELF JOIN`, 3-way join, correlated subqueries, `EXISTS`, simulated `INTERSECT`, simulated `EXCEPT`, `EXPLAIN` analysis | Completed |
| **Experiment 5** | Database Views & Recursive Hierarchies | Aggregate view, hierarchy view, view updatability rules, recursive Common Table Expression (CTE) reporting chains | Completed |
| **Experiment 6** | Stored Procedures, Triggers & Transactions | `transfer_employee` procedure, input validation, error handling, rollback, salary constraint triggers, audit logging | Completed |

---

## Repository Structure

```
DBMS/
├── Experiment-1/
│   ├── ER_Diagram.png             # High-resolution (300 DPI) ER Diagram
│   ├── ER_Diagram.pdf             # Printable scalable vector ER Diagram
│   └── README.md                  # Conceptual model documentation & entity dictionary
├── Experiment-2/
│   ├── schema.sql                 # E-commerce relational DDL (13 tables)
│   ├── sample_data.sql            # Indian e-commerce sample dataset
│   ├── referential_integrity.sql  # CASCADE & SET NULL validation statements
│   ├── violations.sql             # Negative test cases for constraint enforcement
│   └── README.md                  # Relational mapping & integrity documentation
├── Experiment-3/
│   ├── schema.sql                 # Enterprise DDL (departments, employees, projects)
│   ├── sample_data.sql            # Enterprise dataset (5 depts, 32 emps, 10 projects)
│   ├── queries.sql                # Selection, projection, aggregates, grouping, CASE
│   └── README.md                  # Query taxonomy & schema specifications
├── Experiment-4/
│   ├── queries.sql                # Inner/left/self/3-way joins, correlated subqueries, set ops
│   ├── explain_plans.sql          # Query optimizer EXPLAIN and FORMAT=TREE plans
│   └── README.md                  # Join mechanics & execution plan analysis
├── Experiment-5/
│   ├── views.sql                  # Salary summary, hierarchy, and update views
│   ├── view_updatability.sql      # Positive & negative view updatability verification
│   ├── recursive_cte.sql          # Multi-level hierarchical recursive CTEs
│   └── README.md                  # View updatability rules & recursion documentation
├── Experiment-6/
│   ├── procedure.sql              # Stored procedure transfer_employee
│   ├── triggers.sql               # Salary validation triggers & audit logger
│   ├── test_cases.sql             # Negative edge cases, positive transfer & audit test
│   └── README.md                  # Transaction workflow & trigger specifications
├── College website ER.drawio      # Preserved reference drawing
├── Copy of CU Lucknow - DBMS Curriculum.pdf # Preserved course curriculum
└── README.md                      # Laboratory overview and execution manual
```

---

## How to Execute SQL Files in MySQL

All SQL scripts are valid, clean, directly executable, and free of comments.

### 1. Prerequisites
Ensure the MySQL Server 8.0 service is running:
```bash
# Windows PowerShell
Get-Service MySQL80
```

### 2. Experiments 1 & 2: E-Commerce Platform
Create the database and execute:
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ecommerce;"
mysql -u root -p ecommerce < Experiment-2/schema.sql
mysql -u root -p ecommerce < Experiment-2/sample_data.sql
mysql -u root -p ecommerce < Experiment-2/referential_integrity.sql
```

### 3. Experiments 3, 4, 5 & 6: Enterprise Platform
Create the database and execute:
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS company_db;"

# Experiment 3: Schema, Data & Basic Queries
mysql -u root -p company_db < Experiment-3/schema.sql
mysql -u root -p company_db < Experiment-3/sample_data.sql
mysql -u root -p company_db < Experiment-3/queries.sql

# Experiment 4: Advanced Joins & Explain Plans
mysql -u root -p company_db < Experiment-4/queries.sql
mysql -u root -p company_db < Experiment-4/explain_plans.sql

# Experiment 5: Views & Recursive CTE
mysql -u root -p company_db < Experiment-5/views.sql
mysql -u root -p company_db < Experiment-5/view_updatability.sql
mysql -u root -p company_db < Experiment-5/recursive_cte.sql

# Experiment 6: Stored Procedure, Triggers & Test Cases
mysql -u root -p company_db < Experiment-6/procedure.sql
mysql -u root -p company_db < Experiment-6/triggers.sql
mysql -u root -p company_db < Experiment-6/test_cases.sql
```

---

## Expected Errors in Test Suites

The test suites intentionally test constraint boundaries and exception handling. The following error codes are expected and indicate correct database constraint enforcement:

| File | Statement / Operation | Expected MySQL Error | Description |
| :--- | :--- | :--- | :--- |
| `Experiment-2/violations.sql` | `INSERT INTO orders` with `customer_id = 9999` | `ERROR 1452 (23000)` | Foreign key parent key not found |
| `Experiment-2/violations.sql` | `DELETE FROM sellers WHERE seller_id = 1` | `ERROR 1451 (23000)` | Foreign key RESTRICT prevents parent row deletion |
| `Experiment-2/violations.sql` | Duplicate email insertion in `customers` | `ERROR 1062 (23000)` | UNIQUE constraint violation |
| `Experiment-2/violations.sql` | `INSERT INTO products` with `title = NULL` | `ERROR 1048 (23000)` | Column cannot be null constraint violation |
| `Experiment-5/view_updatability.sql` | `UPDATE v_department_salary_summary` | `ERROR 1288 (HY000)` | Target view is non-updatable due to `GROUP BY` and aggregate functions |
| `Experiment-6/test_cases.sql` | `CALL transfer_employee(9999, 2)` | `ERROR 1644 (45000)` | User-defined signal: Employee does not exist |
| `Experiment-6/test_cases.sql` | `CALL transfer_employee(124, 999)` | `ERROR 1644 (45000)` | User-defined signal: Department does not exist |
| `Experiment-6/test_cases.sql` | `CALL transfer_employee(124, 1)` | `ERROR 1644 (45000)` | User-defined signal: Employee already assigned to this department |
| `Experiment-6/test_cases.sql` | `UPDATE employees SET salary = 5000.00` | `ERROR 1644 (45000)` | Intercepted by BEFORE UPDATE trigger: Salary cannot be less than 15000.00 |