CREATE DATABASE IF NOT EXISTS sales_norm_db;
USE sales_norm_db;

DROP TABLE IF EXISTS sales_unf;
DROP TABLE IF EXISTS sales_1nf;

CREATE TABLE sales_unf (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(50) NOT NULL,
    product_ids VARCHAR(100) NOT NULL,
    product_names VARCHAR(255) NOT NULL,
    category_ids VARCHAR(100) NOT NULL,
    category_names VARCHAR(255) NOT NULL,
    unit_prices VARCHAR(100) NOT NULL,
    quantities VARCHAR(100) NOT NULL,
    salesperson_id INT NOT NULL,
    salesperson_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

INSERT INTO sales_unf VALUES
(1001, '2025-01-10', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'P101, P102', 'Laptop Pro, Wireless Mouse', 'C01, C02', 'Computers, Accessories', '75000.00, 1200.00', '1, 2', 501, 'Vikram Joshi', 'Mumbai'),
(1002, '2025-01-12', 2, 'Priya Patel', 'Ahmedabad', 'Gujarat', 'P103', 'Office Chair', 'C03', 'Furniture', '8500.00', '2', 502, 'Neha Kapoor', 'Ahmedabad'),
(1003, '2025-01-15', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'P102, P104', 'Wireless Mouse, Mechanical Keyboard', 'C02, C02', 'Accessories, Accessories', '1200.00, 3500.00', '1, 1', 503, 'Rohan Verma', 'Mumbai'),
(1004, '2025-01-18', 3, 'Rahul Verma', 'Lucknow', 'Uttar Pradesh', 'P101, P105', 'Laptop Pro, Standing Desk', 'C01, C03', 'Computers, Furniture', '75000.00, 18000.00', '1, 1', 501, 'Vikram Joshi', 'Mumbai'),
(1005, '2025-01-20', 4, 'Ananya Iyer', 'Chennai', 'Tamil Nadu', 'P104, P106', 'Mechanical Keyboard, 27-inch Monitor', 'C02, C01', 'Accessories, Computers', '3500.00, 22000.00', '2, 1', 504, 'Karthik Rao', 'Chennai');

CREATE TABLE sales_1nf (
    order_id INT NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(50) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    salesperson_id INT NOT NULL,
    salesperson_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(50) NOT NULL,
    PRIMARY KEY (order_id, product_id)
) ENGINE=InnoDB;

INSERT INTO sales_1nf VALUES
(1001, 'P101', '2025-01-10', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'Laptop Pro', 'C01', 'Computers', 75000.00, 1, 501, 'Vikram Joshi', 'Mumbai'),
(1001, 'P102', '2025-01-10', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'Wireless Mouse', 'C02', 'Accessories', 1200.00, 2, 501, 'Vikram Joshi', 'Mumbai'),
(1002, 'P103', '2025-01-12', 2, 'Priya Patel', 'Ahmedabad', 'Gujarat', 'Office Chair', 'C03', 'Furniture', 8500.00, 2, 502, 'Neha Kapoor', 'Ahmedabad'),
(1003, 'P102', '2025-01-15', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'Wireless Mouse', 'C02', 'Accessories', 1200.00, 1, 503, 'Rohan Verma', 'Mumbai'),
(1003, 'P104', '2025-01-15', 1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'Mechanical Keyboard', 'C02', 'Accessories', 3500.00, 1, 503, 'Rohan Verma', 'Mumbai'),
(1004, 'P101', '2025-01-18', 3, 'Rahul Verma', 'Lucknow', 'Uttar Pradesh', 'Laptop Pro', 'C01', 'Computers', 75000.00, 1, 501, 'Vikram Joshi', 'Mumbai'),
(1004, 'P105', '2025-01-18', 3, 'Rahul Verma', 'Lucknow', 'Uttar Pradesh', 'Standing Desk', 'C03', 'Furniture', 18000.00, 1, 501, 'Vikram Joshi', 'Mumbai'),
(1005, 'P104', '2025-01-20', 4, 'Ananya Iyer', 'Chennai', 'Tamil Nadu', 'Mechanical Keyboard', 'C02', 'Accessories', 3500.00, 2, 504, 'Karthik Rao', 'Chennai'),
(1005, 'P106', '2025-01-20', 4, 'Ananya Iyer', 'Chennai', 'Tamil Nadu', '27-inch Monitor', 'C01', 'Computers', 22000.00, 1, 504, 'Karthik Rao', 'Chennai');
