## Module 3: Data Integrity and Control with SQL

### Scenario

The integrity of the FCMB's data is paramount for internal control. This module focuses on the tools that ensure data is accurate, consistent, and secure. You will work with constraints and transactions to maintain a reliable database.

### Exercise 1: Understanding and Verifying Constraints

Your team needs to verify that the core tables are properly constrained to prevent data inconsistencies.

**Tasks:**

1.  Write a query to retrieve all constraints for the `TRANSACTIONS` table.

2.  Explain the purpose of the `TRANSACTION_ID` constraint and the `ACCOUNT_ID` constraint in this table from an internal control perspective.

-----

### Exercise 2: Transaction Management (`COMMIT` and `ROLLBACK`)

You are testing a script that updates a customer's account balance. It's critical that the process is atomic and can be undone if an error occurs.

**Tasks:**

1.  Simulate a balance transfer from one account to another, but intentionally cause an error after the first update.

2.  Use `ROLLBACK` to undo both updates.

3.  Verify that the account balances remain unchanged.

-----

### Exercise 3: Viewing and Auditing Data Changes

To ensure compliance, you must regularly monitor login activity, especially for failed attempts.

**Tasks:**

1.  Query the `LOGIN_AUDIT` table to find all failed login attempts (`LOGIN_STATUS = 'FAILED'`).

2.  Identify the `USERNAME` and `IP_ADDRESS` for these failed attempts.

3.  Explain how this report could be used to detect potential brute-force attacks or unauthorized access attempts.
