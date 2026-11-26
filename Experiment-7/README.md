# Experiment 7: Normalization (UNF to 3NF & BCNF) with Lossless Join & Dependency Preservation

## Objective
Given a denormalized `Sales` table containing repeating groups, partial dependencies, transitive dependencies, and overlapping candidate keys:
1. Identify all Functional Dependencies (FDs).
2. Normalize step-by-step from **UNF -> 1NF -> 2NF -> 3NF -> BCNF**.
3. Verify **Lossless Join** property using SQL join reconstruction and anti-join checks.
4. Verify **Dependency Preservation** using SQL uniqueness/FD integrity queries.

---

## Files in this Directory
1. `unf_and_1nf.sql`: Creates `sales_norm_db`, `sales_unf` (with comma-separated repeating groups), and `sales_1nf` (atomic attributes with composite PK `(order_id, product_id)`).
2. `2nf_and_3nf.sql`: Decomposes `sales_1nf` into 2NF (`orders_2nf`, `products_2nf`, `order_items_2nf`) and then into 3NF (`customers_3nf`, `salespersons_3nf`, `categories_3nf`, `products_3nf`, `orders_3nf`, `order_items_3nf`).
3. `bcnf.sql`: Demonstrates a 3NF-but-not-BCNF relation (`territory_assignment_3nf`) and decomposes it into BCNF (`salesperson_category_bcnf`, `city_salesperson_bcnf`).
4. `verify_normalization.sql`: SQL queries proving lossless join (row parity + 0 missing/spurious tuples) and dependency preservation.
5. `README.md`: Step-by-step FD analysis and normalization proofs.

---

## Step-by-Step Functional Dependency Analysis

### 1. Unnormalized Form (UNF) -> First Normal Form (1NF)
- **UNF Anomaly**: `sales_unf` stores multiple products, prices, and quantities in comma-separated strings per `order_id`.
- **1NF Resolution**: Eliminate repeating groups so every cell holds an atomic value. Primary Key becomes composite: `(order_id, product_id)`.

### 2. Functional Dependencies in `sales_1nf`
- **FD1**: `order_id -> order_date, customer_id, customer_name, customer_city, customer_state, salesperson_id, salesperson_name, branch_city` *(Partial dependency on `order_id`)*
- **FD2**: `product_id -> product_name, category_id, category_name, unit_price` *(Partial dependency on `product_id`)*
- **FD3**: `(order_id, product_id) -> quantity` *(Full functional dependency on composite PK)*
- **FD4**: `customer_id -> customer_name, customer_city, customer_state` *(Transitive dependency)*
- **FD5**: `category_id -> category_name` *(Transitive dependency)*
- **FD6**: `salesperson_id -> salesperson_name, branch_city` *(Transitive dependency)*

### 3. Second Normal Form (2NF)
Remove partial dependencies (FD1 and FD2):
- `orders_2nf(order_id, order_date, customer_id, customer_name, customer_city, customer_state, salesperson_id, salesperson_name, branch_city)`
- `products_2nf(product_id, product_name, category_id, category_name, unit_price)`
- `order_items_2nf(order_id, product_id, quantity)`

### 4. Third Normal Form (3NF)
Remove transitive dependencies (FD4, FD5, FD6):
- `customers_3nf(customer_id, customer_name, customer_city, customer_state)`
- `salespersons_3nf(salesperson_id, salesperson_name, branch_city)`
- `categories_3nf(category_id, category_name)`
- `products_3nf(product_id, product_name, category_id, unit_price)`
- `orders_3nf(order_id, order_date, customer_id, salesperson_id)`
- `order_items_3nf(order_id, product_id, quantity)`

### 5. Boyce-Codd Normal Form (BCNF)
Consider `territory_assignment_3nf(customer_city, category_id, salesperson_id)` where:
- `(customer_city, category_id) -> salesperson_id` (Candidate Key 1)
- `(customer_city, salesperson_id) -> category_id` (Candidate Key 2)
- `salesperson_id -> category_id` *(Each salesperson specializes in one category)*

Although `territory_assignment_3nf` is in 3NF (because `category_id` is a prime attribute), `salesperson_id -> category_id` violates **BCNF** because `salesperson_id` is not a superkey.
- **BCNF Decomposition**:
  - `salesperson_category_bcnf(salesperson_id, category_id)`
  - `city_salesperson_bcnf(customer_city, salesperson_id)`

---

## Verification Results (`verify_normalization.sql`)
1. **Lossless Join (1NF <-> 3NF)**: Original `sales_1nf` has 9 rows; joining all 3NF tables reconstructs exactly 9 rows with 0 mismatched or spurious tuples.
2. **Lossless Join (3NF <-> BCNF)**: `territory_assignment_3nf` has 5 rows; joining `city_salesperson_bcnf` and `salesperson_category_bcnf` on `salesperson_id` (a superkey of `salesperson_category_bcnf`) reconstructs exactly 5 rows with 0 spurious tuples.
3. **Dependency Preservation**: `GROUP BY ... HAVING COUNT(DISTINCT ...) > 1` checks return 0 violations across all decomposed tables.

---

## Execution Guide
```bash
mysql -u root -p < unf_and_1nf.sql
mysql -u root -p < 2nf_and_3nf.sql
mysql -u root -p < bcnf.sql
mysql -u root -p < verify_normalization.sql
```
