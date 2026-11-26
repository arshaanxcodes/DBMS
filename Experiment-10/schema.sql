CREATE DATABASE IF NOT EXISTS analytics_db;
USE analytics_db;

DROP TABLE IF EXISTS orders_large;
DROP TABLE IF EXISTS customers_large;

CREATE TABLE customers_large (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    city VARCHAR(50) NOT NULL,
    tier VARCHAR(20) NOT NULL,
    signup_date DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE orders_large (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    category VARCHAR(40) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    region VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers_large(customer_id)
) ENGINE=InnoDB;
