EXPLAIN
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.job_title, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

EXPLAIN FORMAT=TREE
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.job_title, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

EXPLAIN
SELECT e.emp_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(sub.salary)
    FROM employees sub
    WHERE sub.dept_id = e.dept_id
);

EXPLAIN FORMAT=TREE
SELECT e.emp_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(sub.salary)
    FROM employees sub
    WHERE sub.dept_id = e.dept_id
);

EXPLAIN
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.dept_id = d.dept_id AND p.priority = 'Critical'
);

EXPLAIN FORMAT=TREE
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.dept_id = d.dept_id AND p.priority = 'Critical'
);

EXPLAIN
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
WHERE e.dept_id = 1
  AND e.emp_id IN (
      SELECT ep.emp_id
      FROM employee_projects ep
      INNER JOIN projects p ON ep.project_id = p.project_id
      WHERE p.priority IN ('Critical', 'High')
  );

EXPLAIN FORMAT=TREE
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
WHERE e.dept_id = 1
  AND e.emp_id IN (
      SELECT ep.emp_id
      FROM employee_projects ep
      INNER JOIN projects p ON ep.project_id = p.project_id
      WHERE p.priority IN ('Critical', 'High')
  );

EXPLAIN
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
LEFT JOIN (
    SELECT DISTINCT ep.emp_id
    FROM employee_projects ep
    INNER JOIN projects p ON ep.project_id = p.project_id
    WHERE p.priority = 'Critical'
) crit ON e.emp_id = crit.emp_id
WHERE e.dept_id = 1 AND crit.emp_id IS NULL;

EXPLAIN FORMAT=TREE
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
LEFT JOIN (
    SELECT DISTINCT ep.emp_id
    FROM employee_projects ep
    INNER JOIN projects p ON ep.project_id = p.project_id
    WHERE p.priority = 'Critical'
) crit ON e.emp_id = crit.emp_id
WHERE e.dept_id = 1 AND crit.emp_id IS NULL;
