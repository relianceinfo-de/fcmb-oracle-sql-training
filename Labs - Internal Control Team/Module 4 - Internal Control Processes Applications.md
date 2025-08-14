## Module 4: Internal Control Processes Applications

### Scenario

This module is a hands-on application of your SQL knowledge to real-world internal control and compliance scenarios. You will use SQL to build reports, detect potential fraud, and audit user privileges.

### Exercise 1: Building Reports for Regulatory Compliance

You need to create a report for the compliance requirement to identify any transactions that exceed a regulatory threshold of #500,000, which may require additional scrutiny.

**Tasks:**

1.  Write a query that selects `TRANSACTION_ID`, `ACCOUNT_ID`, `AMOUNT`, and `TRANSACTION_DATE` from the `TRANSACTIONS` table.
```sql
-- Enter query here..


```

3.  Filter the results to only include transactions where the `AMOUNT` is greater than 500000.
```sql
-- Enter query here..


```
-----

### Exercise 2: Detecting Anomalies and Potential Fraud

The fraud detection system needs a report on dormant accounts, which could be a sign of a data integrity issue or a prelude to a fraudulent takeover.

**Tasks:**

1.  Assume a dormant account is one with no transactions in the last 365 days.

2.  Write a query that identifies all `ACCOUNT_ID`s from the `ACCOUNTS` table that do not have a corresponding transaction in the `TRANSACTIONS` table within the last year.
```sql
-- Enter query here..


```
-----

### Exercise 3: User and Privilege Management

As part of a security audit, you need to verify that a specific user, 'auditor\_user', has the correct permissions.

**Tasks:**

1.  Write a query to list all roles and privileges granted to the user 'auditor\_user'.
```sql
-- Enter query here..


```
2.  Explain why it's important to enforce the principle of least privilege for this user.
```sql
-- Comment here..


```
