USE sales_norm_db;

SELECT
    (SELECT COUNT(*) FROM sales_1nf) AS original_1nf_rows,
    (SELECT COUNT(*)
     FROM order_items_3nf oi
     INNER JOIN orders_3nf o ON oi.order_id = o.order_id
     INNER JOIN customers_3nf c ON o.customer_id = c.customer_id
     INNER JOIN salespersons_3nf s ON o.salesperson_id = s.salesperson_id
     INNER JOIN products_3nf p ON oi.product_id = p.product_id
     INNER JOIN categories_3nf cat ON p.category_id = cat.category_id) AS reconstructed_3nf_rows;

SELECT
    s1.order_id,
    s1.product_id
FROM sales_1nf s1
LEFT JOIN (
    SELECT
        oi.order_id,
        oi.product_id,
        o.order_date,
        c.customer_id,
        c.customer_name,
        c.customer_city,
        c.customer_state,
        p.product_name,
        cat.category_id,
        cat.category_name,
        p.unit_price,
        oi.quantity,
        s.salesperson_id,
        s.salesperson_name,
        s.branch_city
    FROM order_items_3nf oi
    INNER JOIN orders_3nf o ON oi.order_id = o.order_id
    INNER JOIN customers_3nf c ON o.customer_id = c.customer_id
    INNER JOIN salespersons_3nf s ON o.salesperson_id = s.salesperson_id
    INNER JOIN products_3nf p ON oi.product_id = p.product_id
    INNER JOIN categories_3nf cat ON p.category_id = cat.category_id
) rec ON s1.order_id = rec.order_id
   AND s1.product_id = rec.product_id
   AND s1.customer_id = rec.customer_id
   AND s1.quantity = rec.quantity
   AND s1.unit_price = rec.unit_price
   AND s1.salesperson_id = rec.salesperson_id
WHERE rec.order_id IS NULL;

SELECT
    (SELECT COUNT(*) FROM territory_assignment_3nf) AS territory_3nf_rows,
    (SELECT COUNT(*)
     FROM city_salesperson_bcnf cs
     INNER JOIN salesperson_category_bcnf sc ON cs.salesperson_id = sc.salesperson_id) AS reconstructed_bcnf_rows;

SELECT cs.customer_city, sc.category_id, cs.salesperson_id
FROM city_salesperson_bcnf cs
INNER JOIN salesperson_category_bcnf sc ON cs.salesperson_id = sc.salesperson_id
LEFT JOIN territory_assignment_3nf t
    ON cs.customer_city = t.customer_city
   AND sc.category_id = t.category_id
   AND cs.salesperson_id = t.salesperson_id
WHERE t.customer_city IS NULL;

SELECT customer_id, COUNT(DISTINCT customer_name) AS distinct_names, COUNT(DISTINCT customer_city) AS distinct_cities
FROM customers_3nf
GROUP BY customer_id
HAVING COUNT(DISTINCT customer_name) > 1 OR COUNT(DISTINCT customer_city) > 1;

SELECT product_id, COUNT(DISTINCT product_name) AS distinct_names, COUNT(DISTINCT category_id) AS distinct_cats, COUNT(DISTINCT unit_price) AS distinct_prices
FROM products_3nf
GROUP BY product_id
HAVING COUNT(DISTINCT product_name) > 1 OR COUNT(DISTINCT category_id) > 1 OR COUNT(DISTINCT unit_price) > 1;

SELECT salesperson_id, COUNT(DISTINCT category_id) AS distinct_categories
FROM salesperson_category_bcnf
GROUP BY salesperson_id
HAVING COUNT(DISTINCT category_id) > 1;
