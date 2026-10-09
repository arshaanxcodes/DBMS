SELECT emp_id, first_name, last_name, job_title, salary, dept_id
FROM employees
WHERE salary >= 150000.00;

SELECT emp_id, first_name, last_name, hire_date, job_title
FROM employees
WHERE hire_date BETWEEN '2021-01-01' AND '2022-12-31';

SELECT emp_id, first_name, last_name, job_title
FROM employees
WHERE job_title LIKE '%Engineer%' OR job_title LIKE '%Scientist%';

SELECT emp_id, CONCAT(first_name, ' ', last_name) AS full_name, email, salary, ROUND(salary * 12, 2) AS annual_ctc
FROM employees;

SELECT COUNT(*) AS total_employees, MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary, ROUND(AVG(salary), 2) AS average_salary, SUM(salary) AS total_monthly_payroll
FROM employees;

SELECT dept_id, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS dept_avg_salary, SUM(salary) AS dept_total_payroll
FROM employees
GROUP BY dept_id;

SELECT dept_id, COUNT(*) AS total_staff, ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 120000.00 AND COUNT(*) >= 5;

SELECT emp_id, first_name, last_name, salary,
    CASE
        WHEN salary >= 200000.00 THEN 'Executive Band'
        WHEN salary >= 130000.00 THEN 'Senior Leadership Band'
        WHEN salary >= 85000.00 THEN 'Mid Professional Band'
        ELSE 'Associate Band'
    END AS compensation_tier
FROM employees;

SELECT emp_id, first_name, last_name, hire_date,
    CASE
        WHEN hire_date < '2020-01-01' THEN 'Veteran (5+ Years)'
        WHEN hire_date < '2022-01-01' THEN 'Experienced (3-5 Years)'
        ELSE 'Recent Addition (<3 Years)'
    END AS seniority_status
FROM employees;

SELECT emp_id, first_name, last_name, dept_id, salary
FROM employees
ORDER BY dept_id ASC, salary DESC;
