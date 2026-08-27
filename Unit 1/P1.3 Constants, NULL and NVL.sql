SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Personalization Seed (Change roll number here)
    v_roll_no           NUMBER := 1;

    -- Part A: GST Calculation Variables & Constants
    c_gst_rate          CONSTANT NUMBER := 18;      -- Total GST 18%
    v_base_price        NUMBER;
    v_cgst              NUMBER;
    v_sgst              NUMBER;
    v_total_price       NUMBER;

    -- Part B: NULL & NVL Demonstration Variables
    v_city              VARCHAR2(50) := NULL;
    v_nvl_result        VARCHAR2(50);
    v_nvl2_result       VARCHAR2(100);
BEGIN
    -- =========================================================================
    -- PART A: GST Breakdown (CGST 9% + SGST 9%)
    -- =========================================================================
    v_base_price  := (v_roll_no * 500) + 1000;
    v_cgst        := ROUND(v_base_price * (c_gst_rate / 2) / 100, 2);
    v_sgst        := ROUND(v_base_price * (c_gst_rate / 2) / 100, 2);
    v_total_price := v_base_price + v_cgst + v_sgst;

    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('             PART A: GST TAX INVOICE                ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Roll Number          : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('Base Price           : Rs. ' || TO_CHAR(v_base_price, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('CGST (9%)            : Rs. ' || TO_CHAR(v_cgst, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('SGST (9%)            : Rs. ' || TO_CHAR(v_sgst, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total GST (18%)      : Rs. ' || TO_CHAR(v_cgst + v_sgst, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Payable Amount : Rs. ' || TO_CHAR(v_total_price, 'FM99,99,999.00'));
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART B: NULL, NVL, and NVL2 Demonstration
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('        PART B: NULL HANDLING (NVL vs NVL2)         ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Initial v_city value : NULL');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Test 1: When v_city is NULL
    v_nvl_result  := NVL(v_city, 'Ahmedabad');
    v_nvl2_result := NVL2(v_city, 'City Known: ' || v_city, 'City Unknown');
    
    DBMS_OUTPUT.PUT_LINE('[Case 1: v_city IS NULL]');
    DBMS_OUTPUT.PUT_LINE('NVL(v_city, ''Ahmedabad'')               : ' || v_nvl_result);
    DBMS_OUTPUT.PUT_LINE('NVL2(v_city, ''Known...'', ''Unknown'')    : ' || v_nvl2_result);
    DBMS_OUTPUT.PUT_LINE('');

    -- Test 2: When v_city is NOT NULL
    v_city        := 'Surat';
    v_nvl_result  := NVL(v_city, 'Ahmedabad');
    v_nvl2_result := NVL2(v_city, 'City Known: ' || v_city, 'City Unknown');

    DBMS_OUTPUT.PUT_LINE('[Case 2: v_city = ''Surat'']');
    DBMS_OUTPUT.PUT_LINE('NVL(v_city, ''Ahmedabad'')               : ' || v_nvl_result);
    DBMS_OUTPUT.PUT_LINE('NVL2(v_city, ''Known...'', ''Unknown'')    : ' || v_nvl2_result);
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/