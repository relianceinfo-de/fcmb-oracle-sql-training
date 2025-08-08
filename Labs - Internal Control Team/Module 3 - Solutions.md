## Module 3: Solutions

### Exercise 1: Understanding and Verifying Constraints - Solution

```sql
SELECT
    constraint_name,
    constraint_type,
    search_condition
FROM
    user_constraints
WHERE
    table_name = 'TRANSACTIONS';
```

**Explanation:** 

The `TRANSACTION_ID` constraint is likely a **PRIMARY KEY**. This ensures every transaction is uniquely identified, which is essential for accurate auditing and reporting. The `ACCOUNT_ID` constraint is a **FOREIGN KEY**, which links each transaction back to a valid account, preventing data from being recorded against a non-existent account.

### Exercise 2: Transaction Management - Solution

```sql
-- Initial balances
SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS WHERE ACCOUNT_ID IN (1, 2);

-- Start of a transaction
UPDATE ACCOUNTS
SET BALANCE = BALANCE - 100
WHERE ACCOUNT_ID = 1;

-- Simulate an error by updating a non-existent account
UPDATE ACCOUNTS
SET BALANCE = BALANCE + 100
WHERE ACCOUNT_ID = 999;

-- Rollback the entire transaction
ROLLBACK;

-- Verify balances are unchanged
SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS WHERE ACCOUNT_ID IN (1, 2);
```

**Explanation:** 

The `ROLLBACK` command is part of the ACID properties of a transaction (specifically, Atomicity). It ensures that if any part of a multi-step operation fails, the entire operation is undone, and the database returns to its original state. This is crucial for financial operations to prevent data inconsistencies.

### Exercise 3: Viewing and Auditing Data Changes - Solution

```sql
SELECT
    USERNAME,
    IP_ADDRESS,
    LOGIN_TIMESTAMP
FROM
    LOGIN_AUDIT
WHERE
    LOGIN_STATUS = 'FAILED'
ORDER BY
    LOGIN_TIMESTAMP DESC;
```

**Explanation:** 

This report identifies all failed login attempts. An internal control officer can analyze this data to spot multiple failed attempts from a single `IP_ADDRESS` or against a specific `USERNAME`. This could be an indicator of a brute-force attack or a compromised account, allowing the security team to take proactive measures.
