SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Order & Context Inputs (Card A Example)
    v_food_total        NUMBER := 350;          -- Food subtotal in Rs.
    v_distance_km       NUMBER := 5;            -- Delivery distance in km
    v_is_raining        BOOLEAN := TRUE;        -- Rain surcharge flag
    v_is_late_night     BOOLEAN := FALSE;       -- Late Night (10pm-6am) flag
    v_is_festival       BOOLEAN := FALSE;       -- Festival Day flag
    v_is_peak_hour      BOOLEAN := FALSE;       -- Peak Hour (12-2pm / 7-9pm) flag
    v_is_first_order    BOOLEAN := FALSE;       -- First Order discount flag

    -- Charge Calculation Variables
    v_base_delivery     NUMBER := 0;
    v_rain_surge        NUMBER := 0;
    v_late_night_surge  NUMBER := 0;
    v_festival_surge    NUMBER := 0;
    v_peak_surge        NUMBER := 0;
    v_first_order_disc  NUMBER := 0;
    v_total_delivery    NUMBER := 0;
    v_grand_total       NUMBER := 0;
    v_discount_note     VARCHAR2(100) := 'None';
BEGIN
    -- 1. Determine Base Delivery Charge using CASE
    v_base_delivery := CASE
        WHEN v_distance_km < 3  THEN 0
        WHEN v_distance_km <= 8 THEN 29
        WHEN v_distance_km <= 15 THEN 49
        ELSE 79
    END;

    -- 2. Calculate Surcharges on Base Delivery using Searched CASE
    IF v_base_delivery > 0 THEN
        v_rain_surge := CASE WHEN v_is_raining THEN ROUND(v_base_delivery * 0.20) ELSE 0 END;
        v_late_night_surge := CASE WHEN v_is_late_night THEN ROUND(v_base_delivery * 0.15) ELSE 0 END;
        v_festival_surge := CASE WHEN v_is_festival THEN ROUND(v_base_delivery * 0.10) ELSE 0 END;
        v_peak_surge := CASE WHEN v_is_peak_hour THEN ROUND(v_base_delivery * 0.10) ELSE 0 END;
    END IF;

    -- Aggregate raw delivery fee before discounts
    v_total_delivery := v_base_delivery + v_rain_surge + v_late_night_surge + v_festival_surge + v_peak_surge;

    -- 3. Evaluate Discounts using IF conditions
    IF v_food_total > 499 THEN
        -- Overrides everything
        v_total_delivery := 0;
        v_discount_note := 'Free Delivery (Order Value > Rs. 499)';
    ELSIF v_is_first_order THEN
        v_first_order_disc := ROUND(v_total_delivery * 0.50);
        v_total_delivery := v_total_delivery - v_first_order_disc;
        v_discount_note := '50% Off on Delivery (First Order)';
    END IF;

    -- 4. Calculate Grand Total
    v_grand_total := v_food_total + v_total_delivery;

    -- 5. Print Itemized Receipt
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('               ZOMATO ORDER RECEIPT                 ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Food Subtotal          : Rs. ' || LPAD(v_food_total, 6));
    DBMS_OUTPUT.PUT_LINE('Distance               : ' || v_distance_km || ' km');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Base Delivery Fee      : Rs. ' || LPAD(v_base_delivery, 6));
    DBMS_OUTPUT.PUT_LINE('Rain Surcharge (+20%)  : Rs. ' || LPAD(v_rain_surge, 6));
    DBMS_OUTPUT.PUT_LINE('Late Night Surge (+15%): Rs. ' || LPAD(v_late_night_surge, 6));
    DBMS_OUTPUT.PUT_LINE('Festival Surge (+10%)  : Rs. ' || LPAD(v_festival_surge, 6));
    DBMS_OUTPUT.PUT_LINE('Peak Hour Surge (+10%) : Rs. ' || LPAD(v_peak_surge, 6));
    
    IF v_first_order_disc > 0 THEN
        DBMS_OUTPUT.PUT_LINE('First Order Disc (-50%): -Rs. ' || LPAD(v_first_order_disc, 5));
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Final Delivery Charge  : Rs. ' || LPAD(v_total_delivery, 6));
    DBMS_OUTPUT.PUT_LINE('Applied Discount       : ' || v_discount_note);
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('GRAND TOTAL            : Rs. ' || LPAD(v_grand_total, 6));
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/