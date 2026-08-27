-- 1. Create table & insert sample records if running in an empty environment
CREATE TABLE employees (
    employee_id   NUMBER PRIMARY KEY,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50),
    salary        NUMBER
);

INSERT INTO employees VALUES (100, 'Steven', 'King', 24000);
INSERT INTO employees VALUES (101, 'Neena', 'Kochhar', 17000);
INSERT INTO employees VALUES (102, 'Lex', 'De Haan', 17000);
INSERT INTO employees VALUES (103, 'Alexander', 'Hunold', 9000);
INSERT INTO employees VALUES (104, 'Bruce', 'Ernst', 6000);
INSERT INTO employees VALUES (105, 'David', 'Austin', 4800);
INSERT INTO employees VALUES (106, 'Valli', 'Pataballa', 4800);
INSERT INTO employees VALUES (107, 'Diana', 'Lorentz', 4200);

COMMIT;

-- 2. PL/SQL Data Fetcher Block
SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Personalization Seed
    v_roll_no       NUMBER := 1;  -- Modify roll number here
    
    -- IDs to test
    v_valid_id      NUMBER;
    v_invalid_id    NUMBER;

    -- Anchored data types using %TYPE
    v_fname         employees.first_name%TYPE;
    v_sal           employees.salary%TYPE;
BEGIN
    -- Derive IDs based on assignment formulas
    v_valid_id   := 100 + MOD(v_roll_no, 7);  -- Existing ID (100 to 106)
    v_invalid_id := v_roll_no;                -- Typically non-existent (e.g., ID 1)

    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('          EMPLOYEE DATA FETCHER (SELECT INTO)       ');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    -- -------------------------------------------------------------------------
    -- TEST 1: Querying a VALID Employee ID
    -- -------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE('[TEST 1: Valid Employee ID = ' || v_valid_id || ']');
    BEGIN
        SELECT first_name, salary
        INTO v_fname, v_sal
        FROM employees
        WHERE employee_id = v_valid_id;

        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_fname || ' earns Rs.' || TO_CHAR(v_sal, 'FM99,999.00') || ' per month.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee not found — check the ID: ' || v_valid_id);
    END;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- -------------------------------------------------------------------------
    -- TEST 2: Querying an INVALID / Non-Existent Employee ID
    -- -------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE('[TEST 2: Invalid Employee ID = ' || v_invalid_id || ']');
    BEGIN
        SELECT first_name, salary
        INTO v_fname, v_sal
        FROM employees
        WHERE employee_id = v_invalid_id;

        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_fname || ' earns Rs.' || TO_CHAR(v_sal, 'FM99,999.00') || ' per month.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee not found — check the ID: ' || v_invalid_id);
    END;

    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/