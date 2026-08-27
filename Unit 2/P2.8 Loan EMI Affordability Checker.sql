SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Inputs (Modify customer and loan details here)
    v_monthly_salary        NUMBER := 100000;      -- Monthly Salary in Rs.
    v_existing_emi          NUMBER := 15000;       -- Current active EMIs
    v_loan_amount_req       NUMBER := 5000000;     -- Requested Loan Principal (P)
    v_annual_rate           NUMBER := 8.5;         -- Annual Interest Rate (%)
    v_tenure_months         NUMBER := 240;         -- Tenure in Months (n)

    -- Financial Formula & Rule Variables
    v_r                     NUMBER;                -- Monthly interest rate (r)
    v_factor                NUMBER;                -- (1 + r)^n
    v_calculated_emi        NUMBER;
    v_foir_limit            NUMBER;                -- 40% of salary
    v_available_foir_emi    NUMBER;                -- Max new EMI allowed
    v_max_cap_loan          NUMBER;                -- 60x monthly salary
    v_approved_loan         NUMBER;
    v_final_emi             NUMBER;
    v_decision              VARCHAR2(20);
    v_rejection_reason      VARCHAR2(150) := 'None';
BEGIN
    -- 1. Banking Policy Benchmarks
    v_foir_limit         := 0.40 * v_monthly_salary;
    v_available_foir_emi := v_foir_limit - v_existing_emi;
    v_max_cap_loan       := 60 * v_monthly_salary;

    -- 2. Monthly Rate & Factor Calculation
    v_r      := (v_annual_rate / 12.0) / 100.0;
    v_factor := POWER(1 + v_r, v_tenure_months);

    -- 3. Calculate Requested Loan EMI: P * r * (1+r)^n / ((1+r)^n - 1)
    v_calculated_emi := ROUND((v_loan_amount_req * v_r * v_factor) / (v_factor - 1), 2);

    -- 4. Initial Eligibility Gate Checks
    IF v_monthly_salary < 25000 THEN
        v_decision         := 'REJECTED';
        v_approved_loan    := 0;
        v_final_emi        := 0;
        v_rejection_reason := 'Monthly salary is below the minimum threshold (Rs. 25,000).';

    ELSIF v_available_foir_emi <= 0 THEN
        v_decision         := 'REJECTED';
        v_approved_loan    := 0;
        v_final_emi        := 0;
        v_rejection_reason := 'Existing EMIs already exhaust the 40% FOIR limit.';

    ELSE
        -- Cap request at max loan multiplier policy (60x salary)
        v_approved_loan := LEAST(v_loan_amount_req, v_max_cap_loan);
        v_final_emi     := ROUND((v_approved_loan * v_r * v_factor) / (v_factor - 1), 2);

        -- 5. Downsizing Loop: If EMI > Available FOIR, decrement by Rs. 10,000
        WHILE v_final_emi > v_available_foir_emi AND v_approved_loan > 0 LOOP
            v_approved_loan := v_approved_loan - 10000;
            IF v_approved_loan > 0 THEN
                v_final_emi := ROUND((v_approved_loan * v_r * v_factor) / (v_factor - 1), 2);
            ELSE
                v_approved_loan := 0;
                v_final_emi     := 0;
            END IF;
        END LOOP;

        -- 6. Final Decision using CASE Statement
        v_decision := CASE
            WHEN v_approved_loan = 0 THEN 
                'REJECTED'
            WHEN v_approved_loan = v_loan_amount_req THEN 
                'APPROVED'
            ELSE 
                'CONDITIONAL'
        END;

        IF v_decision = 'REJECTED' THEN
            v_rejection_reason := 'Calculated EMI exceeds available repayment capacity.';
        ELSIF v_decision = 'CONDITIONAL' THEN
            v_rejection_reason := 'Requested loan downscaled to comply with 40% FOIR / 60x limits.';
        END IF;
    END IF;

    -- 7. Loan Portal Evaluation Receipt
    DBMS_OUTPUT.PUT_LINE('============================================================');
    DBMS_OUTPUT.PUT_LINE('          RETAIL LOAN AFFORDABILITY ASSESSMENT              ');
    DBMS_OUTPUT.PUT_LINE('============================================================');
    DBMS_OUTPUT.PUT_LINE('Monthly Net Salary     : Rs. ' || TO_CHAR(v_monthly_salary, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Existing Active EMIs   : Rs. ' || TO_CHAR(v_existing_emi, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total FOIR Limit (40%) : Rs. ' || TO_CHAR(v_foir_limit, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Available New EMI Cap  : Rs. ' || TO_CHAR(GREATEST(v_available_foir_emi, 0), 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Max Cap (60x Salary)   : Rs. ' || TO_CHAR(v_max_cap_loan, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Requested Loan Amount  : Rs. ' || TO_CHAR(v_loan_amount_req, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Requested Tenure / ROI : ' || v_tenure_months || ' Months @ ' || v_annual_rate || '% p.a.');
    DBMS_OUTPUT.PUT_LINE('Calculated Initial EMI : Rs. ' || TO_CHAR(v_calculated_emi, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('FINAL UNDERWRITING DECISION : ' || v_decision);
    DBMS_OUTPUT.PUT_LINE('Approved Loan Principal     : Rs. ' || TO_CHAR(v_approved_loan, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Approved Monthly EMI        : Rs. ' || TO_CHAR(v_final_emi, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total Monthly EMI Burden    : Rs. ' || TO_CHAR(v_existing_emi + v_final_emi, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Remark / Underwriting Note  : ' || v_rejection_reason);
    DBMS_OUTPUT.PUT_LINE('============================================================');
END;
/