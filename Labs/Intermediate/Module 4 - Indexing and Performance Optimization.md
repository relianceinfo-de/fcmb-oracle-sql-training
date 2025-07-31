# Module 4: Indexing and Performance Optimization

This lab focuses on understanding and applying indexing strategies and using `EXPLAIN PLAN` to optimize query performance in an Oracle SQL environment.

## Scenario

You are a Junior Database Administrator at FCMB. Your team is responsible for ensuring the optimal performance of the bank's core banking system. You've received complaints about slow query execution times for certain reports. Your task is to investigate these performance issues using indexing and `EXPLAIN PLAN`.

## Setup

First, let's create some sample tables and insert data to simulate a banking environment.

```
-- Create Customers table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    email VARCHAR2(100),
    phone_number VARCHAR2(20),
    address VARCHAR2(200)
);

-- Create Bank_Accounts table
CREATE TABLE Bank_Accounts (
    account_number NUMBER PRIMARY KEY,
    customer_id NUMBER,
    account_type VARCHAR2(50),
    balance NUMBER(18, 2),
    branch_id NUMBER,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_number NUMBER,
    transaction_date DATE,
    amount NUMBER(18, 2),
    transaction_type VARCHAR2(50),
    description VARCHAR2(200),
    FOREIGN KEY (account_number) REFERENCES Bank_Accounts(account_number)
);

-- Insert sample data into Customers
INSERT INTO Customers VALUES (1, 'Alice Smith', 'alice.s@example.com', '555-1001', '123 Main St');
INSERT INTO Customers VALUES (2, 'Bob Johnson', 'bob.j@example.com', '555-1002', '456 Oak Ave');
INSERT INTO Customers VALUES (3, 'Charlie Brown', 'charlie.b@example.com', '555-1003', '789 Pine Ln');
INSERT INTO Customers VALUES (4, 'Diana Prince', 'diana.p@example.com', '555-1004', '101 Elm Rd');
INSERT INTO Customers VALUES (5, 'Eve Davis', 'eve.d@example.com', '555-1005', '202 Birch St');
INSERT INTO Customers VALUES (6, 'Frank White', 'frank.w@example.com', '555-1006', '303 Cedar Blvd');
INSERT INTO Customers VALUES (7, 'Grace Lee', 'grace.l@example.com', '555-1007', '404 Maple Dr');
INSERT INTO Customers VALUES (8, 'Henry King', 'henry.k@example.com', '555-1008', '505 Willow Ct');
INSERT INTO Customers VALUES (9, 'Ivy Green', 'ivy.g@example.com', '555-1009', '606 Spruce Way');
INSERT INTO Customers VALUES (10, 'Jack Black', 'jack.b@example.com', '555-1010', '707 Poplar St');


-- Insert sample data into Bank_Accounts
INSERT INTO Bank_Accounts VALUES (101, 1, 'Savings', 15000.00, 10);
INSERT INTO Bank_Accounts VALUES (102, 1, 'Checking', 5000.00, 10);
INSERT INTO Bank_Accounts VALUES (103, 2, 'Savings', 25000.00, 20);
INSERT INTO Bank_Accounts VALUES (104, 3, 'Checking', 1200.00, 10);
INSERT INTO Bank_Accounts VALUES (105, 4, 'Savings', 30000.00, 30);
INSERT INTO Bank_Accounts VALUES (106, 5, 'Checking', 8000.00, 20);
INSERT INTO Bank_Accounts VALUES (107, 6, 'Loan', 0.00, 10); -- Represents an open loan account with 0 balance
INSERT INTO Bank_Accounts VALUES (108, 7, 'Savings', 500.00, 30);
INSERT INTO Bank_Accounts VALUES (109, 8, 'Checking', 9000.00, 20);
INSERT INTO Bank_Accounts VALUES (110, 9, 'Savings', 100.00, 10);
INSERT INTO Bank_Accounts VALUES (111, 10, 'Checking', 4000.00, 30);
INSERT INTO Bank_Accounts VALUES (112, 1, 'Loan', 0.00, 10); -- Alice also has a loan

-- Insert sample data into Transactions
INSERT INTO Transactions VALUES (10001, 101, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 500.00, 'Deposit', 'Online Transfer');
INSERT INTO Transactions VALUES (10002, 102, TO_DATE('2024-01-16', 'YYYY-MM-DD'), -200.00, 'Withdrawal', 'ATM');
INSERT INTO Transactions VALUES (10003, 101, TO_DATE('2024-02-01', 'YYYY-MM-DD'), -100.00, 'Withdrawal', 'Bill Payment');
INSERT INTO Transactions VALUES (10004, 103, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 1000.00, 'Deposit', 'Payroll');
INSERT INTO Transactions VALUES (10005, 104, TO_DATE('2024-03-01', 'YYYY-MM-DD'), -50.00, 'Withdrawal', 'Online Purchase');
INSERT INTO Transactions VALUES (10006, 105, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 2000.00, 'Deposit', 'Branch Deposit');
INSERT INTO Transactions VALUES (10007, 106, TO_DATE('2024-04-01', 'YYYY-MM-DD'), -300.00, 'Withdrawal', 'ATM');
INSERT INTO Transactions VALUES (10008, 101, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 100.00, 'Deposit', 'Interest');
INSERT INTO Transactions VALUES (10009, 103, TO_DATE('2024-04-10', 'YYYY-MM-DD'), -500.00, 'Withdrawal', 'Rent Payment');
INSERT INTO Transactions VALUES (10010, 107, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 5000.00, 'Loan Disbursement', 'New Loan'); -- Loan transaction
INSERT INTO Transactions VALUES (10011, 107, TO_DATE('2024-02-20', 'YYYY-MM-DD'), -250.00, 'Loan Repayment', 'Monthly Installment'); -- Loan repayment
INSERT INTO Transactions VALUES (10012, 101, TO_DATE('2024-05-01', 'YYYY-MM-DD'), -75.00, 'Withdrawal', 'Online Subscription');
INSERT INTO Transactions VALUES (10013, 105, TO_DATE('2024-05-15', 'YYYY-MM-DD'), -1000.00, 'Withdrawal', 'Home Repair');
INSERT INTO Transactions VALUES (10014, 108, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 200.00, 'Deposit', 'Cash Deposit');
INSERT INTO Transactions VALUES (10015, 109, TO_DATE('2024-06-10', 'YYYY-MM-DD'), -150.00, 'Withdrawal', 'Utility Bill');
INSERT INTO Transactions VALUES (10016, 110, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 50.00, 'Deposit', 'Small Deposit');
INSERT INTO Transactions VALUES (10017, 111, TO_DATE('2024-06-20', 'YYYY-MM-DD'), -20.00, 'Withdrawal', 'Coffee Purchase');
INSERT INTO Transactions VALUES (10018, 102, TO_DATE('2024-06-25', 'YYYY-MM-DD'), 300.00, 'Deposit', 'Refund');
INSERT INTO Transactions VALUES (10019, 104, TO_DATE('2024-07-01', 'YYYY-MM-DD'), -10.00, 'Withdrawal', 'ATM Fee');
INSERT INTO Transactions VALUES (10020, 106, TO_DATE('2024-07-05', 'YYYY-MM-DD'), 500.00, 'Deposit', 'Salary Part');
INSERT INTO Transactions VALUES (10021, 112, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 10000.00, 'Loan Disbursement', 'Mortgage'); -- Alice's mortgage
INSERT INTO Transactions VALUES (10022, 112, TO_DATE('2024-04-01', 'YYYY-MM-DD'), -500.00, 'Loan Repayment', 'Mortgage Payment');

COMMIT;
```

