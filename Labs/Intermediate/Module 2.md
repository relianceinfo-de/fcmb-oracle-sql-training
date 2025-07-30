---
Lab:
    Module 2: 'Working with Joins'
    Use Case: 'Unifying Customer, Product, and Staff Data with JOINs'
---

---
##  Scenario Overview

FCMB is building a centralized dashboard to give relationship managers a **360-degree view** of each customer. This dashboard must combine:

- Customer personal details
- Their bank accounts and loan records
- Product availability (e.g., loan products and interest rate tiers)
- Internal staff relationships (e.g., who manages whom)

This lab demonstrates how to use various SQL JOIN techniques to gather and present this information, even when data is incomplete or stored across multiple tables.

---
##  Types of Join
###  1. INNER JOIN – Customers with Active Loan Records
View customers who have at least one loan. This helps relationship managers prioritize clients with outstanding loan products.

```sql
SELECT c.customer_name, l.loan_amount, l.loan_type
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id;
 ```

### 2. RIGHT JOIN – All Accounts, Whether Linked or Not
Detect all active bank accounts, including those not currently linked to any customer. Useful for identifying orphaned accounts or potential data issues.

```sql
SELECT a.account_number, c.customer_name
FROM customers c
RIGHT JOIN bank_accounts a ON c.customer_id = a.customer_id;
 ```
### 3. FULL JOIN – Comprehensive Customer and Loan Overview
Generate a report that shows all customers and all loans, even when records are missing on either side. This ensures data completeness and supports auditing and cleanup efforts.

```sql
SELECT c.customer_name, l.loan_amount
FROM customers c
FULL JOIN loans l ON c.customer_id = l.customer_id;
 ```

### 4. SELF JOIN – Employee to Manager Mapping
Reveal the organizational structure behind customer-facing teams. Helps ensure escalation paths and accountability are clearly understood.
```sql
SELECT e.employee_name AS employee, m.employee_name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;
 ```
### 5. CROSS JOIN – Loan Product and Rate Planning
Show all possible loan product and interest rate combinations. Useful for scenario planning, new product packaging, or generating tailored offers for customers.

```sql
SELECT lp.product_name, ir.interest_rate_tier
FROM loan_products lp
CROSS JOIN interest_rate_tiers ir;
 ```


### Optional Sample Tables to test the Joins

```sql
CREATE TABLE customers (
    customer_id NUMBER,
    customer_name VARCHAR2(100)
);

CREATE TABLE loans (
    loan_id NUMBER,
    customer_id NUMBER,
    loan_amount NUMBER,
    loan_type VARCHAR2(50)
);

CREATE TABLE bank_accounts (
    account_id NUMBER,
    account_number VARCHAR2(30),
    customer_id NUMBER
);

CREATE TABLE employees (
    employee_id NUMBER,
    employee_name VARCHAR2(100),
    manager_id NUMBER
);

CREATE TABLE loan_products (
    product_id NUMBER,
    product_name VARCHAR2(50)
);

CREATE TABLE interest_rate_tiers (
    tier_id NUMBER,
    interest_rate_tier VARCHAR2(20)
);

 ```

