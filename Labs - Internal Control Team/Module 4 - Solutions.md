## Module 4: Solutions

### Exercise 1: Building Reports for Regulatory Compliance - Solution

```sql
SELECT
    TRANSACTION_ID,
    ACCOUNT_ID,
    AMOUNT,
    TRANSACTION_DATE
FROM
    TRANSACTIONS
WHERE
    AMOUNT > 10000;
```

**Explanation:** 

This query is a simple but useful for regulatory compliance. By identifying transactions that exceed a set threshold, it allows the compliance team to focus their efforts on a specific subset of data that requires manual review and due diligence, such as for Anti-Money Laundering (AML) checks.

### Exercise 2: Detecting Anomalies and Potential Fraud - Solution

```sql
SELECT
    a.ACCOUNT_ID
FROM
    ACCOUNTS a
WHERE
    a.ACCOUNT_ID NOT IN (
        SELECT
            t.ACCOUNT_ID
        FROM
            TRANSACTIONS t
        WHERE
            t.TRANSACTION_DATE > SYSDATE - 365
    );
```

**Explanation:** 

This query uses a subquery to find all accounts that have had a transaction within the last year. The outer query then uses `NOT IN` to select all other accounts, effectively identifying those that are dormant. This is a vital check for data integrity and for flagging accounts that may be at a higher risk of being compromised.

### Exercise 3: User and Privilege Management - Solution

```sql
SELECT
    GRANTED_ROLE AS role_or_privilege
FROM
    USER_ROLE_PRIVS
WHERE
    USERNAME = 'auditor_user'
UNION
SELECT
    PRIVILEGE
FROM
    USER_TAB_PRIVS_RECD
WHERE
    GRANTEE = 'auditor_user';
```

**Explanation:** 

This query combines information from system views to show all roles and privileges assigned to a user. The principle of least privilege is crucial because it limits a user's access to only what they absolutely need. For an auditor, this might mean they have `SELECT` access to all tables but are explicitly denied `INSERT`, `UPDATE`, or `DELETE` privileges to prevent accidental or malicious data modification.