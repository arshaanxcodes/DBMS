DROP PROCEDURE IF EXISTS transfer_employee;

DELIMITER //

CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE v_current_dept_id INT;
    DECLARE v_emp_exists INT DEFAULT 0;
    DECLARE v_dept_exists INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_emp_id IS NULL OR p_new_dept_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee ID and Department ID must not be NULL';
    END IF;

    SELECT COUNT(*), dept_id INTO v_emp_exists, v_current_dept_id
    FROM employees
    WHERE emp_id = p_emp_id
    GROUP BY dept_id;

    IF v_emp_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee does not exist';
    END IF;

    SELECT COUNT(*) INTO v_dept_exists
    FROM departments
    WHERE dept_id = p_new_dept_id;

    IF v_dept_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist';
    END IF;

    IF v_current_dept_id = p_new_dept_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee is already assigned to this department';
    END IF;

    START TRANSACTION;

    UPDATE employees
    SET dept_id = p_new_dept_id
    WHERE emp_id = p_emp_id;

    COMMIT;
END //

DELIMITER ;
