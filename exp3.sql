/* =========================================
   CLEANUP (so script can run multiple times)
========================================= */

DROP TABLE orders;
DROP TABLE product;
DROP TABLE customer;
DROP TABLE employee;
DROP TABLE student;
DROP TABLE dept;
DROP TABLE officer;
DROP TABLE cases;
DROP TABLE crime;
DROP TABLE victim;

/* =========================================
   TABLE CREATION
========================================= */

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT
);

CREATE TABLE dept (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE customer (
    cust_id INT PRIMARY KEY,
    fname VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id INT,
    product_id INT,
    amount INT,
    order_date DATE
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

CREATE TABLE officer (
    officer_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience INT
);

CREATE TABLE cases (
    case_id INT PRIMARY KEY,
    officer_id INT,
    status VARCHAR(20),
    city VARCHAR(50),
    crime_id INT
);

CREATE TABLE crime (
    crime_id INT PRIMARY KEY,
    crime_type VARCHAR(50),
    severity VARCHAR(20),
    location VARCHAR(50),
    victim_id INT
);

CREATE TABLE victim (
    victim_id INT PRIMARY KEY,
    name VARCHAR(50)
);

/* =========================================
   INSERT DATA
========================================= */

-- Departments
INSERT INTO dept VALUES (1,'IT');
INSERT INTO dept VALUES (2,'HR');

-- Employees
INSERT INTO employee VALUES (1,'Michael',50000,1);
INSERT INTO employee VALUES (2,'Sarah',60000,1);
INSERT INTO employee VALUES (3,'David',70000,2);
INSERT INTO employee VALUES (4,'Emma',80000,2);

-- Customers
INSERT INTO customer VALUES (1,'John');
INSERT INTO customer VALUES (2,'Alice');
INSERT INTO customer VALUES (3,'Bob');

-- Products
INSERT INTO product VALUES (1,'Laptop');
INSERT INTO product VALUES (2,'Phone');
INSERT INTO product VALUES (3,'Tablet');

-- Orders
INSERT INTO orders VALUES (1,1,1,50000, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (2,1,2,20000, TO_DATE('2024-02-01', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (3,2,1,50000, TO_DATE('2024-03-01', 'YYYY-MM-DD'));

-- Students
INSERT INTO student VALUES (1,'James',80);
INSERT INTO student VALUES (2,'Lily',60);
INSERT INTO student VALUES (3,'Harry',90);

-- Officers
INSERT INTO officer VALUES (1,'Robert',5);
INSERT INTO officer VALUES (2,'William',0);
INSERT INTO officer VALUES (3,'Richard',3);

-- Victims
INSERT INTO victim VALUES (1,'Thomas');
INSERT INTO victim VALUES (2,'Charles');
INSERT INTO victim VALUES (3,'Christopher');

-- Crimes
INSERT INTO crime VALUES (1,'Theft','High','Area1',1);
INSERT INTO crime VALUES (2,'Robbery','High','Area1',2);
INSERT INTO crime VALUES (3,'Fraud','Low','Area2',1);

-- Cases
INSERT INTO cases VALUES (1,1,'solved','City1',1);
INSERT INTO cases VALUES (2,1,'solved','City1',2);
INSERT INTO cases VALUES (3,2,'unsolved','City2',3);
INSERT INTO cases VALUES (4,3,'unsolved','City1',1);


/* =========================================
   QUERIES
========================================= */

-- 1. Employees earning more than average
SELECT * FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

-- 2. Latest order of each customer
SELECT c.cust_id, c.fname, o.order_date AS last_order_date, o.amount
FROM customer c
JOIN orders o ON c.cust_id = o.cust_id
WHERE (o.cust_id, o.order_date) IN (
    SELECT cust_id, MAX(order_date)
    FROM orders
    GROUP BY cust_id
);

-- 3. Customers with no orders
SELECT * FROM customer
WHERE cust_id NOT IN (SELECT cust_id FROM orders);

-- 4. Department with maximum employees
SELECT dept_id
FROM employee
GROUP BY dept_id
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM employee
        GROUP BY dept_id
    ) t
);

-- 5. Products never sold
SELECT * FROM product
WHERE product_id NOT IN (SELECT product_id FROM orders);

-- 6. Students above average
SELECT * FROM student
WHERE marks > (SELECT AVG(marks) FROM student);

-- 7. Top 3 highest paid employees
SELECT * FROM employee
WHERE salary IN (
    SELECT salary FROM (
        SELECT DISTINCT salary
        FROM employee
        ORDER BY salary DESC
    ) WHERE ROWNUM <= 3
);

-- ===============================
-- CRIME MANAGEMENT QUERIES
-- ===============================

-- 8. Officers who solved most cases
SELECT officer_id
FROM cases
WHERE status='solved'
GROUP BY officer_id
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) cnt
        FROM cases
        WHERE status='solved'
        GROUP BY officer_id
    ) t
);

-- 9. Unsolved cases in most crime city
SELECT *
FROM cases
WHERE status='unsolved'
AND city = (
    SELECT city
    FROM cases
    GROUP BY city
    HAVING COUNT(*) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(*) cnt
            FROM cases
            GROUP BY city
        ) t
    )
);

-- 10. Most reported crime type
SELECT crime_type
FROM crime
GROUP BY crime_type
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) cnt
        FROM crime
        GROUP BY crime_type
    ) t
);

-- 11. Victims with no reported cases
SELECT *
FROM victim
WHERE victim_id NOT IN (
    SELECT victim_id FROM crime
);

-- 12. Cases handled by officers with no experience
SELECT *
FROM cases
WHERE officer_id IN (
    SELECT officer_id
    FROM officer
    WHERE experience = 0
);

-- 13. Officers assigned to high severity crimes
SELECT DISTINCT officer_id
FROM cases
WHERE crime_id IN (
    SELECT crime_id
    FROM crime
    WHERE severity='High'
);

-- 14. Crime-prone areas (above average)
SELECT location
FROM crime
GROUP BY location
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) cnt
        FROM crime
        GROUP BY location
    ) t
);