SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_name VARCHAR2(50) := 'Jatin';
v_units NUMBER := v_roll * 10 + 50;
c_rate CONSTANT NUMBER := 5;
c_fixed CONSTANT NUMBER := 70;
v_energy NUMBER;
v_total NUMBER;
BEGIN
v_energy := v_units * c_rate;
v_total := v_energy + c_fixed;
DBMS_OUTPUT.PUT_LINE('Consumer Name: ' || v_name);
DBMS_OUTPUT.PUT_LINE('Units Consumed: ' || v_units);
DBMS_OUTPUT.PUT_LINE('Energy Charge: Rs.' || v_energy);
DBMS_OUTPUT.PUT_LINE('Fixed Charge: Rs.' || c_fixed);
DBMS_OUTPUT.PUT_LINE('Total: Rs.' || v_total);
END;
/
