## Module 1: Introduction to Databases and Its Applications

### Scenario

As a new member of the internal control team at FCMB, your first task is to understand the structure of the bank's data. This foundational knowledge is crucial for ensuring data integrity and security. Your manager has asked you to become familiar with the basic components of the Oracle database environment.

### Exercise 1: Exploring a Table's Structure

Your first task is to examine the `CUSTOMERS` table to understand how customer information is stored.

**Tasks:**

1.  Write a query to list all columns and their data types for the `CUSTOMERS` table.

2.  Count the total number of customers currently in the table.

-----

### Exercise 2: Understanding Data Relationships

You have been told that a customer can have one or more accounts. This is a crucial relationship for internal control audits.

**Tasks:**

1.  Using the `CUSTOMERS` and `ACCOUNTS` tables, write a query to display the `FIRST_NAME`, `LAST_NAME`, and `ACCOUNT_ID` for all customers.

2.  Explain which columns link these two tables together and why this is important for data integrity.

-----

### Exercise 3: Security and Auditing Awareness

As an internal control officer, you need to understand who has access to the database.

**Tasks:**

1.  Query the `USERS` table to find all available user accounts.

2.  Explain why it's critical for internal control to regularly audit this table.
