SET SERVEROUTPUT ON;
DECLARE
-- Bug 1 fixed: assignment uses := instead of =
-- Bug 2 fixed: VARCHAR2(5) was too small for the full name.
v_name VARCHAR2(50) := 'Jatin Thakor';
-- Bug 3 fixed: CONSTANT must be initialized at declaration.
c_bonus_rate CONSTANT NUMBER := 0.1;
v_sal NUMBER := 51 * 1000 + 20000;
v_bonus NUMBER;
v_fname VARCHAR2(50);
BEGIN
v_bonus := v_sal * c_bonus_rate;
-- Bug 5 fixed: SELECT in PL/SQL requires INTO.
SELECT first_name
INTO v_fname
FROM employees
WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
DBMS_OUTPUT.PUT_LINE('Employee First Name: ' || v_fname);
DBMS_OUTPUT.PUT_LINE('Salary: ' || v_sal);
DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus);
END;
/
