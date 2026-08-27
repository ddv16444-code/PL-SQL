SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Inputs (Modify gross salary here)
    v_gross_salary          NUMBER := 1000000; -- Example: Rs. 10,00,000 (Seed=20)
    
    -- Constants
    c_std_deduction         CONSTANT NUMBER := 75000;
    
    -- Calculated Variables
    v_taxable_income        NUMBER;
    v_total_tax             NUMBER := 0;
    v_monthly_tds           NUMBER;
    v_monthly_take_home     NUMBER;
BEGIN
    -- 1. Standard Deduction & Taxable Income
    IF v_gross_salary > c_std_deduction THEN
        v_taxable_income := v_gross_salary - c_std_deduction;
    ELSE
        v_taxable_income := 0;
    END IF;

    -- 2. Tax Computation using Searched CASE statement
    -- Cumulative tax brackets:
    -- 0 to 3L: Nil
    -- 3L to 7L (4L @ 5%): Rs. 20,000
    -- 7L to 10L (3L @ 10%): Rs. 30,000 (Total Rs. 50,000)
    -- 10L to 12L (2L @ 15%): Rs. 30,000 (Total Rs. 80,000)
    -- 12L to 15L (3L @ 20%): Rs. 60,000 (Total Rs. 1,40,000)
    -- Above 15L: 30%
    v_total_tax := CASE
        WHEN v_taxable_income <= 300000 THEN
            0
        WHEN v_taxable_income <= 700000 THEN
            (v_taxable_income - 300000) * 0.05
        WHEN v_taxable_income <= 1000000 THEN
            20000 + (v_taxable_income - 700000) * 0.10
        WHEN v_taxable_income <= 1200000 THEN
            50000 + (v_taxable_income - 1000000) * 0.15
        WHEN v_taxable_income <= 1500000 THEN
            80000 + (v_taxable_income - 1200000) * 0.20
        ELSE
            140000 + (v_taxable_income - 1500000) * 0.30
    END;

    -- 3. Monthly Metrics
    v_monthly_tds := ROUND(v_total_tax / 12, 2);
    v_monthly_take_home := ROUND((v_gross_salary - v_total_tax) / 12, 2);

    -- 4. Print Full Tax Breakdown
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('     INDIAN INCOME TAX CALCULATOR (2024-25)     ');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('Gross Salary           : Rs. ' || TO_CHAR(v_gross_salary, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Standard Deduction     : Rs. ' || TO_CHAR(c_std_deduction, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Taxable Income         : Rs. ' || TO_CHAR(v_taxable_income, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Annual Tax       : Rs. ' || TO_CHAR(v_total_tax, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Monthly TDS Deduction  : Rs. ' || TO_CHAR(v_monthly_tds, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Monthly Take-Home Pay  : Rs. ' || TO_CHAR(v_monthly_take_home, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

    -- Tax = 0 condition check
    IF v_total_tax = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Note: No tax this year — save more with PPF/ELSS!');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('================================================');
END;
/