USE banking_db;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN;
SELECT account_id, holder_name, balance FROM accounts WHERE account_id = 1001;
COMMIT;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
SELECT account_id, holder_name, balance FROM accounts WHERE account_id = 1002;
SELECT SLEEP(3);
SELECT account_id, holder_name, balance FROM accounts WHERE account_id = 1002;
COMMIT;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
SELECT account_id, holder_name, balance FROM accounts WHERE account_id = 1002;
SELECT SLEEP(3);
SELECT account_id, holder_name, balance FROM accounts WHERE account_id = 1002;
COMMIT;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
SELECT account_id, holder_name, balance FROM accounts WHERE balance > 50000.00;
COMMIT;
