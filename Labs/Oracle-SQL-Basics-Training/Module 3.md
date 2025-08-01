
# Module 3 - Banking Database Schema Management

## Learning Outcomes
- Design tables for core banking operations  
- Implement constraints for data integrity  
- Manage schema changes in production environments  

---

## Lab: FCMB Customer Onboarding System

### Business Scenario  
FCMB needs to:  
1. Create a new `customer_kyc` table for enhanced compliance  
2. Modify `accounts` table to support new digital banking products  
3. Safely archive inactive customers  

---

### Exercise 1: Create KYC Tables  
```sql
-- Core customer table
CREATE TABLE fcmb_customers (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bvn VARCHAR2(11) UNIQUE NOT NULL,
    full_name VARCHAR2(100) NOT NULL,
    tier_level VARCHAR2(10) CHECK (tier_level IN ('BASIC','PREMIUM','PRIVATE'))
    TABLESPACE fcmb_data;

-- KYC documents tracking
CREATE TABLE customer_kyc (
    doc_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES fcmb_customers,
    doc_type VARCHAR2(20) CHECK (doc_type IN ('ID','UTILITY','SIGNATURE')),
    verified_date DATE DEFAULT SYSDATE
);
```

**Business Rules**:  
- BVN must be unique and mandatory  
- Tier levels determine service eligibility  

---

### Exercise 2: Modify Accounts Table  
```sql
-- Add digital banking columns
ALTER TABLE fcmb_accounts ADD (
    mobile_app_enabled CHAR(1) DEFAULT 'N' CHECK (mobile_app_enabled IN ('Y','N')),
    ussd_pin VARCHAR2(4),
    last_activity_date DATE
);

-- Add constraint for dormant accounts
ALTER TABLE fcmb_accounts 
ADD CONSTRAINT chk_dormant 
CHECK (
    (last_activity_date > ADD_MONTHS(SYSDATE, -12) OR 
    status = 'DORMANT')
);
```

---

### Exercise 3: Safe Data Archiving  
```sql
-- Step 1: Create archive table
CREATE TABLE archived_customers 
AS SELECT * FROM fcmb_customers WHERE 1=0;

-- Step 2: Archive inactive customers
INSERT INTO archived_customers
SELECT * FROM fcmb_customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM fcmb_accounts 
    GROUP BY customer_id
    HAVING MAX(last_activity_date) < ADD_MONTHS(SYSDATE, -24)
);

-- Step 3: Verify before deletion
SELECT COUNT(*) FROM archived_customers;

-- Step 4: Execute deletion (with transaction safety)
BEGIN
  DELETE FROM fcmb_customers 
  WHERE customer_id IN (SELECT customer_id FROM archived_customers);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN ROLLBACK;
END;
```

---

## Key Takeaways  
| Concept | Banking Application |  
|---------|---------------------|  
| Constraints | Enforce CBN KYC rules |  
| ALTER TABLE | Roll out new features without downtime |  
| Safe Deletion | Compliance with data retention policies |  

