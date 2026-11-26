# Database Management Systems (DBMS) Laboratory

## Course Information
- **Course**: Database Management Systems (DBMS) Lab
- **Degree**: B.Tech Computer Science & Engineering
- **Database Engine**: MySQL 8.0 (InnoDB Storage Engine)

---

## Laboratory Index: Experiments 1–10

| Experiment | Title | Core Concepts | Status |
| :--- | :--- | :--- | :--- |
| **Experiment 1** | Entity-Relationship (ER) Modeling | Conceptual design, Indian e-commerce domain, weak entities, multi-valued/composite attributes, specialization hierarchy, structural constraints | Completed |
| **Experiment 2** | Relational Schema & Referential Integrity | DDL table creation, primary/foreign keys, `NOT NULL`, `UNIQUE`, `ON DELETE CASCADE`, `ON DELETE SET NULL`, constraint enforcement, sample data | Completed |
| **Experiment 3** | DDL, DML & Basic SQL Query Operations | 5 departments, 32 employees, 10 projects, selection, projection, aggregates, `GROUP BY`, `HAVING`, `CASE`, `ORDER BY` | Completed |
| **Experiment 4** | Advanced Joins, Subqueries & Execution Plans | `INNER JOIN`, `LEFT JOIN`, `SELF JOIN`, 3-way join, correlated subqueries, `EXISTS`, simulated `INTERSECT`, simulated `EXCEPT`, `EXPLAIN` analysis | Completed |
| **Experiment 5** | Database Views & Recursive Hierarchies | Aggregate view, hierarchy view, view updatability rules, recursive Common Table Expression (CTE) reporting chains | Completed |
| **Experiment 6** | Stored Procedures, Triggers & Transactions | `transfer_employee` procedure, input validation, error handling, rollback, salary constraint triggers, audit logging | Completed |
| **Experiment 7** | Normalization (UNF to 3NF & BCNF) | Functional dependencies, UNF -> 1NF -> 2NF -> 3NF -> BCNF step-by-step decomposition, lossless join & dependency preservation verification | Completed |
| **Experiment 8** | Transactions, Savepoints & Isolation Levels | Banking transfers using `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, partial failure recovery, two-session isolation levels (`READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`) | Completed |
| **Experiment 9** | Indexing & Performance Benchmarks | `railway_bookings` table (6,000 rows), single-column & composite indexes, `EXPLAIN` and `EXPLAIN ANALYZE` before/after comparison | Completed |
| **Experiment 10** | Query Optimization on Large Datasets | 14,000-row dataset (`customers_large` + `orders_large`), 5 slow queries, `EXPLAIN ANALYZE`, indexing & query rewriting benchmarks | Completed |

---

## Certifications
- [Certificates/README.md](Certificates/README.md): HackerRank SQL (Basic) & Infosys Springboard SQL Developer certificates.

---

## Repository Structure

```
DBMS/
├── Certificates/
│   ├── HackerRank_SQL_Basic_Certificate.pdf
│   ├── Infosys_Springboard_SQL_Developer_Certificate.pdf
│   └── README.md
├── Experiment-1/
│   ├── ER_Diagram.png
│   ├── ER_Diagram.pdf
│   └── README.md
├── Experiment-2/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── referential_integrity.sql
│   ├── violations.sql
│   └── README.md
├── Experiment-3/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── queries.sql
│   └── README.md
├── Experiment-4/
│   ├── queries.sql
│   ├── explain_plans.sql
│   └── README.md
├── Experiment-5/
│   ├── views.sql
│   ├── view_updatability.sql
│   ├── recursive_cte.sql
│   └── README.md
├── Experiment-6/
│   ├── procedure.sql
│   ├── triggers.sql
│   ├── test_cases.sql
│   └── README.md
├── Experiment-7/
│   ├── unf_and_1nf.sql
│   ├── 2nf_and_3nf.sql
│   ├── bcnf.sql
│   ├── verify_normalization.sql
│   └── README.md
├── Experiment-8/
│   ├── schema_and_data.sql
│   ├── transactions_savepoints.sql
│   ├── isolation_session_a.sql
│   ├── isolation_session_b.sql
│   └── README.md
├── Experiment-9/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── benchmark_before_index.sql
│   ├── create_indexes.sql
│   ├── benchmark_after_index.sql
│   └── README.md
├── Experiment-10/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── slow_queries.sql
│   ├── optimize_indexes.sql
│   ├── optimized_queries.sql
│   └── README.md
├── College website ER.drawio
├── Copy of CU Lucknow - DBMS Curriculum.pdf
└── README.md
```

---

## How to Execute SQL Files in MySQL

All SQL scripts are valid, clean, directly executable, and free of comments.

### 1. Prerequisites
Ensure the MySQL Server 8.0 service is running:
```powershell
Get-Service MySQL80
```

### 2. Experiments 1 & 2: E-Commerce Platform (`ecommerce`)
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ecommerce;"
mysql -u root -p ecommerce < Experiment-2/schema.sql
mysql -u root -p ecommerce < Experiment-2/sample_data.sql
mysql -u root -p ecommerce < Experiment-2/referential_integrity.sql
```

### 3. Experiments 3–6: Enterprise Platform (`company_db`)
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS company_db;"
mysql -u root -p company_db < Experiment-3/schema.sql
mysql -u root -p company_db < Experiment-3/sample_data.sql
mysql -u root -p company_db < Experiment-3/queries.sql
mysql -u root -p company_db < Experiment-4/queries.sql
mysql -u root -p company_db < Experiment-4/explain_plans.sql
mysql -u root -p company_db < Experiment-5/views.sql
mysql -u root -p company_db < Experiment-5/view_updatability.sql
mysql -u root -p company_db < Experiment-5/recursive_cte.sql
mysql -u root -p company_db < Experiment-6/procedure.sql
mysql -u root -p company_db < Experiment-6/triggers.sql
mysql -u root -p company_db < Experiment-6/test_cases.sql
```

### 4. Experiment 7: Normalization (`sales_norm_db`)
```bash
mysql -u root -p < Experiment-7/unf_and_1nf.sql
mysql -u root -p < Experiment-7/2nf_and_3nf.sql
mysql -u root -p < Experiment-7/bcnf.sql
mysql -u root -p < Experiment-7/verify_normalization.sql
```

### 5. Experiment 8: Transactions & Isolation Levels (`banking_db`)
```bash
mysql -u root -p < Experiment-8/schema_and_data.sql
mysql -u root -p < Experiment-8/transactions_savepoints.sql
```

### 6. Experiment 9: Railway Booking Indexing (`railway_db`)
```bash
mysql -u root -p < Experiment-9/schema.sql
mysql -u root -p < Experiment-9/sample_data.sql
mysql -u root -p < Experiment-9/benchmark_before_index.sql
mysql -u root -p < Experiment-9/create_indexes.sql
mysql -u root -p < Experiment-9/benchmark_after_index.sql
```

### 7. Experiment 10: Query Optimization (`analytics_db`)
```bash
mysql -u root -p < Experiment-10/schema.sql
mysql -u root -p < Experiment-10/sample_data.sql
mysql -u root -p < Experiment-10/slow_queries.sql
mysql -u root -p < Experiment-10/optimize_indexes.sql
mysql -u root -p < Experiment-10/optimized_queries.sql
```

---

## Expected Errors in Test Suites

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
