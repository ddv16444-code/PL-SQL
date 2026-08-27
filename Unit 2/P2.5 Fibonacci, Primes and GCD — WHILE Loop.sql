SET DEFINE OFF;
SET SERVEROUTPUT ON;

DECLARE
    -- Inputs
    v_roll_no       NUMBER := 1; -- Change roll number here
    v_n             NUMBER;

    -- Part A & B: Fibonacci & Prime Check
    v_f1            NUMBER := 0;
    v_f2            NUMBER := 1;
    v_next          NUMBER;
    v_nth_fib       NUMBER;
    v_count         NUMBER;
    v_fib_series    VARCHAR2(500) := '';
    v_divisor       NUMBER;
    v_is_prime      BOOLEAN;

    -- Part C: Primes 1 to 100
    v_num           NUMBER;
    v_d             NUMBER;
    v_prime_flag    BOOLEAN;
    v_prime_count   NUMBER := 0;
    v_prime_list    VARCHAR2(1000) := '';

    -- Part D: GCD (Euclidean Algorithm)
    v_num1          NUMBER := 48;
    v_num2          NUMBER := 18;
    v_a             NUMBER;
    v_b             NUMBER;
    v_r             NUMBER;

    -- Part E: Perfect Number Check
    v_perf_target   NUMBER := 28; -- Number to test (e.g., 6, 28, 496)
    v_div_sum       NUMBER := 0;
    v_k             NUMBER;
BEGIN
    -- Dynamic N calculation
    v_n := 5 + MOD(v_roll_no, 8);

    -- =========================================================================
    -- PART A: First N Fibonacci Numbers
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART A: First ' || v_n || ' Fibonacci Numbers (Roll #' || v_roll_no || ')');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    v_count := 1;
    WHILE v_count <= v_n LOOP
        IF v_count = 1 THEN
            v_fib_series := '0';
            v_nth_fib := 0;
        ELSIF v_count = 2 THEN
            v_fib_series := v_fib_series || ', 1';
            v_nth_fib := 1;
        ELSE
            v_next := v_f1 + v_f2;
            v_fib_series := v_fib_series || ', ' || TO_CHAR(v_next);
            v_nth_fib := v_next;
            v_f1 := v_f2;
            v_f2 := v_next;
        END IF;
        v_count := v_count + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Series: ' || v_fib_series);
    DBMS_OUTPUT.PUT_LINE('The ' || v_n || 'th Fibonacci number is: ' || v_nth_fib);
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART B: Prime Check on Nth Fibonacci Number
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART B: Prime Check on Nth Fibonacci (' || v_nth_fib || ')');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    IF v_nth_fib <= 1 THEN
        v_is_prime := FALSE;
    ELSE
        v_is_prime := TRUE;
        v_divisor := 2;
        WHILE (v_divisor * v_divisor) <= v_nth_fib LOOP
            IF MOD(v_nth_fib, v_divisor) = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
            v_divisor := v_divisor + 1;
        END LOOP;
    END IF;

    IF v_is_prime THEN
        DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is a PRIME number.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is NOT a prime number.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART C: All Primes Between 1 and 100
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART C: Prime Numbers between 1 and 100');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    v_num := 2;
    WHILE v_num <= 100 LOOP
        v_prime_flag := TRUE;
        v_d := 2;
        WHILE (v_d * v_d) <= v_num LOOP
            IF MOD(v_num, v_d) = 0 THEN
                v_prime_flag := FALSE;
                EXIT;
            END IF;
            v_d := v_d + 1;
        END LOOP;

        IF v_prime_flag THEN
            IF v_prime_count = 0 THEN
                v_prime_list := TO_CHAR(v_num);
            ELSE
                v_prime_list := v_prime_list || ', ' || TO_CHAR(v_num);
            END IF;
            v_prime_count := v_prime_count + 1;
        END IF;

        v_num := v_num + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Primes: ' || v_prime_list);
    DBMS_OUTPUT.PUT_LINE('Total Prime Count: ' || v_prime_count);
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART D: GCD of Two Numbers using Euclidean Algorithm
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART D: GCD of ' || v_num1 || ' and ' || v_num2 || ' (Euclidean Algorithm)');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    v_a := v_num1;
    v_b := v_num2;

    WHILE v_b != 0 LOOP
        v_r := MOD(v_a, v_b);
        v_a := v_b;
        v_b := v_r;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('GCD(' || v_num1 || ', ' || v_num2 || ') = ' || v_a);
    DBMS_OUTPUT.PUT_LINE('');

    -- =========================================================================
    -- PART E: Perfect Number Check
    -- =========================================================================
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('PART E: Perfect Number Check for ' || v_perf_target);
    DBMS_OUTPUT.PUT_LINE('====================================================');

    v_k := 1;
    WHILE v_k < v_perf_target LOOP
        IF MOD(v_perf_target, v_k) = 0 THEN
            v_div_sum := v_div_sum + v_k;
        END IF;
        v_k := v_k + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum of proper divisors: ' || v_div_sum);
    IF v_div_sum = v_perf_target AND v_perf_target > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_perf_target || ' is a PERFECT number.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_perf_target || ' is NOT a perfect number.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/