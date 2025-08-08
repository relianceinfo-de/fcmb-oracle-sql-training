## Module 5: Advanced SQL Concepts

### Scenario

This final module introduces you to advanced concepts that go beyond data retrieval. You will learn about the commands that define the database structure, manage user permissions, and optimize query performance, all of which are essential for a complete understanding of database control.

### Exercise 1: Introduction to Data Definition Language (DDL)

Your team is considering adding a new column to the `ACCOUNTS` table to store a risk rating.

**Tasks:**

1.  Write the DDL command to add a new column `RISK_RATING` of type `VARCHAR2(20)` to the `ACCOUNTS` table.

2.  Explain why `ALTER TABLE` is a powerful command that should be used with extreme caution in a production environment.

-----

### Exercise 2: Managing User Permissions

A new analyst, 'analyst\_user', has joined the team. They need read-only access to the `TRANSACTIONS` and `ACCOUNTS` tables.

**Tasks:**

1.  Write the SQL command to `GRANT` the `SELECT` privilege on the `TRANSACTIONS` and `ACCOUNTS` tables to 'analyst\_user'.
2.  After their project is complete, write the SQL command to `REVOKE` the `SELECT` privilege on the `TRANSACTIONS` table from the same user.

-----

### Exercise 3: Performance Considerations

You've written a complex query to find all customers with multiple accounts. It seems to be running slowly. You want to see how Oracle is executing it.

**Tasks:**

1.  Use `EXPLAIN PLAN` for the following query to understand its execution path:
    ```sql
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

2.  Based on the plan, explain how indexing on `CUSTOMER_ID` could improve the performance of this query.
