USE sales_norm_db;

DROP TABLE IF EXISTS order_items_2nf;
DROP TABLE IF EXISTS orders_2nf;
DROP TABLE IF EXISTS products_2nf;

CREATE TABLE orders_2nf (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(50) NOT NULL,
    salesperson_id INT NOT NULL,
    salesperson_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products_2nf (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE order_items_2nf (
    order_id INT NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders_2nf(order_id),
    FOREIGN KEY (product_id) REFERENCES products_2nf(product_id)
) ENGINE=InnoDB;

INSERT INTO orders_2nf
SELECT DISTINCT order_id, order_date, customer_id, customer_name, customer_city, customer_state, salesperson_id, salesperson_name, branch_city
FROM sales_1nf;

INSERT INTO products_2nf
SELECT DISTINCT product_id, product_name, category_id, category_name, unit_price
FROM sales_1nf;

INSERT INTO order_items_2nf
SELECT order_id, product_id, quantity
FROM sales_1nf;

DROP TABLE IF EXISTS order_items_3nf;
DROP TABLE IF EXISTS orders_3nf;
DROP TABLE IF EXISTS products_3nf;
DROP TABLE IF EXISTS categories_3nf;
DROP TABLE IF EXISTS salespersons_3nf;
DROP TABLE IF EXISTS customers_3nf;

CREATE TABLE customers_3nf (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE salespersons_3nf (
    salesperson_id INT PRIMARY KEY,
    salesperson_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE categories_3nf (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE products_3nf (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories_3nf(category_id)
) ENGINE=InnoDB;

CREATE TABLE orders_3nf (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers_3nf(customer_id),
    FOREIGN KEY (salesperson_id) REFERENCES salespersons_3nf(salesperson_id)
) ENGINE=InnoDB;

CREATE TABLE order_items_3nf (
    order_id INT NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders_3nf(order_id),
    FOREIGN KEY (product_id) REFERENCES products_3nf(product_id)
) ENGINE=InnoDB;

INSERT INTO customers_3nf
SELECT DISTINCT customer_id, customer_name, customer_city, customer_state
FROM orders_2nf;

INSERT INTO salespersons_3nf
SELECT DISTINCT salesperson_id, salesperson_name, branch_city
FROM orders_2nf;

INSERT INTO categories_3nf
SELECT DISTINCT category_id, category_name
FROM products_2nf;

INSERT INTO products_3nf
SELECT product_id, product_name, category_id, unit_price
FROM products_2nf;

INSERT INTO orders_3nf
SELECT order_id, order_date, customer_id, salesperson_id
FROM orders_2nf;

INSERT INTO order_items_3nf
SELECT order_id, product_id, quantity
FROM order_items_2nf;
