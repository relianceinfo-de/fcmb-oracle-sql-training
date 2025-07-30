---
Lab:
    Module 1: 'Expanding SQL Skills​ (Advanced Querying Techniques)'
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
 ```
### Step 2: Filter for High-Performing Account Types

```sql
SELECT account_type, AVG(balance) AS average_balance
FROM bank_accounts
GROUP BY account_type
HAVING AVG(balance) > 10000;
 ```

### Step 3: Rank Customers by Value Within Branches

```sql
SELECT customer_id, branch_id, account_balance
FROM customer_accounts
ORDER BY branch_id ASC, account_balance DESC;
 ```

### Business Impact
#### By combining these insights, FCMB can:
1. Realign product and marketing strategies based on account performance
1. Launch loyalty programs targeting valuable customers
1. Allocate relationship managers to branches with high-value clientele
