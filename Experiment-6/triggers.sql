CREATE TABLE IF NOT EXISTS employee_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    action_type VARCHAR(30) NOT NULL,
    old_dept_id INT NULL,
    new_dept_id INT NULL,
    old_salary DECIMAL(10,2) NULL,
    new_salary DECIMAL(10,2) NULL,
    changed_by VARCHAR(100) NOT NULL,
    changed_at DATETIME NOT NULL
) ENGINE=InnoDB;

DROP TRIGGER IF EXISTS trg_employee_salary_check_insert;
DROP TRIGGER IF EXISTS trg_employee_salary_check_update;
DROP TRIGGER IF EXISTS trg_employee_audit_after_update;
DROP TRIGGER IF EXISTS trg_employee_audit_after_insert;

DELIMITER //

CREATE TRIGGER trg_employee_salary_check_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 15000.00 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be less than minimum wage of 15000.00';
    END IF;
END //

CREATE TRIGGER trg_employee_salary_check_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 15000.00 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be less than minimum wage of 15000.00';
    END IF;
END //

CREATE TRIGGER trg_employee_audit_after_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.dept_id <> NEW.dept_id OR OLD.salary <> NEW.salary THEN
        INSERT INTO employee_audit (
            emp_id,
            action_type,
            old_dept_id,
            new_dept_id,
            old_salary,
            new_salary,
            changed_by,
            changed_at
        ) VALUES (
            NEW.emp_id,
            CASE
                WHEN OLD.dept_id <> NEW.dept_id AND OLD.salary <> NEW.salary THEN 'TRANSFER_AND_SALARY'
                WHEN OLD.dept_id <> NEW.dept_id THEN 'DEPARTMENT_TRANSFER'
                ELSE 'SALARY_UPDATE'
            END,
            OLD.dept_id,
            NEW.dept_id,
            OLD.salary,
            NEW.salary,
            CURRENT_USER(),
            NOW()
        );
    END IF;
END //

CREATE TRIGGER trg_employee_audit_after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (
        emp_id,
        action_type,
        old_dept_id,
        new_dept_id,
        old_salary,
        new_salary,
        changed_by,
        changed_at
    ) VALUES (
        NEW.emp_id,
        'NEW_HIRE',
        NULL,
        NEW.dept_id,
        NULL,
        NEW.salary,
        CURRENT_USER(),
        NOW()
    );
END //

DELIMITER ;
