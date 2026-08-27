SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Inputs
    v_roll_no               NUMBER := 1;
    v_initial_balance       NUMBER;
    v_balance               NUMBER;
    
    -- Transaction tracking
    v_txn_count             NUMBER := 0;
    v_total_withdrawn       NUMBER := 0;
    v_iteration             NUMBER := 0;
    
    -- Simulated inputs per iteration
    v_choice                NUMBER;
    v_amount                NUMBER;
BEGIN
    -- Initial Balance Calculation
    v_initial_balance := (v_roll_no * 500) + 5000;
    v_balance := v_initial_balance;

    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('             ATM TRANSACTION SYSTEM             ');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('Account Holder Roll No : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('Opening Balance        : Rs. ' || TO_CHAR(v_balance, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- ATM Main Processing Loop
    LOOP
        v_iteration := v_iteration + 1;

        -- Hardcoded simulated inputs per iteration (Menu: 1=Check Balance, 2=Withdraw, 3=Exit)
        IF v_iteration = 1 THEN
            v_choice := 2; v_amount := 500;
        ELSIF v_iteration = 2 THEN
            v_choice := 2; v_amount := 1000;
        ELSIF v_iteration = 3 THEN
            v_choice := 2; v_amount := 500;
        ELSIF v_iteration = 4 THEN
            v_choice := 1; v_amount := 0;
        ELSIF v_iteration = 5 THEN
            v_choice := 3; v_amount := 0;
        ELSE
            v_choice := 3; v_amount := 0;
        END IF;

        -- Process Choices
        IF v_choice = 1 THEN
            -- Check Balance
            DBMS_OUTPUT.PUT_LINE('--- Txn #' || v_iteration || ' [Balance Inquiry] ---');
            DBMS_OUTPUT.PUT_LINE('Current Available Balance: Rs. ' || TO_CHAR(v_balance, 'FM99,99,999.00'));
            DBMS_OUTPUT.PUT_LINE('Status: Successful');
            DBMS_OUTPUT.PUT_LINE('------------------------------------');
            v_txn_count := v_txn_count + 1;

        ELSIF v_choice = 2 THEN
            -- Withdraw Option with Validation Rules
            DBMS_OUTPUT.PUT_LINE('--- Txn #' || v_iteration || ' [Withdrawal Attempt: Rs. ' || v_amount || '] ---');
            
            IF v_amount <= 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Withdrawal amount must be greater than 0.');
            ELSIF MOD(v_amount, 100) != 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Amount must be in multiples of 100.');
            ELSIF v_amount > 10000 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Maximum withdrawal limit per transaction is Rs. 10,000.');
            ELSIF v_amount > v_balance THEN
                DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in account.');
            ELSE
                -- Successful Withdrawal
                v_balance := v_balance - v_amount;
                v_total_withdrawn := v_total_withdrawn + v_amount;
                v_txn_count := v_txn_count + 1;

                DBMS_OUTPUT.PUT_LINE('Status          : Successful');
                DBMS_OUTPUT.PUT_LINE('Dispensed       : Rs. ' || TO_CHAR(v_amount, 'FM99,99,999.00'));
                DBMS_OUTPUT.PUT_LINE('Updated Balance : Rs. ' || TO_CHAR(v_balance, 'FM99,99,999.00'));
            END IF;
            DBMS_OUTPUT.PUT_LINE('------------------------------------');

        ELSIF v_choice = 3 THEN
            -- Exit Option
            DBMS_OUTPUT.PUT_LINE('--- Session Terminated: User Selected Exit ---');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Invalid Menu Option Selected.');
        END IF;

        -- Loop Exit Conditions
        EXIT WHEN v_choice = 3 OR v_balance = 0;
    END LOOP;

    -- Final ATM Summary Report
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('                FINAL SUMMARY                   ');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('Total Successful Txns  : ' || v_txn_count);
    DBMS_OUTPUT.PUT_LINE('Total Amount Withdrawn : Rs. ' || TO_CHAR(v_total_withdrawn, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Closing Balance        : Rs. ' || TO_CHAR(v_balance, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('================================================');
END;
/