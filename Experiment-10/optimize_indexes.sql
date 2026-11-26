USE analytics_db;

CREATE INDEX idx_order_date ON orders_large (order_date);
CREATE INDEX idx_category ON orders_large (category);
CREATE INDEX idx_region ON orders_large (region);
CREATE INDEX idx_cust_amount ON orders_large (customer_id, amount);
CREATE INDEX idx_status_amount_cust ON orders_large (status, amount, customer_id);
CREATE INDEX idx_region_status_amount ON orders_large (region, status, amount DESC, customer_id, order_date);

SHOW INDEX FROM orders_large;
