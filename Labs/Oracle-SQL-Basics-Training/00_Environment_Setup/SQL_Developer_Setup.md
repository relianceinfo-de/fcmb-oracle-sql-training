## **2. SQL Developer Installation**

### **All Platforms**

### 1. **Download**:  
   [SQL Developer Download](https://www.oracle.com/database/sqldeveloper/)

### 2. **Platform-Specific Steps**:  

   **Windows**:  
   - Run `.exe` installer  
   - Launch from Start Menu  

   **macOS**:  
   ```bash
   brew install --cask oracle-sql-developer
   ```
   **Linux**
   ```bash
   unzip sqldeveloper-*.zip
./sqldeveloper/sqldeveloper.sh
```
### 2. Create new connection:
   - Name: `TrainingDB`
   - Username: `system`
   - Password: `oracle123`
   - Hostname: `localhost`
   - Port: `1521`
   - SID: `XE`
---

-- Check database version
SELECT * FROM v$version;

-- Verify banking schema
SELECT table_name FROM all_tables WHERE owner = 'BANKING';

### **Output**
Oracle Database 21c Express Edition Release 21.0.0.0.0

CUSTOMERS

ACCOUNTS

TRANSACTIONS

## **3. Sample Database Setup**

```sql
-- =============================================
-- FCMB DEMONSTRATION DATABASE SETUP
-- =============================================

-- Core Customer Table
CREATE TABLE fcmb_customers (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bvn VARCHAR2(11) NOT NULL UNIQUE,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone VARCHAR2(15),
    tier_level VARCHAR2(10) CHECK (tier_level IN ('BASIC', 'PREMIUM', 'PRIVATE')),
    join_date DATE DEFAULT SYSDATE,
    kyc_verified CHAR(1) DEFAULT 'N' CHECK (kyc_verified IN ('Y','N'))
TABLESPACE users;

-- Account Master Table
CREATE TABLE fcmb_accounts (
    account_no VARCHAR2(10) PRIMARY KEY, -- NUBAN format
    customer_id NUMBER NOT NULL,
    account_type VARCHAR2(20) CHECK (account_type IN 
        ('SAVINGS', 'CURRENT', 'DOMICILIARY', 'FIXED_DEPOSIT')),
    balance NUMBER(15,2) DEFAULT 0.00,
    open_date DATE DEFAULT SYSDATE,
    status VARCHAR2(10) DEFAULT 'ACTIVE' CHECK (status IN 
        ('ACTIVE', 'DORMANT', 'CLOSED')),
    branch_code VARCHAR2(5) NOT NULL,
    last_activity_date DATE,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
        REFERENCES fcmb_customers(customer_id)
) TABLESPACE users;

-- Transaction Records
CREATE TABLE fcmb_transactions (
    txn_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_no VARCHAR2(10) NOT NULL,
    amount NUMBER(15,2) NOT NULL,
    txn_type VARCHAR2(15) CHECK (txn_type IN 
        ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER', 'BILL_PAYMENT')),
    txn_date TIMESTAMP DEFAULT SYSDATE,
    beneficiary VARCHAR2(100),
    description VARCHAR2(200),
    reference VARCHAR2(20) UNIQUE,
    CONSTRAINT fk_account FOREIGN KEY (account_no) 
        REFERENCES fcmb_accounts(account_no)
) TABLESPACE users;

-- Branch Information
CREATE TABLE fcmb_branches (
    branch_code VARCHAR2(5) PRIMARY KEY,
    branch_name VARCHAR2(100) NOT NULL,
    region VARCHAR2(20) NOT NULL,
    address VARCHAR2(200),
    manager_id NUMBER
) TABLESPACE users;

-- KYC Documentation
CREATE TABLE fcmb_kyc_documents (
    doc_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    doc_type VARCHAR2(20) CHECK (doc_type IN 
        ('ID_CARD', 'UTILITY_BILL', 'PASSPORT', 'SIGNATURE')),
    doc_number VARCHAR2(50),
    expiry_date DATE,
    verified_date DATE,
    CONSTRAINT fk_kyc_customer FOREIGN KEY (customer_id) 
        REFERENCES fcmb_customers(customer_id)
) TABLESPACE users;

-- Loan Products
CREATE TABLE fcmb_loans (
    loan_id VARCHAR2(15) PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    principal_amount NUMBER(15,2) NOT NULL,
    interest_rate NUMBER(5,2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR2(10) DEFAULT 'ACTIVE' CHECK (status IN 
        ('ACTIVE', 'CLOSED', 'DEFAULTED')),
    CONSTRAINT fk_loan_customer FOREIGN KEY (customer_id) 
        REFERENCES fcmb_customers(customer_id)
) TABLESPACE users;

-- =============================================
-- SAMPLE DATA INSERTION
-- =============================================

-- Insert sample branches
INSERT INTO fcmb_branches VALUES 
('LAG01', 'LAGOS MAIN', 'SOUTHWEST', '21 Marina Road', 1001),
('ABJ01', 'ABUJA CENTRAL', 'NORTH', '1 Eagle Square', 1002),
('PHC01', 'PORT HARCOURT', 'SOUTH', '22 Aba Road', 1003);

-- Insert sample customers
INSERT INTO fcmb_customers (bvn, first_name, last_name, email, tier_level) VALUES 
('22345678901', 'Adeola', 'Johnson', 'adeola.j@email.com', 'PREMIUM'),
('22345678902', 'Chinedu', 'Okoro', 'chinedu.o@email.com', 'BASIC'),
('22345678903', 'Folake', 'Bello', 'folake.b@email.com', 'PRIVATE');

-- Insert sample accounts
INSERT INTO fcmb_accounts VALUES 
('1234567890', 1, 'SAVINGS', 12450000, TO_DATE('01-JAN-2022'), 'ACTIVE', 'LAG01', SYSDATE),
('9876543210', 1, 'CURRENT', 8200000, TO_DATE('15-MAR-2022'), 'ACTIVE', 'LAG01', SYSDATE),
('5555666677', 2, 'SAVINGS', 350000, TO_DATE('10-JUL-2023'), 'ACTIVE', 'ABJ01', SYSDATE);

-- Insert sample transactions
INSERT INTO fcmb_transactions (account_no, amount, txn_type, beneficiary, description) VALUES 
('1234567890', 5000000, 'DEPOSIT', 'CASH', 'Branch deposit'),
('9876543210', 200000, 'TRANSFER', 'GTB-123456', 'School fees payment'),
('5555666677', 150000, 'BILL_PAYMENT', 'IKEDC', 'Electricity bill');

COMMIT;

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

CREATE INDEX idx_account_balance ON fcmb_accounts(balance);
CREATE INDEX idx_txn_date ON fcmb_transactions(txn_date);
CREATE INDEX idx_customer_name ON fcmb_customers(last_name, first_name);

-- =============================================
-- VIEWS FOR COMMON REPORTS
-- =============================================

CREATE VIEW vw_customer_portfolio AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    COUNT(a.account_no) AS total_accounts,
    SUM(a.balance) AS total_balance
FROM fcmb_customers c
JOIN fcmb_accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- =============================================
-- SETUP COMPLETE
-- =============================================
PROMPT FCMB demonstration database ready with:
PROMPT - 3 branches
PROMPT - 3 customers
PROMPT - 3 accounts
PROMPT - 3 sample transactions
```


