USE analytics_db;

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, amount
FROM orders_large
WHERE YEAR(order_date) = 2025 AND MONTH(order_date) = 6;

EXPLAIN ANALYZE
SELECT order_id, customer_id, category, region, amount
FROM orders_large
WHERE category = 'Electronics' OR region = 'West';

EXPLAIN ANALYZE
SELECT o.order_id, o.customer_id, o.amount
FROM orders_large o
WHERE o.amount > (
    SELECT AVG(o2.amount)
    FROM orders_large o2
    WHERE o2.customer_id = o.customer_id
);

EXPLAIN ANALYZE
SELECT c.customer_id, c.full_name, c.tier
FROM customers_large c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM orders_large o
    WHERE o.status = 'Delivered' AND o.amount > 48000.00
);

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, amount
FROM orders_large
WHERE region = 'North' AND status = 'Delivered'
ORDER BY amount DESC
LIMIT 20;
