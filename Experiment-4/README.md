# Experiment 4: Advanced Joins, Subqueries, Set Simulations & Execution Plans

## Objective
Implement advanced multi-table relational query structures and compare their query optimizer execution plans using MySQL `EXPLAIN`:
- **INNER JOIN**: Combining records across relations matching join conditions.
- **LEFT JOIN**: Preserving all tuples from the left relation with null-extended right relation tuples.
- **SELF JOIN**: Recursive join within the same relation representing organizational hierarchy (`employees` to `employees`).
- **3-way JOIN**: Multi-table joining spanning `employees`, `employee_projects`, and `projects`.
- **Correlated Subqueries**: Subqueries referencing columns from the outer query executed per-row.
- **EXISTS Predicate**: Boolean quantification evaluating tuple existence without transferring data payloads.
- **Simulated Set Operations**: Relational Algebra Intersection ($A \cap B$) and Difference/Except ($A - B$) simulated via joins and subqueries.
- **Execution Plan Analysis**: Utilizing `EXPLAIN` and `EXPLAIN FORMAT=TREE` to compare cost, scan methods (`ALL`, `ref`, `eq_ref`), and join strategies.

---

## Files in this Directory
1. `queries.sql`: Clean SQL statements covering all required join types, subqueries, and set simulations.
2. `explain_plans.sql`: Query optimization analysis statements showing tabular and hierarchical query execution plans.
3. `README.md`: Technical documentation, relational algebra background, and query plan analysis.

---

## Relational Query Architecture

### 1. Join Taxonomy

| Join Type | Relations Involved | Predicate | Purpose |
| :--- | :--- | :--- | :--- |
| **INNER JOIN** | `employees e` <-> `departments d` | `e.dept_id = d.dept_id` | Associates employees with their home department name and location. |
| **LEFT JOIN** | `departments d` <-> `projects p` | `d.dept_id = p.dept_id` | Preserves all departments regardless of whether they have active projects. |
| **SELF JOIN** | `employees e` <-> `employees m` | `e.manager_id = m.emp_id` | Pairs each staff member with their immediate manager. |
| **3-way JOIN** | `employees` + `employee_projects` + `projects` | `e.emp_id = ep.emp_id` AND `ep.project_id = p.project_id` | Consolidates employee information with project assignments and allocation hours. |

---

### 2. Subqueries and Set Simulations

#### Correlated Subquery
- **Logic**: Identifies employees whose compensation exceeds the average salary computed specifically within their respective department:
  $$\sigma_{salary > AVG(salary_{dept})}(Employees)$$
- **Optimizer Behavior**: Evaluated dynamically for each outer tuple.

#### EXISTS Predicate
- **Logic**: Tests whether a subquery returns any row. The optimizer short-circuits evaluation as soon as the first matching record is found.

#### Simulated INTERSECT ($A \cap B$)
- **Simulation Strategy**: Relational intersection between Engineering staff ($A$) and High/Critical project contributors ($B$) is demonstrated via:
  1. Correlated/Uncorrelated `IN` membership testing.
  2. Multi-table `INNER JOIN` with `DISTINCT` projection.

#### Simulated EXCEPT ($A - B$)
- **Simulation Strategy**: Set difference finding Engineering staff who are *not* assigned to any Critical project:
  1. `NOT EXISTS` anti-semijoin pattern.
  2. `LEFT JOIN ... WHERE right.key IS NULL` outer join exclusion.

---

## EXPLAIN Execution Plan Analysis (`explain_plans.sql`)

### Key Metrics Evaluated:
1. **Join Types**:
   - `eq_ref`: Highest efficiency 1:1 primary key lookup (e.g., `departments` primary key lookup).
   - `ref`: Non-unique index lookup (e.g., foreign key lookups).
   - `ALL`: Full table scan on small relation.
2. **FORMAT=TREE Hierarchy**:
   - Shows physical execution tree with nested loops, hash joins, filter steps, and estimated row costs.

---

## Execution Guide
```bash
mysql -u root -p company_db < queries.sql
mysql -u root -p company_db < explain_plans.sql
```
