## Module 5: Solutions

### Exercise 1: Introduction to Data Definition Language (DDL) - Solution

```sql
ALTER TABLE ACCOUNTS
ADD (RISK_RATING VARCHAR2(20));
```

**Explanation:** 

`ALTER TABLE` is a DDL command that changes the structure of a table. In a production environment, this can be risky because it can lock the table, impact performance, and, if not planned correctly, can lead to data loss or inconsistencies. It is a powerful command and should always be executed with prior planning and approval.

### Exercise 2: Managing User Permissions - Solution

**Granting Privileges:**

```sql
GRANT SELECT ON TRANSACTIONS TO analyst_user;
GRANT SELECT ON ACCOUNTS TO analyst_user;
```

**Revoking Privileges:**

```sql
REVOKE SELECT ON TRANSACTIONS FROM analyst_user;
```

**Explanation:** 

`GRANT` and `REVOKE` are crucial for enforcing access control. By granting only the necessary `SELECT` privileges, you adhere to the principle of least privilege. The `REVOKE` command ensures that when a user's role or project ends, their access is immediately and securely removed, preventing unauthorized access to sensitive data.

### Exercise 3: Performance Considerations - Solution

```sql
EXPLAIN PLAN FOR
SELECT
    c.FIRST_NAME,
    c.LAST_NAME
FROM
    CUSTOMERS c
WHERE
    (
        SELECT
            COUNT(a.ACCOUNT_ID)
        FROM
            ACCOUNTS a
        WHERE
            a.CUSTOMER_ID = c.CUSTOMER_ID
    ) > 1;
```

**Explanation:** 

`EXPLAIN PLAN` shows the execution path Oracle takes to run a query. In this case, it might show a **full table scan** on the `ACCOUNTS` table for every row in the `CUSTOMERS` table. This is very inefficient. If an index exists on `ACCOUNTS.CUSTOMER_ID`, Oracle can use that index to quickly locate the relevant account rows for each customer, avoiding the full table scan and drastically improving query performance.
