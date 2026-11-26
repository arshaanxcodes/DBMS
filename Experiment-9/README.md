# Experiment 9: Railway Booking Table Indexing & Performance Benchmarks

## Objective
Create a `railway_bookings` table with at least 5,000 records (6,000 rows generated), benchmark query execution before and after creating single-column and composite indexes, and compare execution plans using `EXPLAIN` and `EXPLAIN ANALYZE`.

---

## Files in this Directory
1. `schema.sql`: Creates `railway_db` and the `railway_bookings` table without secondary indexes.
2. `sample_data.sql`: Generates 6,000 realistic Indian Railway booking records using a MySQL 8.0 recursive CTE.
3. `benchmark_before_index.sql`: Runs `EXPLAIN` and `EXPLAIN ANALYZE` on 4 representative queries prior to indexing.
4. `create_indexes.sql`: Creates single-column indexes (`idx_journey_date`, `idx_train_number`) and composite indexes (`idx_route_date`, `idx_status_class`).
5. `benchmark_after_index.sql`: Re-runs `EXPLAIN` and `EXPLAIN ANALYZE` on the same 4 queries after indexing.
6. `README.md`: Observed benchmark results and execution plan analysis.

---

## Observed Benchmark Comparison (6,000 Rows, MySQL 8.0.46)

| Query | Filter / Pattern | Before Index (`type` / `rows` / `cost` / `time`) | After Index (`type` / `key` / `rows` / `cost` / `time`) | Observation |
| :--- | :--- | :--- | :--- | :--- |
| **Q1** | `journey_date = '2025-03-15'` | `ALL` / `5998` / `600` / `2.07 ms` | `ref` / `idx_journey_date` / `33` / `4.05` / `0.143 ms` | ~14.5x faster via single-column B-Tree index lookup |
| **Q2** | `train_number = '12951'` | `ALL` / `5998` / `600` / `1.87 ms` | `ref` / `idx_train_number` / `750` / `75.8` / `3.74 ms` | Low selectivity (~12.5% of table) incurs random bookmark lookups |
| **Q3** | `source='NDLS' AND dest='SBC' AND date='2025-03-15'` | `ALL` / `5998` / `600` / `2.00 ms` | `ref` / `idx_route_date` / `1` / `0.35` / `0.0193 ms` | >100x faster via selective composite index |
| **Q4** | `COUNT(*) WHERE status='CONFIRMED' AND class='3A'` | `ALL` / `5998` / `606` / `1.49 ms` | `ref` / `idx_status_class` / `300` / `65.1` / `0.228 ms` | ~6.5x faster using a **Covering Index** (`Using index`) |

---

## Execution Guide
```bash
mysql -u root -p < schema.sql
mysql -u root -p < sample_data.sql
mysql -u root -p < benchmark_before_index.sql
mysql -u root -p < create_indexes.sql
mysql -u root -p < benchmark_after_index.sql
```
