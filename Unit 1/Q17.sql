SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_p NUMBER := v_roll * 10000 + 50000;
v_rate NUMBER := 9;
v_years NUMBER := 5;
v_r NUMBER;
v_n NUMBER;
v_emi NUMBER;
v_total NUMBER;
v_interest NUMBER;
v_interest_pct NUMBER;
BEGIN
v_r := v_rate / 12 / 100;
v_n := v_years * 12;
v_emi := ROUND(v_p * v_r * POWER(1 + v_r, v_n) /
(POWER(1 + v_r, v_n) - 1), 2);
v_total := ROUND(v_emi * v_n, 2);
v_interest := v_total - v_p;
v_interest_pct := ROUND(v_interest / v_total * 100, 2);
DBMS_OUTPUT.PUT_LINE('Principal: Rs.' ||
TO_CHAR(v_p, '99,99,999.99'));
DBMS_OUTPUT.PUT_LINE('Monthly EMI: Rs.' ||
TO_CHAR(v_emi, '99,99,999.99'));
DBMS_OUTPUT.PUT_LINE('Total Payment: Rs.' ||
TO_CHAR(v_total, '99,99,999.99'));
DBMS_OUTPUT.PUT_LINE('Total Interest: Rs.' ||
TO_CHAR(v_interest, '99,99,999.99'));
DBMS_OUTPUT.PUT_LINE('Interest Percentage: ' ||
v_interest_pct || '%');
END;
/
