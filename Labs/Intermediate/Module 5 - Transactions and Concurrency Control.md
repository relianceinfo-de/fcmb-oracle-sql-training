# Module 5: Transactions and Concurrency Control

This lab focuses on understanding ACID properties, implementing transaction control (`COMMIT`, `ROLLBACK`, `SAVEPOINT`), and managing concurrency with `SELECT FOR UPDATE`.

## Scenario

You are a Senior Developer at FCMB. You are tasked with ensuring the integrity and consistency of financial transactions, especially in a high-volume, multi-user environment. You need to apply proper transaction management and concurrency control techniques to prevent data corruption and ensure reliable operations.

## Setup

We will continue using the `Customers`, `Bank_Accounts`, and `Transactions` tables from Module 4's lab. Ensure you have run the setup script from the Module 4 lab.

For this module, we will primarily focus on the `Bank_Accounts` and `Transactions` tables.

## Lab Exercises

### Exercise 1: Demonstrating Atomicity and Rollback

You need to process a money transfer between two accounts. This involves debiting one account and crediting another. This entire operation must be treated as a single, indivisible unit (Atomicity).

#### Task:

1. Start a transaction.

2. Attempt to transfer $500 from `account_number` 101 to `account_number` 102.

3. Simulate an error after the debit but before the credit (e.g., intentionally try to update a non-existent account).

4. Use `ROLLBACK` to ensure both debit and credit (if it had occurred) are undone.

5. Verify the balances of accounts 101 and 102 are unchanged.

### Exercise 2: Using Commit for Durability and Consistency

Now, perform a successful transfer and use `COMMIT` to make the changes permanent.

#### Task:

1. Start a new transaction.

2. Transfer $200 from `account_number` 102 to `account_number` 104.

3. `COMMIT` the transaction.

4. Verify the updated balances are permanent even if you disconnect and reconnect your SQL client.

### Exercise 3: Implementing Savepoints for Partial Rollbacks

A more complex banking operation might involve multiple steps, where you want to be able to undo only a portion of the transaction without rolling back everything.

#### Task:

1. Start a transaction.

2. Insert a new loan application for a customer (e.g., `customer_id` 1, `application_id` 2001, `loan_amount` 10000).

3. Create a `SAVEPOINT` named `after_application_insert`. 

4. Attempt to update the status of `account_number` 101 to 'FROZEN'.

5. Realize the account freeze was an error and `ROLLBACK TO SAVEPOINT after_application_insert`. 

6. Verify that the loan application insertion is still present, but the account status update has been undone.

7. `COMMIT` the remaining changes (the loan application).

### Exercise 4: Managing Concurrency with SELECT FOR UPDATE

Two tellers simultaneously try to process withdrawals from the same account. Without proper concurrency control, one withdrawal might overwrite the other's changes (lost update).

#### Task:

1. Open two separate SQL client sessions (Session A and Session B) connected to the same database.

2. In Session A:

    - Start a transaction.
    - Query `account_number` 103 for update, but do NOT commit or rollback yet.
    - Simulate some processing time (e.g., wait a few seconds).
    - Attempt to update the balance of account 103.

3. In Session B (while Session A is still active and uncommitted):

    - Start a transaction.
    - Attempt to query `account_number` 103 for update. Observe what happens.
    - Attempt to update the balance of account 103. Observe what happens.

4. Back in Session A:

    - `COMMIT` the transaction.

5. Back in Session B:

    - Observe what happens to your waiting queries/updates.
    - Verify the final balance of account 103.