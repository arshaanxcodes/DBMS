SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.job_title, d.dept_name, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT d.dept_id, d.dept_name, p.project_id, p.project_name, p.priority
FROM departments d
LEFT JOIN projects p ON d.dept_id = p.dept_id;

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.job_title, CONCAT(m.first_name, ' ', m.last_name) AS manager_name, m.job_title AS manager_title
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, d.dept_name, p.project_name, ep.assigned_role, ep.hours_allocated
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN employee_projects ep ON e.emp_id = ep.emp_id
INNER JOIN projects p ON ep.project_id = p.project_id;

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.dept_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(sub.salary)
    FROM employees sub
    WHERE sub.dept_id = e.dept_id
);

SELECT ep.emp_id, ep.project_id, ep.hours_allocated
FROM employee_projects ep
WHERE ep.hours_allocated > (
    SELECT AVG(sub.hours_allocated)
    FROM employee_projects sub
    WHERE sub.project_id = ep.project_id
);

SELECT d.dept_id, d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.dept_id = d.dept_id AND p.priority = 'Critical'
);

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.emp_id = e.emp_id
);

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
WHERE e.dept_id = 1
  AND e.emp_id IN (
      SELECT ep.emp_id
      FROM employee_projects ep
      INNER JOIN projects p ON ep.project_id = p.project_id
      WHERE p.priority IN ('Critical', 'High')
  );

SELECT DISTINCT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
INNER JOIN employee_projects ep ON e.emp_id = ep.emp_id
INNER JOIN projects p ON ep.project_id = p.project_id
WHERE e.dept_id = 1 AND p.priority IN ('Critical', 'High');

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
WHERE e.dept_id = 1
  AND NOT EXISTS (
      SELECT 1
      FROM employee_projects ep
      INNER JOIN projects p ON ep.project_id = p.project_id
      WHERE ep.emp_id = e.emp_id AND p.priority = 'Critical'
  );

SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM employees e
LEFT JOIN (
    SELECT DISTINCT ep.emp_id
    FROM employee_projects ep
    INNER JOIN projects p ON ep.project_id = p.project_id
    WHERE p.priority = 'Critical'
) crit ON e.emp_id = crit.emp_id
WHERE e.dept_id = 1 AND crit.emp_id IS NULL;
