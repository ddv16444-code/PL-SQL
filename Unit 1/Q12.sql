SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_mark NUMBER := MOD(v_roll, 30) + 60;
v_m1 NUMBER := v_mark;
v_m2 NUMBER := v_mark;
v_m3 NUMBER := v_mark;
v_m4 NUMBER := v_mark;
v_m5 NUMBER := NULL;
v_total NUMBER;
v_pct NUMBER;
v_passed BOOLEAN;
BEGIN
v_total := v_m1 + v_m2 + v_m3 + v_m4 + NVL(v_m5, 0);
v_pct := ROUND(v_total / 500 * 100, 2);
v_passed := (v_pct >= 40);
DBMS_OUTPUT.PUT_LINE('Total: ' || v_total);
DBMS_OUTPUT.PUT_LINE('Percentage: ' || v_pct || '%');
-- BOOLEAN cannot be printed directly using DBMS_OUTPUT.PUT_LINE.
DBMS_OUTPUT.PUT_LINE('Result: ' ||
CASE WHEN v_passed THEN 'PASS' ELSE 'FAIL' END);
END;
/