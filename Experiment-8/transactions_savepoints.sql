USE banking_db;

BEGIN;
UPDATE accounts SET balance = balance - 10000.00 WHERE account_id = 1001;
UPDATE accounts SET balance = balance + 10000.00 WHERE account_id = 1002;
INSERT INTO transactions_log (from_account, to_account, amount, txn_type, txn_status, created_at)
VALUES (1001, 1002, 10000.00, 'NEFT_TRANSFER', 'COMPLETED', NOW());
COMMIT;

SELECT account_id, holder_name, balance FROM accounts WHERE account_id IN (1001, 1002);

BEGIN;
UPDATE accounts SET balance = balance - 10000.00 WHERE account_id = 1005;
INSERT INTO transactions_log (from_account, to_account, amount, txn_type, txn_status, created_at)
VALUES (1005, 1004, 10000.00, 'IMPS_TRANSFER', 'CANCELLED', NOW());
ROLLBACK;

SELECT account_id, holder_name, balance FROM accounts WHERE account_id IN (1004, 1005);

BEGIN;
UPDATE accounts SET balance = balance - 15000.00 WHERE account_id = 1003;
SAVEPOINT sp_after_debit;

UPDATE accounts SET balance = balance + 15000.00 WHERE account_id = 1004;
INSERT INTO transactions_log (from_account, to_account, amount, txn_type, txn_status, created_at)
VALUES (1003, 1004, 15000.00, 'RTGS_TRANSFER', 'COMPLETED', NOW());
SAVEPOINT sp_after_transfer;

UPDATE accounts SET balance = balance - 5000.00 WHERE account_id = 1003;
UPDATE accounts SET balance = balance + 5000.00 WHERE account_id = 1006;
ROLLBACK TO SAVEPOINT sp_after_transfer;

COMMIT;

SELECT account_id, holder_name, balance FROM accounts WHERE account_id IN (1003, 1004, 1006);
SELECT * FROM transactions_log;
