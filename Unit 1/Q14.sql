SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
c_gst CONSTANT NUMBER := 18;
v_index NUMBER := MOD(v_roll, 4) + 1;
v_plan NUMBER;
v_gst NUMBER;
v_total NUMBER;
v_plan_name VARCHAR2(30);
BEGIN
v_plan := CASE v_index
WHEN 1 THEN 199
WHEN 2 THEN 299
WHEN 3 THEN 399
WHEN 4 THEN 599
END;
v_plan_name := 'Jio/Airtel Plan';
v_gst := v_plan * c_gst / 100;
v_total := v_plan + v_gst;
DBMS_OUTPUT.PUT_LINE('--------------------------------');
DBMS_OUTPUT.PUT_LINE(' MOBILE RECHARGE RECEIPT');
DBMS_OUTPUT.PUT_LINE('--------------------------------');
DBMS_OUTPUT.PUT_LINE(RPAD('Plan:', 15) || v_plan_name);
DBMS_OUTPUT.PUT_LINE(RPAD('Base Price:', 15) ||
TO_CHAR(v_plan, '99,999.99'));
DBMS_OUTPUT.PUT_LINE(RPAD('GST @18%:', 15) ||
TO_CHAR(v_gst, '99,999.99'));
DBMS_OUTPUT.PUT_LINE(RPAD('Total:', 15) ||
TO_CHAR(v_total, '99,999.99'));
DBMS_OUTPUT.PUT_LINE('Validity: ' ||
TO_CHAR(SYSDATE + 28, 'DD-MON-YYYY'));
END;
/
