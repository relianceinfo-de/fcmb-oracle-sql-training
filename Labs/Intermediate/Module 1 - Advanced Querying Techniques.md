# Module 1: Advanced Querying Techniques

This lab focuses on mastering advanced SQL querying techniques, including `GROUP BY`, `HAVING`, and complex `ORDER BY` clauses.

## Scenario

You are a Junior Analyst at FCMB. Your team is responsible for generating summary reports for the bank's account and transaction data. Your task is to use advanced SQL techniques to answer specific business questions and provide meaningful insights.

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
INSERT INTO Bank_Accounts VALUES (107, 6, 'Loan', 0.00, 10);
INSERT INTO Bank_Accounts VALUES (108, 7, 'Savings', 500.00, 30);
INSERT INTO Bank_Accounts VALUES (109, 8, 'Checking', 9000.00, 20);
INSERT INTO Bank_Accounts VALUES (110, 9, 'Savings', 100.00, 10);
INSERT INTO Bank_Accounts VALUES (111, 10, 'Checking', 4000.00, 30);
INSERT INTO Bank_Accounts VALUES (112, 1, 'Loan', 0.00, 10);

COMMIT;
```

## Lab Exercises

### Exercise 1: Using GROUP BY to Aggregate Data

The bank's management wants a summary of the total funds held in each type of account.

#### Task:

1. Write a query that calculates the sum of `balance` for each `account_type`.

2. Also, count the number of accounts for each `account_type`.

### Exercise 2: Filtering Aggregated Results with HAVING

The head of retail banking is only interested in account types where the average balance is greater than $5,000.

#### Task:

1. Starting with your previous query, modify it to show only the `account_type` where the `AVG(balance)` is greater than 5000.

2. Explain why `HAVING` is used here instead of `WHERE`.

### Exercise 3: Applying Complex ORDER BY Operations

A new report needs to list all bank accounts, but the results must be sorted in a specific way: first by `branch_id` in ascending order, and then by `balance` in descending order for all accounts within the same branch.

#### Task:

1. Write a query to retrieve all columns from the `Bank_Accounts` table.

2. Order the results first by `branch_id` (ascending) and then by `balance` (descending).