---
Lab:
    Module 3: 'Subqueries and Nested Queries'
    Use Case: 'Customer Profitability and Risk Monitoring'
---

---
##  Scenario Overview

---

FCMB is implementing a data analytics system to **identify high-value customers**, **flag risky transaction behavior**, and **analyze branch-level performance**. The goal is to empower account managers with insights to:

- Recognize profitable accounts
- Spot customers making large or unusual transactions
- Summarize performance metrics per branch
- 
This lab introduces the power of **subqueries in SQL** — nested queries that allow complex logic and conditional analysis within banking datasets. Participants will learn how to write and optimize subqueries to support deeper insights and operational intelligence.

Subqueries allow us to break these questions down into small, composable queries and embed them into larger logic blocks.

---

##  Types of Subqueries

### 1. Scalar Subquery — Highest Balance per Customer
Returns each customer's highest account balance, useful in risk assessment and VIP client targeting.
```sql
SELECT customer_name,
       (SELECT MAX(balance)
        FROM bank_accounts
        WHERE customer_id = c.customer_id) AS highest_balance
FROM customers c;
 ```
### 2. Non-Correlated Subquery — Accounts with Above-Average Balances
Identifies customers whose accounts hold balances higher than the overall bank average — a key signal for wealth tier classification.
```sql
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM bank_accounts
    WHERE balance > (SELECT AVG(balance) FROM bank_accounts)
);
 ```

### 3. Correlated Subquery — Customers With Unusually High Transactions
Flags customers with transactions larger than their own average, helping detect anomalies and potential fraud.
```sql
SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.customer_id = c.customer_id
      AND t.amount > (
          SELECT AVG(amount)
          FROM transactions
          WHERE customer_id = c.customer_id
      )
);
 ```

### 4. Inline View (Derived Table) — Average Branch Balance
Produces a comparison of branch performance by aggregating total balances — useful in branch performance reviews.
```sql
SELECT branch_id, AVG(total_branch_balance) AS avg_balance_across_branches
FROM (
    SELECT branch_id, SUM(balance) AS total_branch_balance
    FROM bank_accounts
    GROUP BY branch_id
) AS branch_summary;

 ```

### 5. Subquery in WHERE Clause — High-Value Transactions for a Specific Account
Extracts unusually large transactions for a specific account, aiding in fraud detection and customer profiling
```sql
SELECT transaction_id, amount
FROM transactions
WHERE amount > (
    SELECT AVG(amount)
    FROM transactions
    WHERE account_id = 12345
);
 ```

### Sample Schema

```sql
CREATE TABLE customers (
    customer_id NUMBER,
    customer_name VARCHAR2(100)
);

CREATE TABLE bank_accounts (
    account_id NUMBER,
    customer_id NUMBER,
    branch_id NUMBER,
    balance NUMBER
);

CREATE TABLE transactions (
    transaction_id NUMBER,
    customer_id NUMBER,
    account_id NUMBER,
    amount NUMBER,
    transaction_date DATE
);
 ```
