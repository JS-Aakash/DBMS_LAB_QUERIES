SET SERVEROUTPUT ON;

-- =========================================
-- 1) SWAP TWO VARIABLES
-- =========================================
DECLARE
    a NUMBER := &Enter_first_number;
    b NUMBER := &Enter_second_number;
    c NUMBER;
BEGIN
    c := a;
    a := b;
    b := c;

    DBMS_OUTPUT.PUT_LINE('a = ' || a);
    DBMS_OUTPUT.PUT_LINE('b = ' || b);
END;
/

-- =========================================
-- 2) LARGEST OF THREE NUMBERS
-- =========================================
DECLARE
    x NUMBER := &Enter_A;
    y NUMBER := &Enter_B;
    z NUMBER := &Enter_C;
BEGIN
    IF x > y AND x > z THEN
        DBMS_OUTPUT.PUT_LINE('Largest = ' || x);
    ELSIF y > z THEN
        DBMS_OUTPUT.PUT_LINE('Largest = ' || y);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Largest = ' || z);
    END IF;
END;
/

-- =========================================
-- 3) FACTORIAL USING FOR LOOP
-- =========================================
DECLARE
    n NUMBER := &ENTER_Number;
    fact NUMBER := 1;
BEGIN
    FOR i IN 1..n LOOP
        fact := fact * i;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Factorial = ' || fact);
END;
/

-- =========================================
-- 4) SUM OF EVEN AND ODD NUMBERS
-- =========================================
DECLARE
    n NUMBER := &Enter_N;
    even_sum NUMBER := 0;
    odd_sum NUMBER := 0;
BEGIN
    FOR i IN 1..n LOOP
        IF MOD(i,2) = 0 THEN
            even_sum := even_sum + i;
        ELSE
            odd_sum := odd_sum + i;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Even Sum = ' || even_sum);
    DBMS_OUTPUT.PUT_LINE('Odd Sum = ' || odd_sum);
END;
/

-- =========================================
-- 5) ARMSTRONG NUMBER
-- =========================================
DECLARE
    n NUMBER := &Enter_Number;
    temp NUMBER;
    digit NUMBER;
    sum_val NUMBER := 0;
BEGIN
    temp := n;

    WHILE temp > 0 LOOP
        digit := MOD(temp,10);
        sum_val := sum_val + digit*digit*digit;
        temp := TRUNC(temp/10);
    END LOOP;

    IF sum_val = n THEN
        DBMS_OUTPUT.PUT_LINE('ARMSTRONG Number');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Not an Armstrong Number');
    END IF;
END;
/

-- =========================================
-- 6) CONTACTS TABLE + OPERATIONS
-- =========================================

-- DROP TABLE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE contacts';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- CREATE TABLE (EXACT SAME NAMES)
CREATE TABLE contacts (
    name VARCHAR2(100) NOT NULL,
    mobileno VARCHAR2(20) UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE,
    dob DATE
);

-- =========================================
-- 6.1 INSERT
-- =========================================
DECLARE
    name VARCHAR2(100) := '&Enter_name';
    mobile VARCHAR2(20) := '&Enter_mobile';
    email VARCHAR2(100) := '&Enter_email';
    dob DATE := TO_DATE('&Enter_DOB','DD-MM-YYYY');
BEGIN
    INSERT INTO contacts VALUES (name, mobile, email, dob);

    DBMS_OUTPUT.PUT_LINE('Inserted successfully');
END;
/

-- =========================================
-- 6.2 UPDATE EMAIL USING MOBILE
-- =========================================
DECLARE
    v_mobile VARCHAR2(20) := '&Enter_mobile';
    v_email VARCHAR2(100) := '&Enter_email';
BEGIN
    UPDATE contacts
    SET email = v_email
    WHERE mobileno = v_mobile;

    DBMS_OUTPUT.PUT_LINE('Updated successfully');
END;
/

-- =========================================
-- 6.3 DISPLAY NAME USING EMAIL
-- =========================================
DECLARE
    v_email VARCHAR2(100) := '&Enter_email';
    v_name VARCHAR2(100);
BEGIN
    SELECT name INTO v_name
    FROM contacts
    WHERE email = v_email;

    DBMS_OUTPUT.PUT_LINE('Name = ' || v_name);
END;
/

-- =========================================
-- 6.4 DELETE USING MOBILE AND EMAIL
-- =========================================
DECLARE
    v_mobile VARCHAR2(20) := '&Enter_mobile';
    v_email VARCHAR2(100) := '&Enter_email';
BEGIN
    DELETE FROM contacts
    WHERE mobileno = v_mobile
    AND email = v_email;

    DBMS_OUTPUT.PUT_LINE('Deleted successfully');
END;
/