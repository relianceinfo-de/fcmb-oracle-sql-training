---
lab:
    Module: 'Expanding SQL Skills​ (Advanced Querying Techniques)'
    Use Case: 'Identifying and Prioritizing High-Value Account Segments Across Branches'
---

---

##  Scenario Overview

FCMB is conducting a quarterly performance review to:
- Understand how customer funds are distributed across different account types
- Identify account types that attract high-value customers
- Prioritize top customers within each branch for premium service and retention initiatives

This lab uses SQL techniques such as `GROUP BY`, `HAVING`, and `ORDER BY` to address these analytical goals.

---

##  Step-by-Step Queries

###  Step 1: Aggregate Total Balances by Account Type

```sql
SELECT account_type, SUM(balance) AS total_balance
FROM bank_accounts
GROUP BY account_type;

