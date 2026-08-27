SET SERVEROUTPUT ON;

DECLARE
    -- Personal details (modify as needed)
    v_name          VARCHAR2(50) := 'Aarav Shah';
    v_roll_no       NUMBER := 1;
    
    -- Message & Calculated Lucky Number
    v_message       VARCHAR2(100) := 'Welcome to PL/SQL!';
    v_lucky_number  NUMBER;
BEGIN
    -- Calculate lucky number: roll_no MOD 7 + 1
    v_lucky_number := MOD(v_roll_no, 7) + 1;

    -- Print block outputs
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Student Name : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Roll Number  : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Greeting     : ' || v_message);
    DBMS_OUTPUT.PUT_LINE('Lucky Number : ' || v_lucky_number);
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/