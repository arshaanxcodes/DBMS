INSERT INTO orders (order_id, customer_id, shipping_address_id, order_date, total_amount, order_status)
VALUES (99, 1, 1, '2025-07-01 10:00:00', 1499.00, 'Processing');

INSERT INTO order_items (order_id, item_sequence_no, product_id, quantity, unit_price, total_price)
VALUES (99, 1, 4, 1, 1499.00, 1499.00);

INSERT INTO payments (payment_id, order_id, payment_method, payment_status, transaction_reference, payment_date, amount_paid)
VALUES (99, 99, 'UPI', 'Success', 'UPI-CASCADE-TEST-99', '2025-07-01 10:02:00', 1499.00);

INSERT INTO deliveries (delivery_id, order_id, delivery_partner, tracking_number, delivery_status, dispatch_date, estimated_delivery_date, actual_delivery_date)
VALUES (99, 99, 'BlueDart Express', 'BD-CASCADE-TEST-99', 'Manifested', NULL, '2025-07-05', NULL);

SELECT COUNT(*) FROM orders WHERE order_id = 99;
SELECT COUNT(*) FROM order_items WHERE order_id = 99;
SELECT COUNT(*) FROM payments WHERE order_id = 99;
SELECT COUNT(*) FROM deliveries WHERE order_id = 99;

DELETE FROM orders WHERE order_id = 99;

SELECT COUNT(*) FROM orders WHERE order_id = 99;
SELECT COUNT(*) FROM order_items WHERE order_id = 99;
SELECT COUNT(*) FROM payments WHERE order_id = 99;
SELECT COUNT(*) FROM deliveries WHERE order_id = 99;

INSERT INTO categories (category_id, category_name, parent_category_id)
VALUES (99, 'Temporary Clearance', NULL);

INSERT INTO products (product_id, title, description, base_price, stock_quantity, seller_id, category_id, product_type)
VALUES (99, 'Clearance Flash Drive 64GB', 'High speed flash drive', 499.00, 50, 1, 99, 'Electronics');

SELECT product_id, title, category_id FROM products WHERE product_id = 99;

DELETE FROM categories WHERE category_id = 99;

SELECT product_id, title, category_id FROM products WHERE product_id = 99;

DELETE FROM products WHERE product_id = 99;
