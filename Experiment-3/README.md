# Experiment 3: Employee–Department–Project Schema & SQL Query Operations

## Objective
Implement an enterprise organizational database comprising:
- At least 30 employees across a realistic corporate reporting structure
- 5 corporate functional departments
- At least 8 projects with assigned budgets and priority tiers
- Relational mapping of employee project allocations (`employee_projects`)
- SQL queries demonstrating:
  1. Selection (`WHERE` with relational and logical operators, ranges, string pattern matching)
  2. Projection (`SELECT` with explicit column lists, string concatenation, arithmetic operations)
  3. Aggregate Functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
  4. `GROUP BY` grouping rows across departments and positions
  5. `HAVING` group-level filtering predicates
  6. `CASE` conditional expressions for banding and classification
  7. `ORDER BY` sorting mechanisms across single and composite keys

---

## Files in this Directory
1. `schema.sql`: DDL statements defining `departments`, `employees`, `projects`, and `employee_projects`.
2. `sample_data.sql`: DML statements inserting 5 departments, 32 employees, 10 projects, and 35 allocations.
3. `queries.sql`: Clean executable queries illustrating all requested operations.
4. `README.md`: Query rationale, documentation, and verification results.

---

## Relational Schema Design

```
+------------------+         +------------------+         +------------------+
|   departments    | 1     * |    employees     | *     * |     projects     |
|------------------|<------->|------------------|<------->|------------------|
| PK  dept_id      |         | PK  emp_id       |         | PK  project_id   |
|     dept_name    |         |     first_name   |         |     project_name |
|     location     |         |     last_name    |         | FK  dept_id      |
|     budget       |         |     email        |         |     budget       |
+------------------+         |     salary       |         |     priority     |
                             | FK  dept_id      |         +------------------+
                             | FK  manager_id   |                   ^
                             +------------------+                   |
                                      ^            +-----------------------+
                                      |            |   employee_projects   |
                                      +------------|-----------------------|
                                                   | PK,FK  emp_id         |
                                                   | PK,FK  project_id     |
                                                   |        assigned_role  |
                                                   |        hours_allocated|
                                                   +-----------------------+
```

### Dataset Statistics:
- **Departments**: 5 (Engineering, Human Resources, Finance, Marketing, Research & Development)
- **Employees**: 32 (Spanning C-suite, VP, Director, Lead, Senior, and Associate tiers)
- **Projects**: 10 (NextGen Cloud, Mobile App 2.0, CI/CD, HRMS Portal, Tax System, AI Assistant, etc.)
- **Project Allocations**: 35 assignments with defined roles and allocated weekly hours

---

## Query Breakdown (`queries.sql`)

| Query Number | Operation Category | Implementation Focus | Description |
| :--- | :--- | :--- | :--- |
| **Q1** | Selection | Relational comparison (`>=`) | Filters employees earning at least 150,000 monthly salary. |
| **Q2** | Selection | Range filtering (`BETWEEN`) | Retrieves employees hired during calendar years 2021 and 2022. |
| **Q3** | Selection | Pattern matching (`LIKE`) | Retrieves technical staff with 'Engineer' or 'Scientist' in title. |
| **Q4** | Projection | Concatenation & Arithmetic | Computes full name alias and annual CTC (monthly salary * 12). |
| **Q5** | Aggregates | Statistical summary | Calculates total staff count, minimum, maximum, average, and sum of salaries. |
| **Q6** | GROUP BY | Departmental aggregation | Aggregates headcount, average salary, and monthly department payroll. |
| **Q7** | HAVING | Aggregate threshold filter | Filters departments having both average salary > 120,000 and staff >= 5. |
| **Q8** | CASE Expression | Compensation banding | Categorizes employees into Executive, Senior Leadership, Mid, or Associate tiers. |
| **Q9** | CASE Expression | Tenured seniority tier | Classifies employees into Veteran (5+ yrs), Experienced (3-5 yrs), or Recent (<3 yrs). |
| **Q10** | ORDER BY | Composite sorting | Orders staff by department identifier ascending, then by salary descending. |

---

## Execution Guide
```bash
mysql -u root -p company_db < schema.sql
mysql -u root -p company_db < sample_data.sql
mysql -u root -p company_db < queries.sql
```
