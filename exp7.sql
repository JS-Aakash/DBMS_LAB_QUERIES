SET SERVEROUTPUT ON;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE customer_order';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
 
-- =========================================
-- CREATE TABLE
-- =========================================
CREATE TABLE customer_order (
    orderId NUMBER,
    customerId NUMBER,
    totalAmount NUMBER,
    orderStatus VARCHAR2(20)
);

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================
INSERT INTO customer_order VALUES (1, 101, 600, 'pending');
INSERT INTO customer_order VALUES (2, 102, 300, 'completed');
INSERT INTO customer_order VALUES (3, 103, 800, 'pending');
INSERT INTO customer_order VALUES (4, 104, 200, 'completed');
INSERT INTO customer_order VALUES (5, 105, 900, 'completed');

COMMIT;

-- =========================================
-- 1) CURSOR: ORDERS WITH AMOUNT > 500
-- =========================================
DECLARE
    CURSOR c_orders IS
        SELECT orderId, customerId, totalAmount
        FROM customer_order
        WHERE totalAmount > 500;

    v_orderId NUMBER;
    v_customerId NUMBER;
    v_totalAmount NUMBER;

BEGIN
    OPEN c_orders;

    LOOP
        FETCH c_orders INTO v_orderId, v_customerId, v_totalAmount;
        EXIT WHEN c_orders%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'OrderID: ' || v_orderId ||
            ' CustomerID: ' || v_customerId ||
            ' TotalAmount: ' || v_totalAmount
        );
    END LOOP;

    CLOSE c_orders;
END;
/
 
-- =========================================
-- 2) CURSOR: COUNT ORDERS BY STATUS
-- =========================================
DECLARE
    CURSOR c_status IS
        SELECT orderStatus, COUNT(*) AS total_orders
        FROM customer_order
        GROUP BY orderStatus;

    v_status VARCHAR2(20);
    v_count NUMBER;

BEGIN
    OPEN c_status;

    LOOP
        FETCH c_status INTO v_status, v_count;
        EXIT WHEN c_status%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Order Status: ' || v_status ||
            ' Count: ' || v_count
        );
    END LOOP;

    CLOSE c_status;
END;
/
 
-- =========================================
-- 3) CURSOR: UPDATE PENDING → PROCESSING
-- =========================================
DECLARE
    CURSOR c_orders IS
        SELECT orderId, orderStatus
        FROM customer_order
        FOR UPDATE;

    v_orderId NUMBER;
    v_status VARCHAR2(20);

BEGIN
    OPEN c_orders;

    LOOP
        FETCH c_orders INTO v_orderId, v_status;
        EXIT WHEN c_orders%NOTFOUND;

        IF v_status = 'pending' THEN
            UPDATE customer_order
            SET orderStatus = 'processing'
            WHERE CURRENT OF c_orders;

            DBMS_OUTPUT.PUT_LINE(
                'OrderID: ' || v_orderId ||
                ' updated to processing'
            );
        END IF;

    END LOOP;

    CLOSE c_orders;

    COMMIT;
END;
/