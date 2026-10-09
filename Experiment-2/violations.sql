INSERT INTO orders (customer_id, shipping_address_id, order_date, total_amount, order_status)
VALUES (9999, 1, '2025-07-01 10:00:00', 500.00, 'Processing');

DELETE FROM sellers
WHERE seller_id = 1;

INSERT INTO customers (first_name, last_name, email, registered_date)
VALUES ('Duplicate', 'User', 'aarav.sharma@example.in', '2025-07-01');

INSERT INTO products (title, description, base_price, stock_quantity, seller_id, category_id, product_type)
VALUES (NULL, 'Missing Title Test', 100.00, 10, 1, 1, 'Electronics');

INSERT INTO sellers (business_name, gstin, email, phone, city, state, rating)
VALUES ('Duplicate GSTIN Corp', '27AABCU9603R1ZM', 'other@gst.in', '+919999999999', 'Mumbai', 'Maharashtra', 4.00);
