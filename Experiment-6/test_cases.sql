CALL transfer_employee(9999, 2);

CALL transfer_employee(124, 999);

CALL transfer_employee(124, 1);

UPDATE employees
SET salary = 5000.00
WHERE emp_id = 124;

SELECT emp_id, first_name, last_name, dept_id, salary
FROM employees
WHERE emp_id = 124;

CALL transfer_employee(124, 2);

SELECT emp_id, first_name, last_name, dept_id, salary
FROM employees
WHERE emp_id = 124;

SELECT audit_id, emp_id, action_type, old_dept_id, new_dept_id, old_salary, new_salary, changed_by, changed_at
FROM employee_audit
WHERE emp_id = 124;

CALL transfer_employee(124, 1);

SELECT audit_id, emp_id, action_type, old_dept_id, new_dept_id, old_salary, new_salary, changed_by, changed_at
FROM employee_audit
WHERE emp_id = 124;
