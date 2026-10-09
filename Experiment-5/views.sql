CREATE OR REPLACE VIEW v_department_salary_summary AS
SELECT 
    d.dept_id,
    d.dept_name,
    d.location,
    d.budget,
    COUNT(e.emp_id) AS total_employees,
    IFNULL(SUM(e.salary), 0) AS total_monthly_salary,
    IFNULL(ROUND(AVG(e.salary), 2), 0) AS average_salary,
    IFNULL(MIN(e.salary), 0) AS minimum_salary,
    IFNULL(MAX(e.salary), 0) AS maximum_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.location, d.budget;

CREATE OR REPLACE VIEW v_employee_hierarchy AS
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.job_title,
    e.salary,
    d.dept_name,
    IFNULL(CONCAT(m.first_name, ' ', m.last_name), 'TOP LEVEL (NO MANAGER)') AS manager_name,
    IFNULL(m.job_title, 'N/A') AS manager_title
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employees m ON e.manager_id = m.emp_id;

CREATE OR REPLACE VIEW v_employee_contact_update AS
SELECT emp_id, first_name, last_name, email, phone
FROM employees;

SELECT * FROM v_department_salary_summary;

SELECT * FROM v_employee_hierarchy;
