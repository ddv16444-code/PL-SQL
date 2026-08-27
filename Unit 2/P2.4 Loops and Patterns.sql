SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    v_roll_no       NUMBER := 1; -- Modify roll number here
    v_table_num     NUMBER;
    v_height        NUMBER;
    v_row_str       VARCHAR2(500);
BEGIN
    -- Dynamic values based on roll number
    v_table_num := MOD(v_roll_no, 9) + 2;
    v_height    := 5 + MOD(v_roll_no, 5);

    -- =========================================================================
    -- PART A: Multiplication Table of (roll_no MOD 9 + 2) from 1 to 20
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART A: Multiplication Table of ' || v_table_num || ' (1 to 20)');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    FOR i IN 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(
            LPAD(v_table_num, 2) || ' x ' || LPAD(i, 2) || ' = ' || LPAD(v_table_num * i, 4)
        );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART B: Multiplication Tables of 2, 3, 4, 5 side-by-side using Nested FOR
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART B: Multiplication Tables of 2, 3, 4, 5');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    FOR row_idx IN 1..10 LOOP
        v_row_str := '';
        FOR t IN 2..5 LOOP
            v_row_str := v_row_str || LPAD(t || 'x' || row_idx || '=' || (t * row_idx), 12);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_row_str);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART C: Right-angled Star Triangle (Height = 5 + roll_no MOD 5)
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART C: Star Triangle (Height = ' || v_height || ')');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    FOR i IN 1..v_height LOOP
        v_row_str := '';
        FOR j IN 1..i LOOP
            v_row_str := v_row_str || '* ';
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_row_str);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART D: Number Pyramid for 6 Rows ("1", "12", "123", ...)
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART D: Number Pyramid (6 Rows)');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    FOR i IN 1..6 LOOP
        v_row_str := '';
        FOR j IN 1..i LOOP
            v_row_str := v_row_str || TO_CHAR(j);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_row_str);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART E: Reverse Star Triangle using REVERSE keyword (Tallest row first)
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART E: Reverse Star Triangle using REVERSE keyword');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    FOR i IN REVERSE 1..v_height LOOP
        v_row_str := '';
        FOR j IN 1..i LOOP
            v_row_str := v_row_str || '* ';
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_row_str);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/