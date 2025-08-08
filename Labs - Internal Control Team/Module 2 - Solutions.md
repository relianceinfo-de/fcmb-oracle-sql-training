## Module 2: Solutions

### Exercise 1: Basic Filtering and Sorting - Solution

```sql
SELECT
    TRANSACTION_ID,
    ACCOUNT_ID,
    AMOUNT,
    TRANSACTION_DATE
FROM
    TRANSACTIONS
WHERE
    AMOUNT > 20000
ORDER BY
    TRANSACTION_DATE DESC;
```

**Explanation:** 

This query uses the `WHERE` clause to filter out transactions below the $20,000 threshold. The `ORDER BY` clause then sorts the results, making it easy to spot the most recent high-value transactions for review.

### Exercise 2: Aggregating and Grouping Data - Solution

```sql
SELECT
    a.ACCOUNT_TYPE,
    SUM(t.AMOUNT) AS total_transaction_volume,
    COUNT(t.TRANSACTION_ID) AS number_of_transactions
FROM
    TRANSACTIONS t
JOIN
    ACCOUNTS a ON t.ACCOUNT_ID = a.ACCOUNT_ID
GROUP BY
    a.ACCOUNT_TYPE
HAVING
    SUM(t.AMOUNT) > 100000;
```

**Explanation:** 

The `GROUP BY` clause categorizes transactions by `ACCOUNT_TYPE`. The `SUM` and `COUNT` functions then aggregate the data within each group. The `HAVING` clause filters these aggregated results, showing only the account types with a high transaction volume, which helps identify potential anomalies.

### Exercise 3: Joining Tables for Comprehensive Reporting - Solution

```sql
SELECT
    u.FIRST_NAME,
    u.LAST_NAME,
    la.LOGIN_TIMESTAMP
FROM
    USERS u
JOIN
    LOGIN_AUDIT la ON u.USERNAME = la.USERNAME
WHERE
    la.LOGIN_STATUS = 'SUCCESS';
```

**Explanation:** 

An `INNER JOIN` is the best choice here because we are only interested in successful logins that are linked to a known user in the `USERS` table. It returns only the rows where there is a matching `USERNAME` in both tables, providing a report of successful login activities.