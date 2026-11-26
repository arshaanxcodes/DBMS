# Experiment 10: Query Optimization on Large Datasets (14,000 Rows)

## Objective
Generate a multi-table dataset exceeding 10,000 rows (`customers_large`: 2,000 rows; `orders_large`: 12,000 rows), write five slow queries, analyze their execution plans using `EXPLAIN ANALYZE`, optimize them via indexing and SQL query rewriting, and compare before/after performance.

---

## Files in this Directory
1. `schema.sql`: Creates `analytics_db`, `customers_large`, and `orders_large`.
2. `sample_data.sql`: Generates 2,000 customers and 12,000 orders (14,000 total rows) via recursive CTEs.
3. `slow_queries.sql`: Five unoptimized SQL anti-patterns with `EXPLAIN ANALYZE`.
4. `optimize_indexes.sql`: Creates targeted single-column, composite, and covering indexes.
5. `optimized_queries.sql`: Rewritten sargable/join-based queries with `EXPLAIN ANALYZE`.
6. `README.md`: Observed benchmark comparison and optimization rationale.

---

## Five Slow Queries & Optimization Results (MySQL 8.0.46)

| Query | Anti-Pattern (Before) | Optimization Applied (After) | Before (`actual time` / `cost`) | After (`actual time` / `cost`) | Improvement |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Q1** | Non-sargable `YEAR(order_date) = 2025 AND MONTH(order_date) = 6` forcing full table scan | Index `idx_order_date` + sargable range `order_date >= '2025-06-01' AND order_date < '2025-07-01'` | `5.94 ms` / `1200` (`Table scan`, 12,000 rows) | `3.82 ms` / `228` (`Index range scan`, 506 rows) | ~1.55x faster; 95.8% fewer rows scanned |
| **Q2** | `OR` across unindexed columns (`category = 'Electronics' OR region = 'West'`) | Separate indexes `idx_category`, `idx_region` + `UNION` rewrite | `5.15 ms` / `1200` (`Table scan`) | `17.7 ms` / `1296` (`Union materialize` of 5,400 rows) | Demonstrates optimizer tradeoff: when `OR` matches 40% of rows, sequential scan beats union deduplication |
| **Q3** | Dependent correlated subquery `WHERE o.amount > (SELECT AVG(...) WHERE o2.customer_id = o.customer_id)` ($O(N^2)$) | Index `idx_cust_amount` + derived table `GROUP BY customer_id` joined once | `133,306 ms` (~133.3 s) / `1200` (`loops=12000`) | `51.5 ms` (`Covering index scan + lookup`) | **~2,588x faster** |
| **Q4** | `IN (SELECT ...)` scanning 12,000 rows | Covering index `idx_status_amount_cust` + `INNER JOIN DISTINCT` | `11.9 ms` / `1407` (`Table scan on o`) | `0.498 ms` / `90.9` (`Covering index range scan`) | **~23.9x faster** |
| **Q5** | Filtered `ORDER BY amount DESC LIMIT 20` causing `Sort` over 3,000 rows after full scan | Covering composite index `idx_region_status_amount (region, status, amount DESC, customer_id, order_date)` | `13.3 ms` / `1220` (`Table scan` + `Sort`) | `0.446 ms` / `364` (`Covering index lookup`, no sort) | **~29.8x faster** |

---

## Execution Guide
```bash
mysql -u root -p < schema.sql
mysql -u root -p < sample_data.sql
mysql -u root -p < slow_queries.sql
mysql -u root -p < optimize_indexes.sql
mysql -u root -p < optimized_queries.sql
```
