INSERT INTO customers (customer_id, first_name, last_name, email, registered_date) VALUES
(1, 'Aarav', 'Sharma', 'aarav.sharma@example.in', '2025-01-15'),
(2, 'Priya', 'Patel', 'priya.patel@example.in', '2025-02-10'),
(3, 'Rahul', 'Verma', 'rahul.verma@example.in', '2025-02-20'),
(4, 'Ananya', 'Iyer', 'ananya.iyer@example.in', '2025-03-05'),
(5, 'Rohan', 'Gupta', 'rohan.gupta@example.in', '2025-03-12'),
(6, 'Neha', 'Singh', 'neha.singh@example.in', '2025-04-01'),
(7, 'Aditya', 'Nair', 'aditya.nair@example.in', '2025-04-18'),
(8, 'Sneha', 'Joshi', 'sneha.joshi@example.in', '2025-05-02'),
(9, 'Vikram', 'Malhotra', 'vikram.malhotra@example.in', '2025-05-20'),
(10, 'Kavya', 'Deshmukh', 'kavya.deshmukh@example.in', '2025-06-11');

INSERT INTO customer_phones (customer_id, phone_number) VALUES
(1, '+919811122334'),
(1, '+919811122335'),
(2, '+919822233445'),
(3, '+919833344556'),
(4, '+919844455667'),
(5, '+919855566778'),
(5, '+919855566779'),
(6, '+919866677889'),
(7, '+919877788990'),
(8, '+919888899001'),
(9, '+919899900112'),
(10, '+919800011223');

INSERT INTO addresses (address_id, customer_id, street_address, city, state, pincode, address_type) VALUES
(1, 1, 'Flat 402, Shanti Heights, Andheri West', 'Mumbai', 'Maharashtra', '400053', 'Home'),
(2, 1, 'Tech Park, Unit 3B, Whitefield', 'Bengaluru', 'Karnataka', '560066', 'Work'),
(3, 2, 'B-12, Navrangpura', 'Ahmedabad', 'Gujarat', '380009', 'Home'),
(4, 3, '14 Civil Lines, Near GPO', 'Lucknow', 'Uttar Pradesh', '226001', 'Home'),
(5, 4, '77 Anna Salai, T. Nagar', 'Chennai', 'Tamil Nadu', '600017', 'Home'),
(6, 5, '55 MG Road, Connaught Place', 'New Delhi', 'Delhi', '110001', 'Work'),
(7, 6, 'Flat 101, Gomti Nagar Phase 2', 'Lucknow', 'Uttar Pradesh', '226010', 'Home'),
(8, 7, '23 Marine Drive, Ernakulam', 'Kochi', 'Kerala', '682011', 'Home'),
(9, 8, '88 FC Road, Shivaji Nagar', 'Pune', 'Maharashtra', '411005', 'Home'),
(10, 9, 'Plot 45, Jubilee Hills', 'Hyderabad', 'Telangana', '500033', 'Home'),
(11, 10, '12 MI Road, C-Scheme', 'Jaipur', 'Rajasthan', '302001', 'Home');

INSERT INTO categories (category_id, category_name, parent_category_id) VALUES
(1, 'Electronics', NULL),
(2, 'Fashion', NULL),
(3, 'Groceries', NULL),
(4, 'Mobile Phones', 1),
(5, 'Laptops', 1),
(6, 'Men Apparel', 2),
(7, 'Women Apparel', 2),
(8, 'Organic Staples', 3);

INSERT INTO sellers (seller_id, business_name, gstin, email, phone, city, state, rating) VALUES
(1, 'Cloudtail India Retail', '27AABCU9603R1ZM', 'support@cloudtail.in', '+911122334455', 'Bengaluru', 'Karnataka', 4.75),
(2, 'Appario Retail Pvt Ltd', '29AABCU9603R1ZN', 'care@appario.in', '+911122334456', 'New Delhi', 'Delhi', 4.60),
(3, 'TechWorld Distributors', '07AABCU9603R1ZO', 'orders@techworld.in', '+911122334457', 'Mumbai', 'Maharashtra', 4.40),
(4, 'Ethnic Weaves Jaipur', '08AABCU9603R1ZP', 'contact@ethnicweaves.in', '+911122334458', 'Jaipur', 'Rajasthan', 4.80),
(5, 'PureOrganic Harvest', '09AABCU9603R1ZQ', 'info@pureorganic.in', '+911122334459', 'Lucknow', 'Uttar Pradesh', 4.90);

INSERT INTO products (product_id, title, description, base_price, stock_quantity, seller_id, category_id, product_type) VALUES
(1, 'OnePlus 12 5G (Flowy Emerald, 256GB)', 'Flagship smartphone with Snapdragon 8 Gen 3', 64999.00, 45, 1, 4, 'Electronics'),
(2, 'Samsung Galaxy S24 Ultra (512GB)', 'Titanium frame with Galaxy AI', 129999.00, 25, 2, 4, 'Electronics'),
(3, 'MacBook Air M3 (13-inch, 16GB RAM)', 'Apple M3 silicon laptop with Retina display', 114900.00, 30, 1, 5, 'Electronics'),
(4, 'Men Slim Fit Pure Cotton Kurta', 'Traditional festive ethnic cotton kurta', 1499.00, 120, 4, 6, 'Clothing'),
(5, 'Women Handloom Chanderi Saree', 'Pure silk zari woven traditional saree', 4599.00, 60, 4, 7, 'Clothing'),
(6, 'Men Regular Fit Denim Jeans', 'Stretchable dark wash denim jeans', 2199.00, 95, 2, 6, 'Clothing'),
(7, 'Organic Royal Basmati Rice (5kg)', 'Aged long grain premium basmati rice', 650.00, 200, 5, 8, 'Grocery'),
(8, 'Cold Pressed Mustard Oil (1L)', 'Wood pressed kachi ghani pure mustard oil', 240.00, 150, 5, 8, 'Grocery');

