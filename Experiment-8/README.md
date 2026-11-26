# Experiment 8: Banking Transactions, Savepoints & Isolation Levels

## Objective
Demonstrate ACID transaction management and concurrency control in MySQL InnoDB:
1. Atomic banking transfers using `BEGIN`, `COMMIT`, and `ROLLBACK`.
2. Partial failure recovery using `SAVEPOINT` and `ROLLBACK TO SAVEPOINT`.
3. Two-session concurrency anomalies and ANSI SQL isolation levels:
   - `READ UNCOMMITTED` (Dirty Read)
   - `READ COMMITTED` (Non-Repeatable Read)
   - `REPEATABLE READ` (MVCC Snapshot Isolation)
   - `SERIALIZABLE` (Strict Locking)

---

## Files in this Directory
1. `schema_and_data.sql`: Creates `banking_db` with `accounts` (including `CHECK (balance >= 0.00)`) and `transactions_log`, plus 8 sample accounts.
2. `transactions_savepoints.sql`: Demonstrates committed transfer, full rollback, and partial rollback to a `SAVEPOINT`.
3. `isolation_session_a.sql`: Writer session script for two-session concurrency experiments.
4. `isolation_session_b.sql`: Reader session script for two-session concurrency experiments.
5. `README.md`: Documentation of transaction scenarios and two-session isolation test matrix.

---

## Transaction & Savepoint Scenarios (`transactions_savepoints.sql`)

| Scenario | Accounts Affected | Action | Outcome |
| :--- | :--- | :--- | :--- |
| **1. Atomic Transfer** | `1001 -> 1002` (10,000) | `BEGIN ... COMMIT` | Both debit and credit persist; logged as `COMPLETED`. |
| **2. Full Rollback** | `1005` (20,000) | `BEGIN ... ROLLBACK` | Account `1005` (balance 15,000) would violate `CHECK (balance >= 0)`; rollback restores original state. |
| **3. Partial Failure (Savepoint)** | `1003 -> 1004` (15,000), `1003 -> 1006` (5,000) | `SAVEPOINT sp_after_transfer` then `ROLLBACK TO SAVEPOINT` | Main transfer to `1004` commits cleanly; secondary transfer to frozen account `1006` is rolled back. |

---

## Two-Session Concurrency & Isolation Matrix

| Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read | MySQL InnoDB Behavior |
| :--- | :--- | :--- | :--- | :--- |
| `READ UNCOMMITTED` | Possible | Possible | Possible | Session B reads uncommitted debit from Session A before Session A rolls back. |
| `READ COMMITTED` | Prevented | Possible | Possible | Session B sees different balances within the same transaction after Session A commits. |
| `REPEATABLE READ` | Prevented | Prevented | Prevented (MVCC) | Default MySQL level; Session B reads consistent snapshot throughout transaction. |
| `SERIALIZABLE` | Prevented | Prevented | Prevented | Converts plain `SELECT` into `LOCK IN SHARE MODE`, blocking concurrent writes until commit. |

---

## Execution Guide
```bash
mysql -u root -p < schema_and_data.sql
mysql -u root -p < transactions_savepoints.sql
```
To test two-session concurrency, open two MySQL terminals and run corresponding blocks from `isolation_session_a.sql` and `isolation_session_b.sql` concurrently.
