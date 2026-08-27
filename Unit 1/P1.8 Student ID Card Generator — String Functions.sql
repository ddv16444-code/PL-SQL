SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Inputs (Personalize with your details)
    v_input_name        VARCHAR2(100) := 'Aarav Shah';
    v_roll_no           NUMBER        := 5;
    v_dob               DATE          := TO_DATE('15-03-2004', 'DD-MM-YYYY');

    -- Processed Variables
    v_clean_name        VARCHAR2(100);
    v_upper_name        VARCHAR2(100);
    v_first_name        VARCHAR2(50);
    v_last_name         VARCHAR2(50);
    v_display_name      VARCHAR2(50);
    v_student_id        VARCHAR2(30);
    v_age               NUMBER;
    v_space_pos         NUMBER;
BEGIN
    -- 1. Standardize Whitespace & Convert to UPPER
    v_clean_name := TRIM(v_input_name);
    v_upper_name := UPPER(v_clean_name);

    -- 2. Extract First Name & Last Name
    v_space_pos := INSTR(v_clean_name, ' ');

    IF v_space_pos > 0 THEN
        v_first_name := SUBSTR(v_clean_name, 1, v_space_pos - 1);
        v_last_name  := TRIM(SUBSTR(v_clean_name, v_space_pos + 1));
    ELSE
        v_first_name := v_clean_name;
        v_last_name  := '';
    END IF;

    -- Bonus: If name length > 20, abbreviate last name (e.g., "Alexander Harshvardhan" -> "Alexander H.")
    IF LENGTH(v_clean_name) > 20 AND LENGTH(v_last_name) > 0 THEN
        v_display_name := v_first_name || ' ' || SUBSTR(v_last_name, 1, 1) || '.';
    ELSE
        v_display_name := v_clean_name;
    END IF;

    -- 3. Generate Student ID: "LJICA" || YYYY || 3-digit Roll No
    v_student_id := 'LJICA' || TO_CHAR(v_dob, 'YYYY') || LPAD(v_roll_no, 3, '0');

    -- 4. Calculate Exact Age from DOB
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_dob) / 12);

    -- 5. Print Formatted ID Card Layout using RPAD and LPAD
    DBMS_OUTPUT.PUT_LINE('+' || LPAD('-', 48, '-') || '+');
    DBMS_OUTPUT.PUT_LINE('|' || RPAD('   LJ INSTITUTE OF COMPUTER APPLICATIONS', 48) || '|');
    DBMS_OUTPUT.PUT_LINE('|' || RPAD('             STUDENT IDENTITY CARD', 48) || '|');
    DBMS_OUTPUT.PUT_LINE('+' || LPAD('-', 48, '-') || '+');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Student ID', 15) || ': ' || RPAD(v_student_id, 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Full Name', 15) || ': ' || RPAD(v_upper_name, 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Display Name', 15) || ': ' || RPAD(v_display_name, 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('First Name', 15) || ': ' || RPAD(v_first_name, 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Roll Number', 15) || ': ' || RPAD(TO_CHAR(v_roll_no), 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Date of Birth', 15) || ': ' || RPAD(TO_CHAR(v_dob, 'DD-Mon-YYYY'), 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Age', 15) || ': ' || RPAD(v_age || ' Years', 30) || '|');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('Status', 15) || ': ' || RPAD('VALID / ACTIVE', 30) || '|');
    DBMS_OUTPUT.PUT_LINE('+' || LPAD('-', 48, '-') || '+');
    DBMS_OUTPUT.PUT_LINE('|' || LPAD('[LJICA OFFICIAL STUDENT CREDENTIAL]', 42) || '      |');
    DBMS_OUTPUT.PUT_LINE('+' || LPAD('-', 48, '-') || '+');
END;
/