## Lab Exercises

### Exercise 1: Analyzing an Inefficient Query

A common report frequently checks customer account balances and associated details. Currently, the query used for this report is slow when searching for specific customers.

#### Task:

1. Execute the following query and then use `EXPLAIN PLAN` to see its execution plan. Note the `COST` and `CARDINALITY` values, and identify the access path for the Customers table.

2. Based on the access path, suggest if an index would be beneficial.

```
SELECT c.customer_name, a.account_number, a.balance, a.account_type
FROM Customers c
JOIN Bank_Accounts a ON c.customer_id = a.customer_id
WHERE c.customer_name = 'Alice Smith';
```

### Exercise 2: Creating and Utilizing a B-tree Index

To speed up searches by `customer_name`, you decide to create a B-tree index.

#### Task:

1. Create a B-tree index on the `customer_name` column in the `Customers` table.

2. Re-run the query from Exercise 1.

3. Use `EXPLAIN PLAN` again to observe the new execution plan. What differences do you notice in `COST`, `CARDINALITY`, and the access path for the `Customers` table?

### Exercise 3: Understanding Bitmap Indexes

The bank also frequently analyzes account types and their aggregated balances. While `account_type` has low cardinality (e.g., 'Savings', 'Checking', 'Loan'), it is often used in filtering and grouping.

#### Task:

1. Create a Bitmap index on the `account_type` column in the `Bank_Accounts` table.

2. Execute the following query and then use `EXPLAIN PLAN` to see its execution plan. Pay attention to how the `account_type` column is accessed.

```
SELECT account_type, SUM(balance)
FROM Bank_Accounts
WHERE account_type = 'Savings' OR account_type = 'Checking'
GROUP BY account_type;
```

### Exercise 4: Identifying When Not to Index

Not all columns benefit from indexing. High update frequency or very low cardinality can make an index less effective or even detrimental.

#### Task:

1. Consider the `phone_number` column in the `Customers` table. Would a B-tree index be generally beneficial or detrimental for this column if `phone_number` is frequently updated (e.g., customers changing their contact details)? Explain your reasoning.

2. Consider the `branch_id` column in `Bank_Accounts`. If there are only 3 branches in the entire bank, but millions of accounts, would a B-tree index be the most effective choice, or would a Bitmap index be more suitable, or no index at all? Explain your reasoning.

