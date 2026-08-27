SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Personal details & inputs (Modify as needed)
    v_name          VARCHAR2(50) := 'Aarav Shah';
    v_marks         NUMBER(5, 2) := 420.00;
    v_dob           DATE         := TO_DATE('15-03-2004', 'DD-MM-YYYY');

    -- Calculated variables
    v_percentage    NUMBER(5, 2);
    v_passed        BOOLEAN;
    v_result_text   VARCHAR2(10);
BEGIN
    -- 1. Calculate Percentage (out of 500)
    v_percentage := ROUND((v_marks / 500.0) * 100, 2);

    -- 2. Determine Boolean Pass Status (Passing threshold: >= 50%)
    IF v_percentage >= 50.00 THEN
        v_passed := TRUE;
    ELSE
        v_passed := FALSE;
    END IF;

    -- 3. Map BOOLEAN to printable text
    IF v_passed THEN
        v_result_text := 'PASS';
    ELSE
        v_result_text := 'FAIL';
    END IF;

    -- 4. Formatted Output
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('       STUDENT ACADEMIC PROFILE         ');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Student Name   : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Date of Birth  : ' || TO_CHAR(v_dob, 'DD-Mon-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Today''s Date   : ' || TO_CHAR(SYSDATE, 'DD-Mon-YYYY'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Marks    : ' || TO_CHAR(v_marks, 'FM990.00') || ' / 500');
    DBMS_OUTPUT.PUT_LINE('Percentage     : ' || TO_CHAR(v_percentage, 'FM990.00') || '%');
    DBMS_OUTPUT.PUT_LINE('Final Result   : ' || v_result_text);
    DBMS_OUTPUT.PUT_LINE('Aapke rone se muje dard hota hai akhe aapki roti hai dil mera jalta hai
    Muje chuna gaya hai puri kaynat ki or se tumhe ishq karne ke liye 💁‍♀️🙌🦚========================================');
END;
/