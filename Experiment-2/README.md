# Experiment 2: Relational Schema Implementation & Referential Integrity

## Objective
Convert the Indian e-commerce ER model from Experiment 1 into a complete MySQL relational schema with:
- Primary keys (single column and composite keys)
- Foreign keys with referential actions (`ON DELETE CASCADE`, `ON DELETE SET NULL`, and `RESTRICT`)
- Column-level constraints: `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`
- Subtype hierarchy mapping using table inheritance
- Realistic sample data covering customers, addresses, categories, sellers, products, orders, payments, and deliveries
- Verification of referential integrity and constraint enforcement

---

## Files in this Directory
1. `schema.sql`: Complete DDL statements creating all 13 relational tables with constraints and referential actions.
2. `sample_data.sql`: DML statements populating realistic sample records across all tables.
3. `referential_integrity.sql`: Executable verification script demonstrating `ON DELETE CASCADE` and `ON DELETE SET NULL`.
4. `violations.sql`: Negative test statements demonstrating database constraint violations (Error 1452, Error 1451, Error 1062, Error 1048).
5. `README.md`: Architectural documentation and expected outputs.

---

## Schema Structure and Constraint Summary

| Table | Primary Key | Foreign Key References | Integrity Actions | Other Constraints |
| :--- | :--- | :--- | :--- | :--- |
| `customers` | `customer_id` | None | - | `email` UNIQUE, NOT NULL |
| `customer_phones` | `(customer_id, phone_number)` | `customer_id -> customers(customer_id)` | `ON DELETE CASCADE` | Composite PK |
| `addresses` | `address_id` | `customer_id -> customers(customer_id)` | `ON DELETE CASCADE` | NOT NULL on street, city, state, pin |
| `categories` | `category_id` | `parent_category_id -> categories(category_id)` | `ON DELETE SET NULL` | `category_name` UNIQUE |
| `sellers` | `seller_id` | None | - | `gstin` UNIQUE, `email` UNIQUE |
| `products` | `product_id` | `seller_id -> sellers(seller_id)`<br>`category_id -> categories(category_id)` | `seller_id`: RESTRICT<br>`category_id`: `ON DELETE SET NULL` | `title` NOT NULL, `base_price` NOT NULL |
| `electronics_products` | `product_id` | `product_id -> products(product_id)` | `ON DELETE CASCADE` | 1:1 Subtype table |
| `clothing_products` | `product_id` | `product_id -> products(product_id)` | `ON DELETE CASCADE` | 1:1 Subtype table |
| `grocery_products` | `product_id` | `product_id -> products(product_id)` | `ON DELETE CASCADE` | 1:1 Subtype table |
| `orders` | `order_id` | `customer_id -> customers(customer_id)`<br>`shipping_address_id -> addresses(address_id)` | `customer_id`: RESTRICT<br>`shipping_address_id`: `ON DELETE SET NULL` | `total_amount` NOT NULL |
| `order_items` | `(order_id, item_sequence_no)` | `order_id -> orders(order_id)`<br>`product_id -> products(product_id)` | `order_id`: `ON DELETE CASCADE`<br>`product_id`: RESTRICT | Composite PK, Weak entity |
| `payments` | `payment_id` | `order_id -> orders(order_id)` | `ON DELETE CASCADE` | `order_id` UNIQUE (1:1), `transaction_reference` UNIQUE |
| `deliveries` | `delivery_id` | `order_id -> orders(order_id)` | `ON DELETE CASCADE` | `order_id` UNIQUE (1:1), `tracking_number` UNIQUE |

---

## Execution Guide

### 1. Execute Schema and Populate Data
```bash
mysql -u root -p ecommerce < schema.sql
mysql -u root -p ecommerce < sample_data.sql
```

### 2. Verify Referential Integrity Actions
```bash
mysql -u root -p ecommerce < referential_integrity.sql
```

#### Cascade Delete Verification:
- Order `99` is inserted with associated records in `order_items`, `payments`, and `deliveries`.
- Deleting Order `99` triggers `ON DELETE CASCADE` on all child tables.
- Verification queries return `0` rows for all dependent child rows.

#### Set Null Verification:
- Category `99` is created and Product `99` references it.
- Deleting Category `99` triggers `ON DELETE SET NULL`.
- Verification query shows `category_id` of Product `99` automatically updated to `NULL` while preserving the product record.

---

## Constraint Violation Test Cases (`violations.sql`)

When executing `violations.sql`, the following errors are expected:

### 1. Foreign Key Insertion Failure
- **Statement**: Attempting to insert an order with non-existent `customer_id = 9999`.
- **Expected Error**: `ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (orders, CONSTRAINT orders_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE RESTRICT)`
- **Reason**: The value `9999` does not exist in the parent table `customers`.

### 2. Foreign Key Deletion Restriction
- **Statement**: Attempting to delete `seller_id = 1` who has active products listed.
- **Expected Error**: `ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (products, CONSTRAINT products_ibfk_1 FOREIGN KEY (seller_id) REFERENCES sellers (seller_id) ON DELETE RESTRICT)`
- **Reason**: Default `RESTRICT` prevents deletion of parent records while active child dependencies exist.

### 3. Unique Constraint Violation (Customer Email)
- **Statement**: Attempting to insert a customer with an email already present (`aarav.sharma@example.in`).
- **Expected Error**: `ERROR 1062 (23000): Duplicate entry 'aarav.sharma@example.in' for key 'customers.email'`
- **Reason**: `UNIQUE` constraint on the email column prohibits duplicate entries.

### 4. Not Null Constraint Violation
- **Statement**: Attempting to insert a product with `title = NULL`.
- **Expected Error**: `ERROR 1048 (23000): Column 'title' cannot be null`
- **Reason**: The `title` column is declared `NOT NULL`.

### 5. Unique Constraint Violation (Seller GSTIN)
- **Statement**: Attempting to insert a seller with duplicate GSTIN (`27AABCU9603R1ZM`).
- **Expected Error**: `ERROR 1062 (23000): Duplicate entry '27AABCU9603R1ZM' for key 'sellers.gstin'`
- **Reason**: Indian GSTIN registration numbers are globally unique per enterprise.
