# Module 2: Working with Joins

This lab focuses on the different types of joins used to combine data from multiple tables.

### Scenario

You are a Data Analyst at FCMB. You have been asked to create several reports that combine information from different parts of the bank's database to provide a holistic view of customers and their financial products.

## Setup

In addition to the tables from Module 1, let's create a new `Employees` table for the `SELF JOIN` exercise and a `Loans` table for the `FULL JOIN` exercise.

```
-- Create Loans table
CREATE TABLE Loans (
    loan_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    loan_amount NUMBER(18, 2),
    loan_type VARCHAR2(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Employees table
CREATE TABLE Employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100),
    manager_id NUMBER,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

-- Insert data into Loans
INSERT INTO Loans VALUES (1, 1, 150000.00, 'Mortgage');
INSERT INTO Loans VALUES (2, 3, 25000.00, 'Auto');
INSERT INTO Loans VALUES (3, 5, 5000.00, 'Personal');
INSERT INTO Loans VALUES (4, 7, 75000.00, 'Auto');
INSERT INTO Loans VALUES (5, 9, 1000.00, 'Personal');
-- Loan without a customer in the Customers table
INSERT INTO Loans VALUES (6, 999, 50000.00, 'Business');

-- Insert data into Employees
INSERT INTO Employees VALUES (1, 'John Smith', NULL); -- The CEO
INSERT INTO Employees VALUES (2, 'Jane Doe', 1);
INSERT INTO Employees VALUES (3, 'Peter Jones', 1);
INSERT INTO Employees VALUES (4, 'Susan Chen', 2);
INSERT INTO Employees VALUES (5, 'David Lee', 2);
INSERT INTO Employees VALUES (6, 'Mary Garcia', 3);

COMMIT;
```

## Lab Exercises

### Exercise 1: Using INNER JOIN

The sales team needs a list of all customers who currently have an active bank account.

#### Task:

1. Write a query that uses an `INNER JOIN` to combine the `Customers` and `Bank_Accounts` tables.

2. Display the `customer_name` and `account_number` for each matching record.

### Exercise 2: Using LEFT JOIN

The marketing department wants to send an email to all customers, including those who have not yet opened an account.

#### Task:

1. Write a query that uses a `LEFT JOIN` to show all customers from the `Customers` table.

2. If a customer has a `Bank_Accounts` record, display their `account_number`; otherwise, display `NULL`.

### Exercise 3: Using RIGHT JOIN

The compliance team needs to verify that every active bank account is linked to a valid customer in the `Customers` table.

#### Task:

1. Write a query that uses a `RIGHT JOIN` to list all bank accounts.

2. Display the `account_number` and the corresponding `customer_name`, if one exists.

### Exercise 4: Using SELF JOIN

The human resources department needs an organization chart showing which employees report to which managers.

#### Task:

1. Write a query that uses a `SELF JOIN` on the `Employees` table.

2. List each employee's name alongside their manager's name.

### Exercise 5: Using FULL JOIN

The data integrity team wants to find customers without loans and loans without a corresponding customer entry.

#### Task:

1. Write a query using a `FULL JOIN` to combine the `Customers` and `Loans` tables.

2. Display the `customer_name`, `loan_id`, and `loan_amount` for all records, showing `NULL` for unmatched entries on either side.