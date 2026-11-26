USE analytics_db;

SET SESSION cte_max_recursion_depth = 15000;

INSERT INTO customers_large (customer_id, full_name, email, city, tier, signup_date)
WITH RECURSIVE c_seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM c_seq WHERE n < 2000
)
SELECT
    n,
    CONCAT('Customer_', n),
    CONCAT('customer', n, '@example.in'),
    ELT((n % 6) + 1, 'Mumbai', 'Delhi', 'Bengaluru', 'Hyderabad', 'Chennai', 'Lucknow'),
    ELT((n % 3) + 1, 'Silver', 'Gold', 'Platinum'),
    DATE_ADD('2023-01-01', INTERVAL (n % 730) DAY)
FROM c_seq;

INSERT INTO orders_large (order_id, customer_id, order_date, category, amount, status, region)
WITH RECURSIVE o_seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM o_seq WHERE n < 12000
)
SELECT
    n,
    ((n - 1) % 2000) + 1,
    DATE_ADD('2024-01-01', INTERVAL (n % 540) DAY),
    ELT((n % 5) + 1, 'Electronics', 'Fashion', 'Groceries', 'Home', 'Books'),
    ROUND(500.00 + ((n * 37) % 50000), 2),
    ELT((n % 4) + 1, 'Delivered', 'Processing', 'Shipped', 'Cancelled'),
    ELT((n % 4) + 1, 'North', 'South', 'East', 'West')
FROM o_seq;

SELECT
    (SELECT COUNT(*) FROM customers_large) AS total_customers,
    (SELECT COUNT(*) FROM orders_large) AS total_orders;
