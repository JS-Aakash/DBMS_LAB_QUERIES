BEGIN EXECUTE IMMEDIATE 'DROP TABLE prod_audit'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE prod_master'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE prod_audit_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- =========================================
-- CREATE TABLES
-- =========================================
CREATE TABLE prod_master (
    pid NUMBER,
    prod_name VARCHAR2(50),
    price NUMBER,
    qty NUMBER,
    status VARCHAR2(20)
);

CREATE TABLE prod_audit (
    audit_id NUMBER,
    pid NUMBER,
    operation VARCHAR2(10),
    old_price NUMBER,
    new_price NUMBER,
    old_qty NUMBER,
    new_qty NUMBER,
    user_name VARCHAR2(50),
    action_date DATE
);

-- =========================================
-- CREATE SEQUENCE
-- =========================================
CREATE SEQUENCE prod_audit_seq
START WITH 1
INCREMENT BY 1;

-- =========================================
-- TRIGGER 1: AUDIT (INSERT + UPDATE)
-- =========================================
CREATE OR REPLACE TRIGGER trg_prod_audit
AFTER INSERT OR UPDATE ON prod_master
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO prod_audit VALUES (
            prod_audit_seq.NEXTVAL,
            :NEW.pid,
            'INSERT',
            NULL,
            :NEW.price,
            NULL,
            :NEW.qty,
            USER,
            SYSDATE
        );

    ELSIF UPDATING THEN
        INSERT INTO prod_audit VALUES (
            prod_audit_seq.NEXTVAL,
            :NEW.pid,
            'UPDATE',
            :OLD.price,
            :NEW.price,
            :OLD.qty,
            :NEW.qty,
            USER,
            SYSDATE
        );
    END IF;
END;
/
-- =========================================
-- TRIGGER 2: STOCK STATUS (BEFORE)
-- =========================================
CREATE OR REPLACE TRIGGER trg_prod_stock
BEFORE INSERT OR UPDATE ON prod_master
FOR EACH ROW
BEGIN
    IF :NEW.qty < 5 THEN
        :NEW.status := 'LOW STOCK';
    ELSE
        :NEW.status := 'AVAILABLE';
    END IF;
END;
/
-- =========================================
-- TRIGGER 3: ALERT MESSAGE (AFTER UPDATE)
-- =========================================
CREATE OR REPLACE TRIGGER trg_prod_alert
AFTER UPDATE ON prod_master
FOR EACH ROW
BEGIN
    IF :NEW.qty < 5 THEN
        DBMS_OUTPUT.PUT_LINE('Alert: Stock is low for product ID: ' || :NEW.pid);
    END IF;
END;
/
-- =========================================
-- INSERT DATA
-- =========================================
INSERT INTO prod_master VALUES (1,'Laptop',50000,10,NULL);
INSERT INTO prod_master VALUES (2,'Mobile',20000,8,NULL);
INSERT INTO prod_master VALUES (3,'Tablet',15000,3,NULL);

COMMIT;

-- =========================================
-- VIEW DATA
-- =========================================
SELECT * FROM prod_master;

SELECT * FROM prod_audit;

-- =========================================
-- TEST UPDATE (TRIGGER EXECUTION)
-- =========================================
UPDATE prod_master SET qty = 2 WHERE pid = 1;

-- =========================================
-- FINAL OUTPUT
-- =========================================
SELECT * FROM prod_master;

SELECT * FROM prod_audit;