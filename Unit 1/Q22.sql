SET SERVEROUTPUT ON;
DECLARE
v_roll NUMBER := 51;
v_qty NUMBER := MOD(v_roll, 5) + 2;
v_price NUMBER := v_roll * 100 + 400;
v_coupon NUMBER := NULL;
v_gross NUMBER;
v_disc NUMBER;
v_taxable NUMBER;
v_total NUMBER;
c_tax CONSTANT NUMBER := 18;
BEGIN
v_gross := v_qty * v_price;
v_disc := v_gross * NVL(v_coupon, 0) / 100;
v_taxable := v_gross - v_disc;
v_total := ROUND(v_taxable * 1.18);
DBMS_OUTPUT.PUT_LINE('============= KIRANA BILL =============');
DBMS_OUTPUT.PUT_LINE('Quantity: ' || v_qty);
DBMS_OUTPUT.PUT_LINE('Price/Item: Rs.' || v_price);
DBMS_OUTPUT.PUT_LINE('Gross: Rs.' || v_gross);
DBMS_OUTPUT.PUT_LINE(NVL2(v_coupon,
'Coupon applied: ' || v_coupon || '%',
'No coupon'));
DBMS_OUTPUT.PUT_LINE('Discount: Rs.' || v_disc);
DBMS_OUTPUT.PUT_LINE('Taxable: Rs.' || v_taxable);
DBMS_OUTPUT.PUT_LINE('CGST @9%: Rs.' || ROUND(v_taxable * 0.09, 2));
DBMS_OUTPUT.PUT_LINE('SGST @9%: Rs.' || ROUND(v_taxable * 0.09, 2));
DBMS_OUTPUT.PUT_LINE('Final Total: Rs.' || v_total);
END;
/
-- Run 2: coupon = 10%
DECLARE
v_roll NUMBER := 51;
v_qty NUMBER := MOD(v_roll, 5) + 2;
v_price NUMBER := v_roll * 100 + 400;
v_coupon NUMBER := 10;
v_gross NUMBER;
v_disc NUMBER;
v_taxable NUMBER;
v_total NUMBER;
BEGIN
v_gross := v_qty * v_price;
v_disc := v_gross * NVL(v_coupon, 0) / 100;
v_taxable := v_gross - v_disc;
v_total := ROUND(v_taxable * 1.18);
DBMS_OUTPUT.PUT_LINE('========== KIRANA BILL (10%) ==========');
DBMS_OUTPUT.PUT_LINE('Quantity: ' || v_qty);
DBMS_OUTPUT.PUT_LINE('Price/Item: Rs.' || v_price);
DBMS_OUTPUT.PUT_LINE('Gross: Rs.' || v_gross);
DBMS_OUTPUT.PUT_LINE(NVL2(v_coupon,
'Coupon applied: ' || v_coupon || '%',
'No coupon'));
DBMS_OUTPUT.PUT_LINE('Discount: Rs.' || v_disc);
DBMS_OUTPUT.PUT_LINE('Taxable: Rs.' || v_taxable);
DBMS_OUTPUT.PUT_LINE('Final Total: Rs.' || v_total);
END;
/
