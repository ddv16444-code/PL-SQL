SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Student & Evaluation Inputs
    v_roll_no           NUMBER := 1;            -- Student Roll No
    v_attendance_pct    NUMBER := 51;           -- Attendance percentage (%)
    v_theory_marks      NUMBER := 31;           -- Out of 70 (Passing: >= 28)
    v_practical_marks   NUMBER := 13;           -- Out of 30 (Passing: >= 12)
    v_assignment_marks  NUMBER := 10;           -- Out of 20 (Max 10 counted)

    -- Evaluated & Derived Metrics
    v_assignment_count  NUMBER;
    v_total_marks       NUMBER;
    v_percentage        NUMBER(5, 2);
    v_grade             VARCHAR2(15);
    v_result_status     VARCHAR2(40);
    v_remark            VARCHAR2(100);
BEGIN
    -- 1. Cap assignment marks to maximum 10
    v_assignment_count := LEAST(v_assignment_marks, 10);

    -- 2. Total and Percentage Calculation (Max possible = 70 + 30 + 10 = 110)
    v_total_marks := v_theory_marks + v_practical_marks + v_assignment_count;
    v_percentage  := ROUND((v_total_marks / 110.0) * 100, 2);

    -- 3. Academic Evaluation using ELSIF Ladder & Multiple Conditions
    IF v_attendance_pct < 40 THEN
        v_result_status := 'DETAINED';
        v_grade         := 'N/A';
        v_remark        := 'Detained due to critically low attendance (< 40%). Not eligible for evaluation.';

    ELSIF v_theory_marks < 28 AND v_practical_marks < 12 THEN
        v_result_status := 'FAIL (Theory & Practical)';
        v_grade         := 'F';
        v_remark        := 'Failed in both Theory (< 28) and Practical (< 12) components.';

    ELSIF v_theory_marks < 28 THEN
        v_result_status := 'FAIL (Theory)';
        v_grade         := 'F';
        v_remark        := 'Failed in Theory component (Scored < 28/70). Must appear for remedial.';

    ELSIF v_practical_marks < 12 THEN
        v_result_status := 'FAIL (Practical)';
        v_grade         := 'F';
        v_remark        := 'Failed in Practical component (Scored < 12/30). Must reappear for viva/lab.';

    ELSE
        v_result_status := 'PASS';

        -- 4. Grade & Performance Remark using Searched CASE
        v_grade := CASE
            WHEN v_percentage >= 85 THEN 'DISTINCTION'
            WHEN v_percentage >= 70 THEN 'A'
            WHEN v_percentage >= 60 THEN 'B'
            WHEN v_percentage >= 50 THEN 'C'
            WHEN v_percentage >= 40 THEN 'D'
            ELSE 'FAIL'
        END;

        v_remark := CASE
            WHEN v_grade = 'DISTINCTION' THEN 'Outstanding academic performance with exemplary subject mastery.'
            WHEN v_grade = 'A'           THEN 'Excellent result with consistent high-level performance.'
            WHEN v_grade = 'B'           THEN 'Good performance. Consistent effort demonstrated throughout.'
            WHEN v_grade = 'C'           THEN 'Average result. Has solid scope for academic enhancement.'
            WHEN v_grade = 'D'           THEN 'Cleared minimum passing thresholds. Needs significant improvement.'
            ELSE                              'Did not meet aggregate percentage benchmarks.'
        END;
    END IF;

    -- 5. Print Formal Marksheet
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('           LJ INSTITUTE OF COMPUTER APPLICATIONS (LJICA)        ');
    DBMS_OUTPUT.PUT_LINE('                          SEMESTER GRADE REPORT                 ');
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('Roll Number          : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('Attendance           : ' || v_attendance_pct || '%');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('EVALUATION COMPONENT        MAX MARKS    MIN MARKS    OBTAINED  ');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Theory Examination             70           28          ' || LPAD(v_theory_marks, 3));
    DBMS_OUTPUT.PUT_LINE('Practical Examination          30           12          ' || LPAD(v_practical_marks, 3));
    DBMS_OUTPUT.PUT_LINE('Assignment Marks (Capped)      10           --          ' || LPAD(v_assignment_count, 3) || ' (Raw: ' || v_assignment_marks || ')');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Grand Total          : ' || v_total_marks || ' / 110');
    DBMS_OUTPUT.PUT_LINE('Overall Percentage   : ' || TO_CHAR(v_percentage, 'FM990.00') || '%');
    DBMS_OUTPUT.PUT_LINE('Grade Awarded        : ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('Result Status        : ' || v_result_status);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Remark               : ' || v_remark);
    DBMS_OUTPUT.PUT_LINE('================================================================');
END;
/