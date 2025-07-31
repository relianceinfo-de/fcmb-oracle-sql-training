## **2. SQL Developer Installation**

### **All Platforms**
``
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

## **3. Sample Database Setup**

### **Banking Database (All Platforms)**
```sql
-- Run in SQL Developer/SQL*Plus
CREATE TABLESPACE banking_ts 
DATAFILE 'banking.dbf' SIZE 200M AUTOEXTEND ON;

CREATE USER banking IDENTIFIED BY banking123 
DEFAULT TABLESPACE banking_ts QUOTA UNLIMITED ON banking_ts;

GRANT CONNECT, RESOURCE TO banking;

CONNECT banking/banking123;

-- Create tables
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE
);

-- Check database version
SELECT * FROM v$version;

-- Verify banking schema
SELECT table_name FROM all_tables WHERE owner = 'BANKING';
```
### **Output**
Oracle Database 21c Express Edition Release 21.0.0.0.0
CUSTOMERS
ACCOUNTS
TRANSACTIONS
