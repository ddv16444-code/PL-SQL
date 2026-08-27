SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_id NUMBER := ((v_roll + 2) MOD 11 + 1) * 10;
v_dname departments.department_name%TYPE;
v_loc departments.location_id%TYPE;
BEGIN
BEGIN
SELECT department_name, location_id
INTO v_dname, v_loc
FROM departments
WHERE department_id = v_id;
DBMS_OUTPUT.PUT_LINE('Dept ' || v_id || ': ' ||
v_dname || ' at location ' || v_loc);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No department found for ID ' || v_id);
END;
-- %TYPE automatically follows the datatype/size of the referenced column.
-- Therefore changing department_name from VARCHAR2(30) to VARCHAR2(60)
-- does not require changing this declaration.
END;
/