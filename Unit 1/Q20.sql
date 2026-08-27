SET SERVEROUTPUT ON;
SET SERVEROUTPUT ON;
DECLARE
v_name VARCHAR2(50) := 'Jatin';
v_roll NUMBER := 51;
v_dob DATE := DATE '2004-01-01';
v_pnr VARCHAR2(30);
v_jdate DATE;
v_fare NUMBER;
v_age NUMBER;
v_final_fare NUMBER;
BEGIN
v_pnr := 'GJ' || TO_CHAR(SYSDATE, 'YYMM') ||
LPAD(v_roll, 4, '0');
v_jdate := SYSDATE + (MOD(v_roll, 30) + 1);
v_fare := v_roll * 50 + 200;
v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_dob) / 12);
v_final_fare := CASE
WHEN v_age >= 60 THEN v_fare * 0.60
ELSE v_fare
END;
DBMS_OUTPUT.PUT_LINE('================================');
DBMS_OUTPUT.PUT_LINE(' IRCTC TRAIN TICKET');
DBMS_OUTPUT.PUT_LINE('================================');
DBMS_OUTPUT.PUT_LINE(RPAD('Passenger:', 15) || v_name);
DBMS_OUTPUT.PUT_LINE(RPAD('PNR:', 15) || v_pnr);
DBMS_OUTPUT.PUT_LINE(RPAD('Journey:', 15) ||
TO_CHAR(v_jdate, 'Day, DD-MON-YYYY'));
DBMS_OUTPUT.PUT_LINE(RPAD('Age:', 15) || v_age);
DBMS_OUTPUT.PUT_LINE(RPAD('Base Fare:', 15) || 'Rs.' || v_fare);
IF v_age >= 60 THEN
DBMS_OUTPUT.PUT_LINE(RPAD('Concession:', 15) || '40%');
ELSE
DBMS_OUTPUT.PUT_LINE(RPAD('Concession:', 15) || 'None');
END IF;
DBMS_OUTPUT.PUT_LINE(RPAD('Final Fare:', 15) ||
'Rs.' || ROUND(v_final_fare, 2));
END;
/
