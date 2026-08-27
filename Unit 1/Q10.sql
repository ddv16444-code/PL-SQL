SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_celsius NUMBER := MOD(v_roll, 20) + 25;
v_fahrenheit NUMBER;
v_kelvin NUMBER;
v_f NUMBER := 98.6;
v_c2 NUMBER;
BEGIN
v_fahrenheit := ROUND(v_celsius * 9 / 5 + 32, 1);
v_kelvin := v_celsius + 273.15;
v_c2 := (v_f - 32) * 5 / 9;
DBMS_OUTPUT.PUT_LINE('Celsius: ' || v_celsius);
DBMS_OUTPUT.PUT_LINE('Fahrenheit: ' || v_fahrenheit);
DBMS_OUTPUT.PUT_LINE('Kelvin: ' || v_kelvin);
DBMS_OUTPUT.PUT_LINE('98.6 F in Celsius: ' || ROUND(v_c2, 2));
-- C*9/5+32 and C*(9/5)+32 give the same result in Oracle.
-- Multiplication and division have the same precedence and are evaluated left-to-right.
END;
/