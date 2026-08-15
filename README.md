# E-Commerce SQL Analysis

A MySQL portfolio project that models a small e-commerce system, seeds it with realistic sample data, and demonstrates progressively advanced SQL queries for operational and analytical reporting.

The project covers database design, data loading, filtering, aggregation, joins, subqueries, and set-based logic. Query output is included in a companion PDF for quick review.

## Contents

| File | Purpose |
| --- | --- |
| `SQL_Quaries.sql` | Database schema definition and 42 SQL practice/analysis queries. |
| `DataInsertionQueries.sql` | Seed data for all six tables (2,131 records). |
| `SQL_Queries_Results.pdf` | 21-page reference containing query screenshots and results. |

> **Note:** The existing filename `SQL_Quaries.sql` is retained as provided. It contains the project's primary SQL queries.

## Data Model

The schema represents a typical order-to-payment e-commerce workflow.

```text
customers 1 --- * orders 1 --- * order_items * --- 1 products
                     |
                     └ --- * payments

customers 1 --- * product_reviews * --- 1 products
```

| Table | Description | Seeded rows |
| --- | --- | ---: |
| `customers` | Customer profile and contact details. | 30 |
| `products` | Product catalogue, category, price, and inventory. | 50 |
| `orders` | Customer orders, status, timestamp, and order total. | 400 |
| `order_items` | Line items that connect orders to products. | 1,201 |
| `payments` | Payment amount, method, and date for each order. | 400 |
| `product_reviews` | Customer ratings and feedback for products. | 50 |

### Relationships

- Each order belongs to a customer.
- Each order item belongs to an order and references a product.
- Each payment belongs to an order.
- Each product review references both a customer and a product.

Primary keys are auto-incrementing integers. Foreign keys enforce the core entity relationships, while constraints cover required fields and positive order-item and payment values.

## Query Coverage

The SQL script is organized into six learning levels:

| Level | Focus | Examples |
| --- | --- | --- |
| 1. Basics | Retrieval, filtering, sorting | `SELECT`, `WHERE`, `IN`, `LIKE`, `BETWEEN`, `ORDER BY` |
| 2. Filtering and formatting | Null handling and presentation | `IS NULL`, aliases, `CONCAT`, `DATE`, calculated fields |
| 3. Aggregation | Summary reporting | `COUNT`, `SUM`, `AVG`, `GROUP BY` |
| 4. Multi-table queries | Relational analysis | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` |
| 5. Subqueries | Derived and exception reporting | Above-average products, customers/products without activity, highest-value orders |
| 6. Set operations | Cross-entity customer analysis | `UNION`, `EXISTS` |

## Prerequisites

- MySQL 8.0 or later
- A MySQL client such as MySQL Workbench, the MySQL command-line client, or DBeaver

The scripts use MySQL syntax, including `AUTO_INCREMENT`, `DATETIME`, `CURRENT_TIMESTAMP`, `CONCAT`, and `DATE`.

## Getting Started

1. Create and select a database:

   ```sql
   CREATE DATABASE ecommerce_analysis;
   USE ecommerce_analysis;
   ```

2. Run [`SQL_Quaries.sql`](SQL_Quaries.sql) to create the six tables.

   The same file also contains the practice queries. Run the table-creation statements first, then execute the query you want to explore.

3. Run [`DataInsertionQueries.sql`](DataInsertionQueries.sql) to load the sample data.

4. Execute any query from the question sections in `SQL_Quaries.sql`.

5. Compare results with [`SQL_Queries_Results.pdf`](SQL_Queries_Results.pdf), if needed.

### Command-line option

From the project directory, run:

```bash
mysql -u <username> -p ecommerce_analysis < SQL_Quaries.sql
mysql -u <username> -p ecommerce_analysis < DataInsertionQueries.sql
```

Replace `<username>` with your MySQL user. The first command creates the schema and also executes the query statements in the script; MySQL will print their result sets to the terminal.

## Example Analysis Questions

The query collection answers questions such as:

- Which products are above a price threshold or within a price range?
- What are the total revenue, average order value, and order volume?
- How many orders and how much sales value does each customer have?
- Which product categories have the most ordered items?
- Which customers have not placed an order?
- Which products have never been ordered?
- Which customers have both placed an order and submitted a review?

## Important Notes

- The data is sample data intended for SQL practice and portfolio demonstration; it should not be used as production data.
- The scripts are designed for a new database. Re-running the insertion script without clearing existing rows will cause primary-key or unique-key conflicts.

## Author

Lokesh Singh
LinkedIn : https://www.linkedin.com/in/lokesh-singh-da/
Github : https://github.com/LokeshSingh-DA
