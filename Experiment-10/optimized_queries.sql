USE analytics_db;

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, amount
FROM orders_large
WHERE order_date >= '2025-06-01' AND order_date < '2025-07-01';

EXPLAIN ANALYZE
SELECT order_id, customer_id, category, region, amount
FROM orders_large
WHERE category = 'Electronics'
UNION
SELECT order_id, customer_id, category, region, amount
FROM orders_large
WHERE region = 'West';

EXPLAIN ANALYZE
SELECT o.order_id, o.customer_id, o.amount
FROM orders_large o
INNER JOIN (
    SELECT customer_id, AVG(amount) AS avg_amt
    FROM orders_large
    GROUP BY customer_id
) stats ON o.customer_id = stats.customer_id
WHERE o.amount > stats.avg_amt;

EXPLAIN ANALYZE
SELECT DISTINCT c.customer_id, c.full_name, c.tier
FROM customers_large c
INNER JOIN orders_large o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered' AND o.amount > 48000.00;

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, amount
FROM orders_large
WHERE region = 'North' AND status = 'Delivered'
ORDER BY amount DESC
LIMIT 20;