INSERT INTO electronics_products (product_id, warranty_months, brand, voltage_spec, model_number) VALUES
(1, 12, 'OnePlus', '220V 100W SuperVOOC', 'CPH2581'),
(2, 24, 'Samsung', '220V 45W Fast Charging', 'SM-S928B'),
(3, 12, 'Apple', '100-240V 35W Dual Port', 'MRXN3HN/A');

INSERT INTO clothing_products (product_id, size, color, fabric_material, gender) VALUES
(4, 'L', 'Maroon', '100% Cotton', 'Men'),
(5, 'Free Size', 'Royal Blue', 'Chanderi Silk', 'Women'),
(6, '32', 'Dark Indigo', 'Denim Cotton', 'Men');

INSERT INTO grocery_products (product_id, expiry_date, is_vegetarian, weight_grams) VALUES
(7, '2026-06-30', 1, 5000),
(8, '2026-03-31', 1, 1000);

INSERT INTO orders (order_id, customer_id, shipping_address_id, order_date, total_amount, order_status) VALUES
(1, 1, 1, '2025-06-01 10:30:00', 65649.00, 'Delivered'),
(2, 2, 3, '2025-06-02 14:15:00', 129999.00, 'Delivered'),
(3, 3, 4, '2025-06-03 16:45:00', 6098.00, 'Delivered'),
(4, 4, 5, '2025-06-05 11:00:00', 114900.00, 'Dispatched'),
(5, 5, 6, '2025-06-06 18:20:00', 890.00, 'Processing'),
(6, 6, 7, '2025-06-07 09:10:00', 2199.00, 'Delivered'),
(7, 7, 8, '2025-06-08 20:05:00', 64999.00, 'Processing');

INSERT INTO order_items (order_id, item_sequence_no, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 1, 1, 64999.00, 64999.00),
(1, 2, 7, 1, 650.00, 650.00),
(2, 1, 2, 1, 129999.00, 129999.00),
(3, 1, 4, 1, 1499.00, 1499.00),
(3, 2, 5, 1, 4599.00, 4599.00),
(4, 1, 3, 1, 114900.00, 114900.00),
(5, 1, 7, 1, 650.00, 650.00),
(5, 2, 8, 1, 240.00, 240.00),
(6, 1, 6, 1, 2199.00, 2199.00),
(7, 1, 1, 1, 64999.00, 64999.00);

INSERT INTO payments (payment_id, order_id, payment_method, payment_status, transaction_reference, payment_date, amount_paid) VALUES
(1, 1, 'UPI', 'Success', 'UPI-20250601-987654', '2025-06-01 10:32:00', 65649.00),
(2, 2, 'Credit Card', 'Success', 'CC-HDFC-20250602-112233', '2025-06-02 14:16:30', 129999.00),
(3, 3, 'NetBanking', 'Success', 'NB-ICICI-20250603-445566', '2025-06-03 16:47:10', 6098.00),
(4, 4, 'Credit Card', 'Success', 'CC-AXIS-20250605-778899', '2025-06-05 11:02:15', 114900.00),
(5, 5, 'Cash on Delivery', 'Pending', 'COD-20250606-334455', '2025-06-06 18:20:00', 890.00),
(6, 6, 'UPI', 'Success', 'UPI-20250607-556677', '2025-06-07 09:12:00', 2199.00),
(7, 7, 'UPI', 'Success', 'UPI-20250608-889900', '2025-06-08 20:06:10', 64999.00);

INSERT INTO deliveries (delivery_id, order_id, delivery_partner, tracking_number, delivery_status, dispatch_date, estimated_delivery_date, actual_delivery_date) VALUES
(1, 1, 'BlueDart Express', 'BD-IND-90817263', 'Delivered', '2025-06-01 18:00:00', '2025-06-03', '2025-06-03 15:40:00'),
(2, 2, 'Delhivery Logistics', 'DLHV-8877665544', 'Delivered', '2025-06-02 20:00:00', '2025-06-04', '2025-06-04 12:10:00'),
(3, 3, 'Ekart Logistics', 'EKT-4433221100', 'Delivered', '2025-06-04 09:00:00', '2025-06-06', '2025-06-06 17:30:00'),
(4, 4, 'BlueDart Express', 'BD-IND-77665544', 'In Transit', '2025-06-05 16:00:00', '2025-06-08', NULL),
(5, 5, 'India Post Speed Post', 'SP-UP-11223344', 'Manifested', NULL, '2025-06-11', NULL),
(6, 6, 'Delhivery Logistics', 'DLHV-9988776655', 'Delivered', '2025-06-07 14:00:00', '2025-06-09', '2025-06-09 11:25:00'),
(7, 7, 'Ekart Logistics', 'EKT-5544332211', 'Pending Dispatch', NULL, '2025-06-12', NULL);
