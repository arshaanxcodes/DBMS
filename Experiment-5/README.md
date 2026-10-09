# Experiment 5: SQL Views, Updatability Verification & Recursive CTEs

## Objective
Implement database views and recursive hierarchical querying in MySQL:
1. **Department Salary Summary View** (`v_department_salary_summary`):
   Aggregates departmental headcounts, salary totals, averages, minimums, and maximums.
2. **Employee Hierarchy View** (`v_employee_hierarchy`):
   Flattens manager-employee reporting lines and departments into a unified reporting interface.
3. **View Updatability Verification**:
   - Demonstrate successful DML modification through a simple 1:1 updatable view (`v_employee_contact_update`).
   - Demonstrate enforcement of SQL view updatability rules by showing failure on an aggregate view containing `GROUP BY` and aggregate functions (`SUM`, `AVG`, `COUNT`).
4. **Recursive Common Table Expression (CTE)**:
   Traverse self-referencing employee organizational reporting chains from C-suite leaders to junior associates across hierarchy levels.

---

## Files in this Directory
1. `views.sql`: DDL statements defining the required views.
2. `view_updatability.sql`: Executable test statements demonstrating both valid and prohibited view update operations.
3. `recursive_cte.sql`: Recursive Common Table Expressions computing multi-level organizational reporting paths and total subordinate headcount.
4. `README.md`: Architectural documentation, updatability theory, and CTE recursion mechanics.

---

## View Definitions

### 1. `v_department_salary_summary`
- **Definition**: Consolidates `departments` and `employees` via `LEFT JOIN` with `GROUP BY d.dept_id`.
- **Metrics**: Total staff count, sum of monthly salary, average salary, minimum salary, and maximum salary.
- **Updatability**: **Non-updatable**. Contains aggregate functions and grouping clauses.

### 2. `v_employee_hierarchy`
- **Definition**: Connects `employees`, `departments`, and `employees` (manager self-join).
- **Columns**: `emp_id`, `employee_name`, `job_title`, `salary`, `dept_name`, `manager_name`, `manager_title`.

### 3. `v_employee_contact_update`
- **Definition**: 1:1 projection on `employees(emp_id, first_name, last_name, email, phone)`.
- **Updatability**: **Fully Updatable**. Directly maps to base table primary key without transformations.

---

## View Updatability Verification (`view_updatability.sql`)

### 1. Successful Update (Updatable View)
- Updating `phone` on `v_employee_contact_update` for `emp_id = 124` directly updates the underlying base table `employees`.

### 2. Prohibited Update (Aggregate View)
- Attempting to update `total_monthly_salary` on `v_department_salary_summary`:
  ```sql
  UPDATE v_department_salary_summary
  SET total_monthly_salary = 500000.00
  WHERE dept_id = 1;
  ```
- **Expected MySQL Error**:
  ```
  ERROR 1288 (HY000): The target table v_department_salary_summary of the UPDATE is not updatable
  ```
- **Relational Reason**: A view is updatable if and only if there is a 1-to-1 relationship between rows in the view and rows in the underlying base table. When `GROUP BY`, `SUM()`, `AVG()`, or `HAVING` clauses are present, multiple base rows collapse into a single aggregate row, making reverse tuple derivation mathematically ambiguous.

---

## Recursive CTE Architecture (`recursive_cte.sql`)

```
Anchor Member:
  SELECT C-Suite (manager_id IS NULL) -> Level 1 (e.g. Rajesh Menon, Sunita Sharma)
        |
        v
Recursive Member:
  JOIN employees e ON e.manager_id = anchor.emp_id -> Level 2 (e.g. Arjun Prasad, Deepa Venkatesh)
        |
        v
  JOIN employees e ON e.manager_id = anchor.emp_id -> Level 3 (e.g. Rohan Verma, Sneha Rao)
        |
        v
  JOIN employees e ON e.manager_id = anchor.emp_id -> Level 4 (e.g. Aditya Grover, Pallavi Sinha)
```

The recursive query builds both:
1. `hierarchy_level`: An integer depth tracking rank distance from executive leadership.
2. `reporting_chain`: A delimited string showing the full audit path (e.g., `Rajesh Menon -> Arjun Prasad -> Rohan Verma -> Aditya Grover`).
3. Subordinate Rollup: Aggregating all direct and indirect downstream team members under each leader.

---

## Execution Guide
```bash
mysql -u root -p company_db < views.sql
mysql -u root -p company_db < view_updatability.sql
mysql -u root -p company_db < recursive_cte.sql
```
