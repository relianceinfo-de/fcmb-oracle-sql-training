# Module 5: Solutions

### Exercise 1: Demonstrating Atomicity and Rollback - Solution

1. Start a transaction: (Oracle starts a transaction implicitly with the first DML, but it's good practice to be aware of it or explicitly `SET TRANSACTION` for named transactions).

```
SET TRANSACTION NAME 'TransferWithRollback';
```

2. Attempt transfer with simulated error:

```
-- Check initial balances
SELECT account_number, balance FROM Bank_Accounts WHERE account_number IN (101, 102);

-- Debit account 101
UPDATE Bank_Accounts
SET balance = balance - 500
WHERE account_number = 101;

-- Simulate an error by trying to update a non-existent account
UPDATE Bank_Accounts
SET balance = balance + 500
WHERE account_number = 999; -- This account does not exist, will cause no rows updated.
                            -- In a real scenario, this might be a constraint violation, etc.
```

3. Use `ROLLBACK`:

```
ROLLBACK;
```

4. Verify balances:

```
SELECT account_number, balance FROM Bank_Accounts WHERE account_number IN (101, 102);
```

### Exercise 2: Using Commit for Durability and Consistency - Solution

1. Start a new transaction:

```
SET TRANSACTION NAME 'SuccessfulTransfer';
```

2. Transfer funds:

```
-- Check initial balances
SELECT account_number, balance FROM Bank_Accounts WHERE account_number IN (102, 104);

-- Debit account 102
UPDATE Bank_Accounts
SET balance = balance - 200
WHERE account_number = 102;

-- Credit account 104
UPDATE Bank_Accounts
SET balance = balance + 200
WHERE account_number = 104;
```

3. `COMMIT` the transaction:

```
COMMIT;
```

4. Verify updated balances:

```
SELECT account_number, balance FROM Bank_Accounts WHERE account_number IN (102, 104);
```

#### Expected Outcome: 

Account 102's balance should be reduced by $200, and account 104's balance should be increased by $200. These changes are now permanently saved due to `COMMIT`, demonstrating Durability and Consistency (the total sum of money in the bank remains consistent for these accounts).

### Exercise 3: Implementing Savepoints for Partial Rollbacks - Solution

1. Start a transaction:

```
SET TRANSACTION NAME 'LoanApplicationProcess';
```

2. Insert new loan application:

```
INSERT INTO loan_applications (application_id, customer_id, loan_amount, status)
VALUES (2001, 1, 10000, 'PENDING');
```

3. Create a `SAVEPOINT`:

```
SAVEPOINT after_application_insert;
```

4. Attempt to update account status (and simulate error):

```
UPDATE Bank_Accounts
SET account_type = 'FROZEN' -- This is incorrect for account_type, but demonstrates a change
WHERE account_number = 101;
```

5. `ROLLBACK TO SAVEPOINT`:

```
ROLLBACK TO SAVEPOINT after_application_insert;
```

6. Verify changes:

```
-- Check if loan application is still there (it should be)
SELECT * FROM loan_applications WHERE application_id = 2001;

-- Check account status (it should NOT be 'FROZEN')
SELECT account_number, account_type FROM Bank_Accounts WHERE account_number = 101;
```

7. `COMMIT` the remaining changes:

```
COMMIT;
```

#### Expected Outcome: 

The `loan_applications` table should contain the new row for application 2001. The `account_type` for account 101 should not be 'FROZEN'; it should have reverted to its original type. This demonstrates the ability to selectively undo parts of a transaction using `SAVEPOINT`.

### Exercise 4: Managing Concurrency with SELECT FOR UPDATE - Solution

Initial Balance of Account 103: (e.g., from setup: 25000.00)

1. In Session A:

```
SET TRANSACTION NAME 'TellerA_Withdrawal';

-- Lock the row for account 103
SELECT balance
FROM Bank_Accounts
WHERE account_number = 103
FOR UPDATE OF balance; [cite: 24]

-- Simulate processing delay (do NOT commit/rollback yet)
-- Wait for 10-15 seconds before proceeding to the next step in Session A.

-- Update balance
UPDATE Bank_Accounts
SET balance = balance - 500
WHERE account_number = 103;

-- Do NOT commit or rollback yet. Keep Session A open.
```

2. In Session B (while Session A is still running and uncommitted):

```
SET TRANSACTION NAME 'TellerB_Withdrawal';

-- Attempt to lock the same row
SELECT balance
FROM Bank_Accounts
WHERE account_number = 103
FOR UPDATE OF balance;
```

#### Observation (Session B): 

This query will hang. It will not return immediately because Session A has an exclusive lock on that row due to `FOR UPDATE`.

```
-- Attempt to update the same row (this will also hang)
UPDATE Bank_Accounts
SET balance = balance - 100
WHERE account_number = 103;
```

#### Observation (Session B): 

This `UPDATE` statement will also hang, waiting for Session A's transaction to release the lock.

3. Back in Session A:

```
COMMIT;
```

4. Back in Session B:

#### Observation (Session B): 

As soon as Session A `COMMIT`s, the `SELECT FOR UPDATE` query in Session B will immediately return (or the `UPDATE` statement will proceed). Session B can now acquire the lock.

The `UPDATE` in Session B will then execute.

Verify final balance of account 103:

```
SELECT account_number, balance FROM Bank_Accounts WHERE account_number = 103;
```

#### Expected Outcome:

- Initial balance: 25000.00
- After Session A commits (-500): 24500.00
- After Session B commits (-100): 24400.00

The final balance of account 103 should be 24400.00. This demonstrates how `SELECT FOR UPDATE` ensures Isolation and prevents lost updates. Session B was forced to wait, ensuring that its update was applied after Session A's, rather than overwriting it. This is an example of pessimistic locking.