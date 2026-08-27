SET SERVEROUTPUT ON;
DECLARE
v_raw VARCHAR2(100) := ' jatin THAKOR ';
v_clean VARCHAR2(100);
v_first VARCHAR2(50);
v_last VARCHAR2(50);
v_email VARCHAR2(100);
v_before NUMBER;
v_after NUMBER;
BEGIN
v_before := LENGTH(v_raw);
-- REPLACE is applied twice to handle multiple adjacent spaces.
v_clean := TRIM(v_raw);
v_clean := REPLACE(v_clean, ' ', ' ');
v_clean := REPLACE(v_clean, ' ', ' ');
v_clean := INITCAP(v_clean);
v_first := SUBSTR(v_clean, 1, INSTR(v_clean, ' ') - 1);
v_last := SUBSTR(v_clean, INSTR(v_clean, ' ') + 1);
v_email := LOWER(v_first || '.' || v_last || '@ljku.edu.in');
v_after := LENGTH(v_clean);
DBMS_OUTPUT.PUT_LINE('Original: [' || v_raw || ']');
DBMS_OUTPUT.PUT_LINE('Cleaned Name: ' || v_clean);
DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first);
DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last);
DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
DBMS_OUTPUT.PUT_LINE('Length Before: ' || v_before);
DBMS_OUTPUT.PUT_LINE('Length After: ' || v_after);
END;
/
