## Module 2: Fundamentals of SQL for Data Retrieval and Analysis

### Scenario

Now that you understand the basic database structure, it's time to start querying the data to perform your duties in the internal control team. This module focuses on the core SQL commands you will use daily to retrieve, filter, and summarize bank data.

### Exercise 1: Basic Filtering and Sorting

The fraud department has asked you to review all transactions over a certain amount.

**Tasks:**

1.  Write a query to retrieve the `TRANSACTION_ID`, `ACCOUNT_ID`, `AMOUNT`, and `TRANSACTION_DATE` for all transactions with an `AMOUNT` greater than N20,000.
   
```sql
-- Enter query here...


```
2.  Order the results by `TRANSACTION_DATE` in descending order to see the most recent high-value transactions first.

```sql
-- Enter query here...


```
-----

### Exercise 2: Aggregating and Grouping Data

The compliance team needs to know the total transaction volume for each account type to monitor for unusual activity patterns.

**Tasks:**

1.  Using the `TRANSACTIONS` and `ACCOUNTS` tables, calculate the `SUM(AMOUNT)` and `COUNT(*)` of transactions for each `ACCOUNT_TYPE`.

```sql
-- Enter query here...


```
2.  Filter the results to only show account types where the total transaction amount (`SUM(AMOUNT)`) is greater than $100,000.

```sql
-- Enter query here...


```
-----

### Exercise 3: Joining Tables for Comprehensive Reporting

To trace suspicious activity, you need to combine login data with customer information.

**Tasks:**

1.  Write a query using an `INNER JOIN` on `USERS` and `LOGIN_AUDIT` to list `FIRST_NAME`, `LAST_NAME`, and `LOGIN_TIMESTAMP` for all successful logins (`LOGIN_STATUS = 'SUCCESS'`).

```sql
-- Enter query here...


```
2.  Explain why an `INNER JOIN` is the appropriate choice for this specific task.

```sql
-- Comment here...


```
