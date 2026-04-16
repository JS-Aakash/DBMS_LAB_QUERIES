-- =========================================
-- CLEANUP (DROP OLD OBJECTS)
-- =========================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE prod_master'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE customer_orders'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE update_stock'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE get_customer_name'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION total_stock_value'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION get_discount_price'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- =========================================
-- CREATE TABLES
-- =========================================
CREATE TABLE prod_master (
    pid NUMBER,
    prod_name VARCHAR2(50),
    price NUMBER,
    qty NUMBER,
    category VARCHAR2(50)
);

CREATE TABLE customer_orders (
    order_id NUMBER,
    customer_name VARCHAR2(100)
);

-- =========================================
-- INSERT DATA
-- =========================================
INSERT INTO prod_master VALUES (1,'Laptop',50000,10,'electronics');
INSERT INTO prod_master VALUES (2,'Mobile',20000,5,'electronics');
INSERT INTO prod_master VALUES (3,'Chair',3000,20,'furniture');

INSERT INTO customer_orders VALUES (101,'Aakash');
INSERT INTO customer_orders VALUES (102,'Rahul');

COMMIT;

-- =========================================
-- PROCEDURE 1: UPDATE STOCK
-- =========================================
CREATE OR REPLACE PROCEDURE update_stock (
    p_id IN NUMBER,
    p_qty IN NUMBER
)
IS
    v_qty NUMBER;
BEGIN
    SELECT qty INTO v_qty
    FROM prod_master
    WHERE pid = p_id;

    IF p_qty > 0 THEN
        UPDATE prod_master
        SET qty = qty + p_qty
        WHERE pid = p_id;

    ELSIF p_qty < 0 THEN
        IF v_qty >= ABS(p_qty) THEN
            UPDATE prod_master
            SET qty = qty + p_qty
            WHERE pid = p_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20001,'Insufficient stock');
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Stock updated successfully');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Product not found');
END;
/
-- =========================================
-- EXECUTE PROCEDURE
-- =========================================
BEGIN
    update_stock(1,5);
    update_stock(1,-3);
    update_stock(1,-2);
END;
/

SELECT * FROM prod_master;

-- =========================================
-- FUNCTION 1: TOTAL STOCK VALUE
-- =========================================
CREATE OR REPLACE FUNCTION total_stock_value (
    p_id IN NUMBER
)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT price * qty INTO v_total
    FROM prod_master
    WHERE pid = p_id;

    RETURN v_total;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

SELECT total_stock_value(1) FROM dual;

-- =========================================
-- FUNCTION 2: DISCOUNT PRICE
-- =========================================
CREATE OR REPLACE FUNCTION get_discount_price (
    p_id IN NUMBER
)
RETURN NUMBER
IS
    v_price NUMBER;
    v_cat VARCHAR2(50);
BEGIN
    SELECT price, category INTO v_price, v_cat
    FROM prod_master
    WHERE pid = p_id;

    IF LOWER(v_cat) = 'electronics' THEN
        RETURN v_price * 0.9;  -- 10% discount
    ELSE
        RETURN v_price * 0.95; -- 5% discount
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

SELECT get_discount_price(1) FROM dual;

-- =========================================
-- PROCEDURE 2: GET CUSTOMER NAME
-- =========================================
CREATE OR REPLACE PROCEDURE get_customer_name (
    p_order_id IN NUMBER,
    p_name OUT VARCHAR2
)
IS
BEGIN
    SELECT customer_name INTO p_name
    FROM customer_orders
    WHERE order_id = p_order_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_name := 'Not Found';
END;
/

-- =========================================
-- EXECUTE PROCEDURE
-- =========================================
DECLARE
    v_name VARCHAR2(100);
BEGIN
    get_customer_name(101, v_name);
    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_name);
END;
/