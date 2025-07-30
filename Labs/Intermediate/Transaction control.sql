-- Example: Processing a Loan Application (with conditional rollback)

-- Start a transaction
SET TRANSACTION NAME 'LoanApplication';

-- Step 1: Insert loan application details
INSERT INTO loan_applications (application_id, customer_id, loan_amount, status)
VALUES (1001, 500, 25000, 'PENDING');

-- Set a savepoint before credit check
SAVEPOINT before_credit_check;

-- Step 2: Perform credit check (simplified: assume it returns 'POOR' for this example)
DECLARE
    credit_score VARCHAR2(10) := 'POOR'; -- In real world, this would come from a complex check
BEGIN
    IF credit_score = 'POOR' THEN
        ROLLBACK TO before_credit_check; -- Rollback to the savepoint
        UPDATE loan_applications SET status = 'REJECTED' WHERE application_id = 1001;
        DBMS_OUTPUT.PUT_LINE('Loan application rejected due to poor credit. Rolled back to savepoint.');
    ELSE
        -- Step 3: If credit is good, update status and commit
        UPDATE loan_applications SET status = 'APPROVED' WHERE application_id = 1001;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Loan application approved. Committed changes.');
    END IF;
END;
/

-- If something goes wrong *after* a commit, you'd need a new transaction
-- For example, if the entire process needs to be undone due to a system error
-- ROLLBACK would undo everything from the last COMMIT or start of session
