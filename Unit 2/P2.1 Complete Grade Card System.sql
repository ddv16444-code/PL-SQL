SET DEFINE OFF;

DECLARE
    -- Change these mark values directly here:
    v_roll_no       NUMBER := 1;
    v_sub1          NUMBER := 43;
    v_sub2          NUMBER := 53;
    v_sub3          NUMBER := 63;
    v_sub4          NUMBER := 73;
    v_sub5          NUMBER := 83;

    -- Derived Variables
    v_total         NUMBER;
    v_percentage    NUMBER(5, 2);
    v_grade         VARCHAR2(10);
    v_class_rank    VARCHAR2(20);
    v_result        VARCHAR2(20);
    v_min_score     NUMBER;
    v_failed_subs   VARCHAR2(200) := '';
BEGIN
    -- Total & Percentage Calculation
    v_total := v_sub1 + v_sub2 + v_sub3 + v_sub4 + v_sub5;
    v_percentage := v_total / 5.0;

    -- 1. Grade Determination (IF-THEN-ELSIF)
    IF v_percentage >= 90 THEN
        v_grade := 'A+';
    ELSIF v_percentage >= 80 THEN
        v_grade := 'A';
    ELSIF v_percentage >= 70 THEN
        v_grade := 'B';
    ELSIF v_percentage >= 60 THEN
        v_grade := 'C';
    ELSIF v_percentage >= 50 THEN
        v_grade := 'D';
    ELSE
        v_grade := 'FAIL';
    END IF;

    -- 2. Non-Boolean Condition using LEAST() numeric check
    v_min_score := LEAST(v_sub1, v_sub2, v_sub3, v_sub4, v_sub5);

    -- Nested Evaluation
    IF v_min_score < 35 THEN
        v_result := 'DETAINED';
        v_class_rank := 'N/A';

        -- Check individual failed subjects
        IF v_sub1 < 35 THEN
            v_failed_subs := v_failed_subs || 'Subject 1 ';
        END IF;
        IF v_sub2 < 35 THEN
            v_failed_subs := v_failed_subs || 'Subject 2 ';
        END IF;
        IF v_sub3 < 35 THEN
            v_failed_subs := v_failed_subs || 'Subject 3 ';
        END IF;
        IF v_sub4 < 35 THEN
            v_failed_subs := v_failed_subs || 'Subject 4 ';
        END IF;
        IF v_sub5 < 35 THEN
            v_failed_subs := v_failed_subs || 'Subject 5 ';
        END IF;
    ELSE
        v_result := 'PASSED';

        -- Class Rank
        IF v_percentage >= 75 THEN
            v_class_rank := 'Distinction';
        ELSIF v_percentage >= 60 THEN
            v_class_rank := 'First Class';
        ELSIF v_percentage >= 50 THEN
            v_class_rank := 'Second Class';
        ELSE
            v_class_rank := 'Pass Class';
        END IF;
    END IF;

    -- Report Card Display
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          STUDENT REPORT CARD           ');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Roll No       : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('Subject 1     : ' || v_sub1);
    DBMS_OUTPUT.PUT_LINE('Subject 2     : ' || v_sub2);
    DBMS_OUTPUT.PUT_LINE('Subject 3     : ' || v_sub3);
    DBMS_OUTPUT.PUT_LINE('Subject 4     : ' || v_sub4);
    DBMS_OUTPUT.PUT_LINE('Subject 5     : ' || v_sub5);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Marks   : ' || v_total || ' / 500');
    DBMS_OUTPUT.PUT_LINE('Percentage    : ' || TO_CHAR(v_percentage, 'FM990.00') || '%');
    DBMS_OUTPUT.PUT_LINE('Grade         : ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('Class Rank    : ' || v_class_rank);
    DBMS_OUTPUT.PUT_LINE('Final Result  : ' || v_result);

    IF v_min_score < 35 THEN
        DBMS_OUTPUT.PUT_LINE('Failed In     : ' || TRIM(v_failed_subs));
    END IF;
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/