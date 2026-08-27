SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Personalization inputs (Modify roll_no and birth_month as needed)
    v_roll_no           NUMBER := 1;                -- Roll Number
    v_birth_month       NUMBER := 1;                -- Birth Month (1 = Jan, 6 = Jun, etc.)
    
    -- Calculated Inputs based on seeds
    v_principal         NUMBER;                     -- P = roll_no * 1000
    v_rate              NUMBER;                     -- R = birth_month * 0.5 + 4
    v_years             NUMBER := 3;                -- T = 3 years

    -- Output Metrics
    v_si                NUMBER;
    v_ci                NUMBER;
    v_total_si_amount   NUMBER;
    v_total_ci_amount   NUMBER;
    v_diff_amount       NUMBER;
    v_diff_pct          NUMBER;
BEGIN
    -- 1. Derive Principal and Rate
    v_principal := v_roll_no * 1000;
    v_rate      := (v_birth_month * 0.5) + 4;

    -- 2. Calculate Simple Interest & Final Amount
    v_si := (v_principal * v_rate * v_years) / 100;
    v_total_si_amount := v_principal + v_si;

    -- 3. Calculate Compound Interest using POWER & Final Amount
    v_ci := (v_principal * POWER(1 + (v_rate / 100), v_years)) - v_principal;
    v_total_ci_amount := v_principal + v_ci;

    -- 4. Calculate Difference and Percentage Difference
    v_diff_amount := v_ci - v_si;
    
    IF v_si > 0 THEN
        v_diff_pct := (v_diff_amount / v_si) * 100;
    ELSE
        v_diff_pct := 0;
    END IF;

    -- 5. Print Interest Comparison Report
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('             BANK INTEREST CALCULATOR (SI vs CI)    ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Principal Amount (P)    : Rs. ' || TO_CHAR(v_principal, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Annual Interest Rate (R): ' || TO_CHAR(v_rate, 'FM90.0') || '% p.a.');
    DBMS_OUTPUT.PUT_LINE('Tenure / Time Period (T): ' || v_years || ' Years');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Simple Interest (SI)    : Rs. ' || TO_CHAR(ROUND(v_si, 2), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total Amount after SI   : Rs. ' || TO_CHAR(ROUND(v_total_si_amount, 2), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Compound Interest (CI)  : Rs. ' || TO_CHAR(ROUND(v_ci, 2), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total Amount after CI   : Rs. ' || TO_CHAR(ROUND(v_total_ci_amount, 2), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Extra Earned via CI     : Rs. ' || TO_CHAR(ROUND(v_diff_amount, 2), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('CI Growth Advantage     : ' || TO_CHAR(ROUND(v_diff_pct, 2), 'FM990.00') || '%');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Financial recommendation check
    IF v_diff_pct > 10 THEN
        DBMS_OUTPUT.PUT_LINE('Tip: FD is better than savings account for this amount.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/