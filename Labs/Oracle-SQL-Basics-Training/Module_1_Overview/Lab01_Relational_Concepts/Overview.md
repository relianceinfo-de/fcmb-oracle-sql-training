```markdown
# Module 1: Overview of SQL and Oracle Database

## Learning Outcomes
- Understand relational databases
- Explain the role of SQL
- Describe Oracle Database architecture

---

## Relational Database Concepts

### What is a Relational Database?
A type of database that stores and provides access to data points related to one another. Based on E.F. Codd's 1970 model, it organizes data into tables of columns and rows, with unique keys identifying each row.

### Key Components
| Concept       | Banking Example                          |
|--------------|------------------------------------------|
| **Entities**  | Customers, Accounts, Transactions        |
| **Relationships** | One customer → Many accounts         |
| **Tables**    | `customers`, `accounts`, `transactions`  |
| **Rows**      | Individual customer records              |
| **Columns**   | `account_id`, `balance`, `open_date`     |
| **Keys**      | `customer_id` (PK), `account_id` (FK)    |

### Normalization
1. **1NF**: Ensure atomic values (no multiple values in one field)
   - ❌ Bad: `account_types: "Checking,Savings"`  
   ✅ Good: Separate rows for each account type

2. **2NF**: Remove partial dependencies  
   ```sql
   -- Instead of:
   transactions(transaction_id, account_id, branch_name)
   
   -- Use:
   transactions(transaction_id, account_id)
   accounts(account_id, branch_name)
   ```

3. **3NF**: Eliminate transitive dependencies  
   ```sql
   -- Instead of:
   customers(customer_id, zip_code, city, state)
   
   -- Use:
   customers(customer_id, zip_code)
   zip_codes(zip_code, city, state)
   ```

---

## The Role of SQL

### SQL Language Types
| Type | Purpose | Banking Example |
|------|---------|-----------------|
| **DDL** (Data Definition) | Create/modify structures | `CREATE TABLE accounts` |
| **DML** (Data Manipulation) | Manage data | `INSERT INTO transactions` |
| **DCL** (Data Control) | Permissions | `GRANT SELECT ON customers` |
| **TCL** (Transaction Control) | Manage transactions | `COMMIT`, `ROLLBACK` |

### Sample Statements
```sql
-- DDL
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- DML
INSERT INTO accounts VALUES (1001, 5000.00);

-- TCL
COMMIT;
```

---



