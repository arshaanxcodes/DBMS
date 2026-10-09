# Experiment 1: ER Modeling for Indian E-Commerce Platform

## Objective
Design an Entity-Relationship (ER) diagram for an Indian e-commerce platform incorporating:
- Core entities: `Customer`, `Product`, `Order`, `OrderItem`, `Seller`, `Category`, `Payment`, `Delivery`, `Address`.
- Primary keys for entity identification.
- Composite attributes (e.g., Customer Name, Address structure).
- Multi-valued attributes (e.g., Customer Contact Numbers).
- Weak entities and identifying relationships (e.g., `OrderItem` depending on `Order`, `Address` depending on `Customer`).
- Specialization hierarchy of `Product` into subtypes (`ElectronicsProduct`, `ClothingProduct`, `GroceryProduct`).
- Participation constraints (total vs. partial participation) and cardinality ratios.

---

## Artifacts in this Directory
1. `ER_Diagram.png`: High-resolution render (300 DPI) of the complete ER diagram.
2. `ER_Diagram.pdf`: Scalable vector publication-ready document for printing and evaluation.

---

## Entity-Relationship Specifications

### 1. Entities and Attribute Classification

| Entity | Entity Type | Primary Key / Partial Key | Attributes | Classification Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Customer** | Strong Entity | `customer_id` | `customer_id`, `name` (`first_name`, `last_name`), `email`, `phone_numbers`, `registered_date` | `name` is composite; `phone_numbers` is multi-valued. |
| **Address** | Weak Entity | `(customer_id, address_id)` | `address_id`, `street_address`, `city`, `state`, `pincode`, `address_type` | Weak entity existence-dependent on `Customer`. |
| **Category** | Strong Entity | `category_id` | `category_id`, `category_name`, `parent_category_id` | Self-referencing category tree. |
| **Seller** | Strong Entity | `seller_id` | `seller_id`, `business_name`, `gstin`, `email`, `phone`, `city`, `state`, `rating` | `gstin` is an Indian business tax identifier (UNIQUE). |
| **Product** | Superclass Entity | `product_id` | `product_id`, `title`, `description`, `base_price`, `stock_quantity`, `product_type` | Generalized superclass with disjoint specialization. |
| **ElectronicsProduct** | Specialized Subtype | `product_id` (FK to Product) | `warranty_period_months`, `brand`, `voltage_spec`, `model_number` | Inherits base attributes from `Product`. |
| **ClothingProduct** | Specialized Subtype | `product_id` (FK to Product) | `size`, `color`, `fabric_material`, `gender` | Inherits base attributes from `Product`. |
| **GroceryProduct** | Specialized Subtype | `product_id` (FK to Product) | `expiry_date`, `is_vegetarian`, `weight_grams` | Inherits base attributes from `Product`. |
| **Order** | Strong Entity | `order_id` | `order_id`, `order_date`, `total_amount`, `order_status`, `shipping_address_id` | Identified by system order identifier. |
| **OrderItem** | Weak Entity | `(order_id, item_sequence_no)` | `order_id`, `item_sequence_no`, `product_id`, `quantity`, `unit_price`, `total_price` | Weak entity with identifying relationship to `Order`. |
| **Payment** | Strong Entity | `payment_id` | `payment_id`, `order_id`, `payment_method`, `payment_status`, `transaction_reference`, `payment_date`, `amount_paid` | Payment modes include UPI, NetBanking, Credit Card, COD. |
| **Delivery** | Strong Entity | `delivery_id` | `delivery_id`, `order_id`, `delivery_partner`, `tracking_number`, `delivery_status`, `dispatch_date`, `estimated_delivery_date`, `actual_delivery_date` | Tracking of logistics (Ekart, Delhivery, BlueDart). |

---

### 2. Specialization and Generalization
The superclass `Product` is specialized into three disjoint subtypes:
- `ElectronicsProduct`
- `ClothingProduct`
- `GroceryProduct`

- **Constraint Type**: Disjoint (`d`) and Total Participation. Every product in the catalogue belongs to exactly one specialized category and inherits base pricing, stock, category, and seller associations.

---

### 3. Relationships and Participation Constraints

| Relationship | Entities Involved | Cardinality | Order Participation | Related Entity Participation | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Places** | Customer - Order | 1:N | Total (1,1) | Partial (0,N) | Every order must be placed by a customer. Customers may exist before ordering. |
| **Has_Address** | Customer - Address | 1:N | - | Total (1,1) | Identifying relationship. Address cannot exist without a Customer. |
| **Contains** | Order - OrderItem | 1:N | Total (1,N) | Total (1,1) | Identifying relationship. OrderItem cannot exist without an Order. |
| **Supplies** | Seller - Product | 1:N | - | Total (1,1) on Product, Partial (0,N) on Seller | Every product is supplied by a verified seller. |
| **Belongs_To** | Product - Category | N:1 | - | Partial (0,1) on Product, Partial (0,N) on Category | Products map to product taxonomy categories. |
| **Paid_By** | Order - Payment | 1:1 | Partial (0,1) on Order, Total (1,1) on Payment | - | Orders may have pending payment (e.g. COD); Payments link to exactly one Order. |
| **Fulfilled_By** | Order - Delivery | 1:1 | Partial (0,1) on Order, Total (1,1) on Delivery | - | Orders undergo fulfillment through a designated delivery partner. |

---

### 4. ER-to-Relational Mapping Strategy
- **Strong entities** map directly to independent base tables.
- **Composite attributes** flatten into individual atomic columns (e.g., `first_name` and `last_name`).
- **Multi-valued attributes** form a separate child table (`customer_phones`) with a composite primary key `(customer_id, phone_number)`.
- **Weak entities** (`order_items`, `addresses`) form tables referencing their owner's primary key as part of the primary key with `ON DELETE CASCADE`.
- **Specialization** maps using the Subtype Table Pattern (separate tables for each subclass sharing the primary key of the superclass).
