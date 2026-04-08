-- =========================================
-- EXPERIMENT: VIEWS AND INDEXES
-- =========================================

SET SERVEROUTPUT ON;

-- =========================================
-- DROP TABLES
-- =========================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE customer'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE products'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE sales'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE inventory'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE employee'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE salaries'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE bonuses'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE feedback'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE subscriptions'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE attendance'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

DROP VIEW customer_order_history;
DROP VIEW emp_payroll;
DROP VIEW product_inventory_report;
DROP VIEW dept_employee_count;
DROP VIEW monthly_sales_summary;
DROP VIEW customer_feedback_view;
DROP VIEW active_subscriptions;
DROP VIEW employee_monthly_attendance;

BEGIN
   EXECUTE IMMEDIATE 'DROP INDEX idx_customer_email';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- =========================================
-- CREATE TABLES (MATCHING NOTE VARIABLES)
-- =========================================

CREATE TABLE customer (
    cust_id NUMBER,
    cust_name VARCHAR2(50)
);

CREATE TABLE products (
    prod_id NUMBER,
    prod_name VARCHAR2(50),
    price NUMBER
);

CREATE TABLE orders (
    order_id NUMBER,
    cust_id NUMBER,
    prod_id NUMBER,
    order_date DATE,
    quantity NUMBER
);

CREATE TABLE sales (
    product_id NUMBER,
    sale_date DATE,
    qty_sold NUMBER
);

CREATE TABLE inventory (
    prod_id NUMBER,
    stock NUMBER
);

CREATE TABLE employee (
    emp_id NUMBER,
    emp_name VARCHAR2(50),
    department VARCHAR2(50)
);

CREATE TABLE salaries (
    emp_id NUMBER,
    base_salary NUMBER
);

CREATE TABLE bonuses (
    emp_id NUMBER,
    bonus_amount NUMBER
);

CREATE TABLE feedback (
    customer_id NUMBER,
    prod_id NUMBER,
    rating NUMBER,
    comments VARCHAR2(100)
);

CREATE TABLE subscriptions (
    cust_id NUMBER,
    plan_name VARCHAR2(50),
    end_date DATE
);

CREATE TABLE attendance (
    emp_id NUMBER,
    attendance_date DATE,
    status VARCHAR2(10)
);

-- =========================================
-- INSERT DATA
-- =========================================

INSERT INTO customer VALUES (1, 'Aakash');
INSERT INTO customer VALUES (2, 'Rahul');

INSERT INTO products VALUES (1, 'Laptop', 50000);
INSERT INTO products VALUES (2, 'Phone', 20000);

INSERT INTO orders VALUES (1, 1, 1, SYSDATE, 1);
INSERT INTO orders VALUES (2, 2, 2, SYSDATE, 2);

INSERT INTO sales VALUES (1, SYSDATE, 3);
INSERT INTO sales VALUES (2, SYSDATE, 5);

INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (2, 20);

INSERT INTO employee VALUES (1, 'John', 'IT');
INSERT INTO employee VALUES (2, 'Sam', 'HR');

INSERT INTO salaries VALUES (1, 50000);
INSERT INTO salaries VALUES (2, 40000);

INSERT INTO bonuses VALUES (1, 5000);
INSERT INTO bonuses VALUES (2, 3000);

INSERT INTO feedback VALUES (1, 1, 5, 'Good');
INSERT INTO feedback VALUES (2, 2, 4, 'Nice');

INSERT INTO subscriptions VALUES (1, 'Premium', SYSDATE+5);
INSERT INTO subscriptions VALUES (2, 'Basic', SYSDATE-1);

INSERT INTO attendance VALUES (1, SYSDATE, 'Present');
INSERT INTO attendance VALUES (1, SYSDATE-1, 'Absent');

COMMIT;

-- =========================================
-- VIEWS (MATCHED EXACTLY)
-- =========================================

-- 1
CREATE VIEW customer_order_history AS
SELECT c.cust_name,
       o.order_date,
       p.prod_name,
       (p.price * o.quantity) AS total_amt
FROM orders o
JOIN customer c ON o.cust_id = c.cust_id
JOIN products p ON o.prod_id = p.prod_id;

SELECT * FROM customer_order_history;

-- 2
CREATE VIEW emp_payroll AS
SELECT e.emp_name,
       s.base_salary,
       b.bonus_amount,
       (s.base_salary + b.bonus_amount) AS total_salary
FROM employee e
JOIN salaries s ON e.emp_id = s.emp_id
JOIN bonuses b ON e.emp_id = b.emp_id;

SELECT * FROM emp_payroll;

-- 3
CREATE VIEW product_inventory_report AS
SELECT p.prod_name,
       i.stock,
       SUM(s.qty_sold) AS total_sales,
       (i.stock - SUM(s.qty_sold)) AS remaining_stock
FROM products p
JOIN inventory i ON p.prod_id = i.prod_id
JOIN sales s ON p.prod_id = s.product_id
GROUP BY p.prod_name, i.stock;

SELECT * FROM product_inventory_report;

-- 4
CREATE VIEW dept_employee_count AS
SELECT department,
       COUNT(*) AS employee_count
FROM employee
GROUP BY department;

SELECT * FROM dept_employee_count;

-- 5
CREATE VIEW monthly_sales_summary AS
SELECT TO_CHAR(s.sale_date,'MM') AS sale_month,
       p.prod_name,
       SUM(s.qty_sold * p.price) AS total_sales
FROM sales s
JOIN products p ON s.product_id = p.prod_id
GROUP BY TO_CHAR(s.sale_date,'MM'), p.prod_name;

SELECT * FROM monthly_sales_summary;

-- 6
CREATE VIEW customer_feedback_view AS
SELECT c.cust_name,
       p.prod_name,
       f.rating,
       f.comments
FROM feedback f
JOIN customer c ON f.customer_id = c.cust_id
JOIN products p ON f.prod_id = p.prod_id;

SELECT * FROM customer_feedback_view;

-- 7
CREATE VIEW active_subscriptions AS
SELECT c.cust_name,
       s.plan_name,
       s.end_date
FROM subscriptions s
JOIN customer c ON s.cust_id = c.cust_id
WHERE s.end_date >= SYSDATE;

SELECT * FROM active_subscriptions;

-- 8
CREATE VIEW employee_monthly_attendance AS
SELECT emp_id,
       TO_CHAR(attendance_date,'MM') AS month,
       SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END) AS days_present,
       SUM(CASE WHEN status='Absent' THEN 1 ELSE 0 END) AS days_absent
FROM attendance
GROUP BY emp_id, TO_CHAR(attendance_date,'MM');

SELECT * FROM employee_monthly_attendance;

-- =========================================
-- INDEXES (MATCHED NAMES)
-- =========================================

CREATE UNIQUE INDEX idx_customer_email ON customer(cust_id);

CREATE INDEX idx_orders_customer ON orders(cust_id);

CREATE INDEX idx_sales_date ON sales(sale_date);

CREATE INDEX idx_enroll_student ON employee(emp_id);

CREATE INDEX idx_department ON salaries(emp_id);

CREATE INDEX idx_posts_content ON products(prod_name);

CREATE INDEX idx_product_price ON products(price);

CREATE INDEX idx_store_salesdate ON sales(product_id, sale_date);

CREATE UNIQUE INDEX idx_unique_email ON customer(cust_id);

CREATE INDEX idx_orderid ON orders(order_id);