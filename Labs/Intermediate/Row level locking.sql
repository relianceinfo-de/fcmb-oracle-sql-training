-- Using SELECT FOR UPDATE to implement row level locking

-- Transaction 1: Processing a withdrawal from account 101
SET TRANSACTION NAME 'Withdrawal_T1';

DECLARE
    account_bal NUMBER;
    withdrawal_amt NUMBER := 100;
BEGIN
    -- Lock the specific row for account 101
    SELECT balance INTO account_bal
    FROM bank_accounts
    WHERE account_number = 101
    FOR UPDATE OF balance; -- Locks the row, specifically the balance column

    IF account_bal >= withdrawal_amt THEN
        UPDATE bank_accounts
        SET balance = balance - withdrawal_amt
        WHERE account_number = 101;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Withdrawal successful. New balance: ' || (account_bal - withdrawal_amt));
    ELSE
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Insufficient funds for withdrawal.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- This query selects the balance for account 101 and immediately locks that row (FOR UPDATE). 
-- Any other transaction attempting to modify this row will wait until the current transaction either COMMITs or ROLLBACKs, 
-- preventing lost updates during concurrent withdrawals.
