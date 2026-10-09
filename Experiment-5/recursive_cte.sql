WITH RECURSIVE employee_reporting_hierarchy AS (
    SELECT 
        emp_id,
        CONCAT(first_name, ' ', last_name) AS employee_name,
        job_title,
        dept_id,
        manager_id,
        1 AS hierarchy_level,
        CAST(CONCAT(first_name, ' ', last_name) AS CHAR(1000)) AS reporting_chain
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.job_title,
        e.dept_id,
        e.manager_id,
        h.hierarchy_level + 1 AS hierarchy_level,
        CAST(CONCAT(h.reporting_chain, ' -> ', e.first_name, ' ', e.last_name) AS CHAR(1000)) AS reporting_chain
    FROM employees e
    INNER JOIN employee_reporting_hierarchy h ON e.manager_id = h.emp_id
)
SELECT 
    emp_id,
    employee_name,
    job_title,
    dept_id,
    hierarchy_level,
    reporting_chain
FROM employee_reporting_hierarchy
ORDER BY hierarchy_level ASC, emp_id ASC;

WITH RECURSIVE subordinates AS (
    SELECT emp_id AS root_id, emp_id AS sub_id
    FROM employees

    UNION ALL

    SELECT s.root_id, e.emp_id
    FROM subordinates s
    INNER JOIN employees e ON e.manager_id = s.sub_id
)
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS leader_name,
    e.job_title,
    COUNT(s.sub_id) - 1 AS total_subordinates
FROM employees e
INNER JOIN subordinates s ON e.emp_id = s.root_id
GROUP BY e.emp_id, e.first_name, e.last_name, e.job_title
HAVING COUNT(s.sub_id) - 1 > 0
ORDER BY total_subordinates DESC, e.emp_id ASC;
