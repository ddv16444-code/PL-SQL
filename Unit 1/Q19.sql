SET SERVEROUTPUT ON;
<<bank>>
DECLARE
v_bank VARCHAR2(30) := 'LJ Bank';
v_total_deposit NUMBER := 0;
v_roll NUMBER := 51;
v_dep NUMBER := v_roll * 1000;
BEGIN
<<branch>>
DECLARE
v_branch VARCHAR2(30) := 'Ahmedabad';
BEGIN
bank.v_total_deposit := bank.v_total_deposit + v_dep;
<<counter>>
DECLARE
v_token NUMBER := 1;
BEGIN
DBMS_OUTPUT.PUT_LINE(v_bank || ' | ' ||
v_branch || ' | Token ' || v_token);
END;
-- Uncommenting the next line causes PLS-00201 because v_token
-- is declared inside the inner block and is out of scope here.
-- DBMS_OUTPUT.PUT_LINE(v_token);
END;
DBMS_OUTPUT.PUT_LINE('Bank Total Deposit: Rs.' || v_total_deposit);
END;
/
