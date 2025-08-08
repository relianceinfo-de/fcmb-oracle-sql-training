## Module 1 - Solutions

### Exercise 1: Exploring a Table's Structure - Solution

```sql
DESCRIBE CUSTOMERS;
```

**or**

```sql
SELECT column_name, data_type
FROM user_tab_cols
WHERE table_name = 'CUSTOMERS';
```

**Count of Customers:**

```sql
SELECT COUNT(*) FROM CUSTOMERS;
```

**Explanation:** 

The `DESCRIBE` command (or querying `user_tab_cols`) is a fundamental tool for understanding table structure. Knowing the number of customers helps establish a baseline for your data and is the first step in any data integrity check.

### Exercise 2: Understanding Data Relationships - Solution

```sql
SELECT
    c.FIRST_NAME,
    c.LAST_NAME,
    a.ACCOUNT_ID
FROM
    CUSTOMERS c
JOIN
    ACCOUNTS a ON c.CUSTOMER_ID = a.CUSTOMER_ID;
```

**Explanation:** 

The tables are linked by the **`CUSTOMER_ID`** column. This relationship is enforced by a **foreign key** constraint, which ensures that every `ACCOUNT_ID` in the `ACCOUNTS` table must correspond to a valid `CUSTOMER_ID` in the `CUSTOMERS` table. This prevents "orphan" records and is vital for maintaining data integrity.

### Exercise 3: Security and Auditing Awareness - Solution

```sql
SELECT USERNAME, ROLE FROM USERS;
```

**Explanation:** 

Auditing the `USERS` table is critical because it reveals who has access to the database. The **principle of least privilege** dictates that users should only have the permissions necessary to perform their jobs. Regular audits ensure that no unauthorized users exist and that privileges are appropriate, thereby mitigating the risk of fraud and data breaches.

