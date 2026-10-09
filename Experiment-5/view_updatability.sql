SELECT emp_id, first_name, last_name, phone
FROM v_employee_contact_update
WHERE emp_id = 124;

UPDATE v_employee_contact_update
SET phone = '+919810099999'
WHERE emp_id = 124;

SELECT emp_id, first_name, last_name, phone
FROM employees
WHERE emp_id = 124;

UPDATE v_employee_contact_update
SET phone = '+919810010024'
WHERE emp_id = 124;

UPDATE v_department_salary_summary
SET total_monthly_salary = 500000.00
WHERE dept_id = 1;
