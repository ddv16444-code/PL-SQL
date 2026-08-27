-- 1. Create table if not exists
CREATE TABLE employees (
    employee_id   NUMBER PRIMARY KEY,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50),
    job_id        VARCHAR2(20),
    department_id NUMBER,
    salary        NUMBER,
    hire_date     DATE
);

-- 2. Insert sample employees (IDs 101 to 110)
INSERT INTO employees VALUES (101, 'Neena', 'Kochhar', 'AD_VP', 90, 17000, TO_DATE('21-09-2005', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (102, 'Lex', 'De Haan', 'AD_VP', 90, 17000, TO_DATE('13-01-2001', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (103, 'Alexander', 'Hunold', 'IT_PROG', 60, 9000, TO_DATE('03-01-2006', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (104, 'Bruce', 'Ernst', 'IT_PROG', 60, 6000, TO_DATE('21-05-2007', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (105, 'David', 'Austin', 'IT_PROG', 60, 4800, TO_DATE('25-06-2005', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (106, 'Valli', 'Pataballa', 'IT_PROG', 60, 4800, TO_DATE('05-02-2006', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (107, 'Diana', 'Lorentz', 'IT_PROG', 60, 4200, TO_DATE('07-02-2007', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (108, 'Nancy', 'Greenberg', 'FI_MGR', 100, 12008, TO_DATE('17-08-2002', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (109, 'Daniel', 'Faviet', 'FI_ACCOUNT', 100, 9000, TO_DATE('16-08-2002', 'DD-MM-YYYY'));
INSERT INTO employees VALUES (110, 'John', 'Chen', 'FI_ACCOUNT', 100, 8200, TO_DATE('28-09-2005', 'DD-MM-YYYY'));

COMMIT;

-- 3. PL/SQL Block with %ROWTYPE
SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    v_roll_no       NUMBER := 1;
    v_emp_id        NUMBER;
    v_emp           employees%ROWTYPE;
    v_experience    NUMBER;
    v_seniority_tag VARCHAR2(30) := '';
BEGIN
    v_emp_id := 100 + MOD(v_roll_no, 9) + 1;

    SELECT *
    INTO v_emp
    FROM employees
    WHERE employee_id = v_emp_id;

    v_experience := TRUNC(MONTHS_BETWEEN(SYSDATE, v_emp.hire_date) / 12);

    IF v_experience > 10 THEN
        v_seniority_tag := 'Senior Employee';
    ELSE
        v_seniority_tag := 'Associate Employee';
    END IF;

    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('               EMPLOYEE PROFILE CARD                ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Employee ID       : ' || v_emp.employee_id);
    DBMS_OUTPUT.PUT_LINE('Full Name         : ' || v_emp.first_name || ' ' || v_emp.last_name);
    DBMS_OUTPUT.PUT_LINE('Job Role / ID     : ' || v_emp.job_id);
    DBMS_OUTPUT.PUT_LINE('Department ID     : ' || NVL(TO_CHAR(v_emp.department_id), 'N/A'));
    DBMS_OUTPUT.PUT_LINE('Monthly Salary    : Rs.' || TO_CHAR(v_emp.salary, 'FM99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Date of Joining   : ' || TO_CHAR(v_emp.hire_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Total Experience  : ' || v_experience || ' Years');
    DBMS_OUTPUT.PUT_LINE('Classification    : ' || v_seniority_tag);
    DBMS_OUTPUT.PUT_LINE('====================================================');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No record found for Employee ID ' || v_emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/