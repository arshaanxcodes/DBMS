# Experiment 6: Stored Procedures, Triggers & Transactional Control

## Objective
Implement procedural and event-driven database logic within MySQL:
1. **Stored Procedure (`transfer_employee`)**:
   - Reassigns an employee to a new department (`emp_id`, `new_dept_id`).
   - Comprehensive input validation (null parameters, non-existent employee, non-existent department, duplicate department reassignment).
   - Structured error handling with `DECLARE EXIT HANDLER FOR SQLEXCEPTION`.
   - Transaction boundary control (`START TRANSACTION`, `COMMIT`, and `ROLLBACK` upon failure).
2. **Salary Validation Triggers**:
   - `BEFORE INSERT` and `BEFORE UPDATE` event interceptors enforcing minimum statutory wage threshold (`salary >= 15000.00`) via `SIGNAL SQLSTATE '45000'`.
3. **Audit Logging Triggers**:
   - Dedicated enterprise audit ledger table `employee_audit`.
   - `AFTER UPDATE` trigger recording department reassignments and salary changes with historic before/after values, user session, and execution timestamp.
   - `AFTER INSERT` trigger logging new hires.
4. **Edge Case Verification**:
   - Validation against negative edge cases, transactional rollback consistency, and positive trigger activation.

---

## Files in this Directory
1. `procedure.sql`: Stored procedure definition with parameter validation and transactional error handler.
2. `triggers.sql`: Audit table schema and salary validation + audit logging triggers.
3. `test_cases.sql`: Comprehensive test harness covering negative edge cases, positive transfer, and audit record validation.
4. `README.md`: Technical documentation, transaction workflow, and expected error codes.

---

## Architecture and Control Flow

### 1. `transfer_employee(emp_id, new_dept_id)` Control Flow

```
                      CALL transfer_employee(p_emp_id, p_new_dept_id)
                                          |
                                          v
                              [Parameters NULL?] ---> Yes ---> SIGNAL '45000' (NULL not allowed)
                                          | No
                                          v
                              [Employee Exists?] ---> No  ---> SIGNAL '45000' (Employee does not exist)
                                          | Yes
                                          v
                            [Department Exists?] ---> No  ---> SIGNAL '45000' (Department does not exist)
                                          | Yes
                                          v
                        [Already in Department?] ---> Yes ---> SIGNAL '45000' (Already assigned)
                                          | No
                                          v
                                  START TRANSACTION
                                          |
                                UPDATE employees SET dept_id = ...
                                          |
                                        COMMIT
                                          |
                        (AFTER UPDATE trigger fires -> logs to employee_audit)
```

---

## Triggers Specification

### 1. Salary Constraint Validation (`BEFORE INSERT / UPDATE`)
- **Trigger Names**: `trg_employee_salary_check_insert`, `trg_employee_salary_check_update`
- **Rule**: If `NEW.salary < 15000.00`, execution is aborted with `SIGNAL SQLSTATE '45000'`.

### 2. Audit Trail Logging (`AFTER UPDATE`)
- **Trigger Name**: `trg_employee_audit_after_update`
- **Action**: When `dept_id` or `salary` changes, an entry is written into `employee_audit` tracking:
  - `action_type`: `DEPARTMENT_TRANSFER`, `SALARY_UPDATE`, or `TRANSFER_AND_SALARY`
  - `old_dept_id`, `new_dept_id`
  - `old_salary`, `new_salary`
  - `changed_by`: Current session user (`CURRENT_USER()`)
  - `changed_at`: Timestamp (`NOW()`)

---

## Test Cases and Expected Results (`test_cases.sql`)

| Statement | Test Category | Expected Status / Error Code | Description |
| :--- | :--- | :--- | :--- |
| `CALL transfer_employee(9999, 2);` | Negative Test | `ERROR 1644 (45000): Employee does not exist` | Rejection of non-existent employee identifier. |
| `CALL transfer_employee(124, 999);` | Negative Test | `ERROR 1644 (45000): Department does not exist` | Rejection of non-existent department identifier. |
| `CALL transfer_employee(124, 1);` | Negative Test | `ERROR 1644 (45000): Employee is already assigned to this department` | Prevention of redundant transfers. |
| `UPDATE employees SET salary = 5000.00 WHERE emp_id = 124;` | Negative Test | `ERROR 1644 (45000): Salary cannot be less than minimum wage of 15000.00` | Intercepted by BEFORE UPDATE trigger. |
| `CALL transfer_employee(124, 2);` | Positive Test | **Success** | Employee 124 dept updated to 2; trigger logs `DEPARTMENT_TRANSFER` in `employee_audit`. |
| `SELECT * FROM employee_audit;` | Verification | **Success** | Confirms persistent audit entry with old dept 1, new dept 2. |
| `CALL transfer_employee(124, 1);` | Positive Revert | **Success** | Reverts employee back to department 1; logs second audit record. |

---

## Execution Guide
```bash
mysql -u root -p company_db < procedure.sql
mysql -u root -p company_db < triggers.sql
mysql -u root -p company_db < test_cases.sql
```
