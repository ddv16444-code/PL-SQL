SET DEFINE OFF;
SET SERVEROUTPUT ON;

<<outer_block>>
DECLARE
    -- Level 1: Outer Scope
    v_city  VARCHAR2(30) := 'Gujarat'; -- Outer variable (can be personalized)
    v_num   NUMBER       := 100;
BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('          PL/SQL VARIABLE SCOPE EXPLORER            ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('[OUTER BLOCK START]');
    DBMS_OUTPUT.PUT_LINE('Outer v_city : ' || v_city);
    DBMS_OUTPUT.PUT_LINE('Outer v_num  : ' || v_num);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    <<middle_block>>
    DECLARE
        -- Level 2: Middle Scope (Shadows outer variables)
        v_city  VARCHAR2(30) := 'Ahmedabad';
        v_num   NUMBER       := 200;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('  [MIDDLE BLOCK START]');
        DBMS_OUTPUT.PUT_LINE('  Local v_city              : ' || v_city);
        DBMS_OUTPUT.PUT_LINE('  Local v_num               : ' || v_num);
        -- Qualified access using block label
        DBMS_OUTPUT.PUT_LINE('  Outer v_city (via label)  : ' || outer_block.v_city);
        DBMS_OUTPUT.PUT_LINE('  Outer v_num (via label)   : ' || outer_block.v_num);
        DBMS_OUTPUT.PUT_LINE('  --------------------------------------------------');

        <<inner_block>>
        DECLARE
            -- Level 3: Inner Scope (Shadows v_num, inherits v_city from middle)
            v_num   NUMBER := 300;
        BEGIN
            DBMS_OUTPUT.PUT_LINE('    [INNER BLOCK START]');
            DBMS_OUTPUT.PUT_LINE('    Local v_num               : ' || v_num);
            DBMS_OUTPUT.PUT_LINE('    Middle v_num (via label)  : ' || middle_block.v_num);
            DBMS_OUTPUT.PUT_LINE('    Outer v_num (via label)   : ' || outer_block.v_num);
            DBMS_OUTPUT.PUT_LINE('    Visible v_city (Middle)   : ' || v_city);
            DBMS_OUTPUT.PUT_LINE('    Outer v_city (via label)  : ' || outer_block.v_city);
            DBMS_OUTPUT.PUT_LINE('    [INNER BLOCK END]');
        END inner_block;

        DBMS_OUTPUT.PUT_LINE('  --------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('  [MIDDLE BLOCK END]');
    END middle_block;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('[OUTER BLOCK RESUMES]');
    DBMS_OUTPUT.PUT_LINE('Proving outer state after inner blocks exit:');
    DBMS_OUTPUT.PUT_LINE('Current v_city : ' || v_city || ' (Retained original value)');
    DBMS_OUTPUT.PUT_LINE('Current v_num  : ' || v_num  || ' (Retained original value)');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END outer_block;
/