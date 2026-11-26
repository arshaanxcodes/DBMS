CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

DROP TABLE IF EXISTS transactions_log;
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    holder_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    balance DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    CHECK (balance >= 0.00)
) ENGINE=InnoDB;

CREATE TABLE transactions_log (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    from_account INT NULL,
    to_account INT NULL,
    amount DECIMAL(12,2) NOT NULL,
    txn_type VARCHAR(30) NOT NULL,
    txn_status VARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY (from_account) REFERENCES accounts(account_id) ON DELETE RESTRICT,
    FOREIGN KEY (to_account) REFERENCES accounts(account_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO accounts (account_id, holder_name, account_type, balance, status) VALUES
(1001, 'Aarav Sharma', 'Savings', 100000.00, 'ACTIVE'),
(1002, 'Priya Patel', 'Savings', 50000.00, 'ACTIVE'),
(1003, 'Rahul Verma', 'Current', 250000.00, 'ACTIVE'),
(1004, 'Ananya Iyer', 'Savings', 75000.00, 'ACTIVE'),
(1005, 'Rohan Gupta', 'Current', 15000.00, 'ACTIVE'),
(1006, 'Neha Singh', 'Savings', 5000.00, 'FROZEN'),
(1007, 'Corporate Escrow', 'Current', 1000000.00, 'ACTIVE'),
(1008, 'Merchant Settlement', 'Current', 300000.00, 'ACTIVE');
