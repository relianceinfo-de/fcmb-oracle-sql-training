# Module 6 - Financial Data Transformation

## Learning Outcomes
- Format customer data for statements  
- Calculate interest and fees  
- Generate regulatory reports  

---

## Lab: FCMB Monthly Reporting

### Business Scenario  
Prepare:  
1. Customer statement templates  
2. Interest accrual calculations  
3. CBN regulatory extracts  

---

### Exercise 1: String Formatting  
```sql
-- Customer mailing labels
SELECT 
    INITCAP(first_name) || ' ' || INITCAP(last_name) AS customer_name,
    SUBSTR(bvn, 1, 3) || '****' || SUBSTR(bvn, 8) AS masked_bvn,
    CONCAT('Acct: ', account_no) AS account_label
FROM fcmb_customers c
JOIN fcmb_accounts a ON c.customer_id = a.customer_id;
```

**Functions Used**:  
- `INITCAP()`: Proper case names  
- `SUBSTR()` + `CONCAT()`: Mask sensitive data  
- `||`: String concatenation  

---

### Exercise 2: Financial Calculations  
```sql
-- Loan repayment schedule
SELECT
    loan_id,
    ROUND(principal_amount, 2) AS principal,
    ROUND(principal_amount * (interest_rate/12), 2) AS monthly_interest,
    TRUNC(due_date) AS payment_date,
    ADD_MONTHS(due_date, 1) AS next_due_date
FROM fcmb_loans
WHERE status = 'ACTIVE';
```

**Numerical Functions**:  
- `ROUND()`: Clean monetary values  
- `TRUNC()`: Remove time components  

---

### Exercise 3: Regulatory Reporting  
```sql
-- CBN large transactions report
SELECT 
    account_no,
    TO_CHAR(txn_date, 'DD-MON-YYYY HH24:MI') AS formatted_date,
    CASE 
        WHEN amount > 5000000 THEN 'LARGE'
        WHEN amount > 1000000 THEN 'MEDIUM' 
        ELSE 'STANDARD'
    END AS txn_category,
    MONTHS_BETWEEN(SYSDATE, txn_date) AS months_ago
FROM fcmb_transactions
WHERE txn_date BETWEEN TO_DATE('01-JAN-2024') AND SYSDATE
  AND amount >= 1000000
ORDER BY EXTRACT(MONTH FROM txn_date), amount DESC;
```

**Date Functions**:  
- `TO_CHAR()`: Format dates  
- `MONTHS_BETWEEN()`: Aging analysis  
- `EXTRACT()`: Period grouping  

---

## Function Nesting Example  
```sql
-- Account maturity notification
SELECT 
    account_no,
    UPPER(account_type) || ' MATURES ON ' || 
    TO_CHAR(ADD_MONTHS(open_date, 12), 'DD-FMMonth-YYYY') AS maturity_alert
FROM fcmb_accounts
WHERE account_type IN ('FIXED_DEPOSIT','TREASURY_BILL')
  AND MONTHS_BETWEEN(SYSDATE, open_date) BETWEEN 10 AND 11;
```

---

## Key Banking Applications  
| Function Type | Use Case | Example |
|--------------|----------|---------|
| **String** | Masking PII | `SUBSTR(bvn,1,3)||'****'` |
| **Numeric** | Interest Calc | `ROUND(balance*0.045/365,2)` |
| **Date** | Maturity Alerts | `ADD_MONTHS(open_date,12)` |

