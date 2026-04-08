-- =========================================
-- EXP NO: 4
-- JOIN OPERATIONS
-- =========================================
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE order_items';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE orders';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE product';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE customer';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE employee';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE department';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE student';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE student_marks';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE officer';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE city';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE cases';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE crime_type';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE victim';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE report';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE employee';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE department';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE customer';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE orders';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE product';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE order_items';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE student';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE student_marks';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE officer';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE city';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE cases';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE crime_type';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
DELETE FROM cases;
DELETE FROM officer;
COMMIT;

CREATE TABLE department (
    dept_id NUMBER,
    dept_name VARCHAR2(50)
);

CREATE TABLE employee (
    emp_id NUMBER,
    emp_name VARCHAR2(50),
    salary NUMBER,
    dept_id NUMBER
);

CREATE TABLE customer (
    cust_id NUMBER,
    cust_name VARCHAR2(50)
);

CREATE TABLE orders (
    order_id NUMBER,
    cust_id NUMBER,
    order_date DATE
);

CREATE TABLE product (
    prod_id NUMBER,
    prod_name VARCHAR2(50)
);

CREATE TABLE order_items (
    order_id NUMBER,
    prod_id NUMBER
);

CREATE TABLE student (
    student_id NUMBER,
    student_name VARCHAR2(50)
);

CREATE TABLE student_marks (
    student_id NUMBER,
    subject VARCHAR2(50),
    marks NUMBER
);

CREATE TABLE officer (
    officer_id NUMBER,
    officer_name VARCHAR2(50),
    experience NUMBER
);

CREATE TABLE city (
    city_id NUMBER,
    city_name VARCHAR2(50)
);

CREATE TABLE cases (
    case_id NUMBER,
    type_name VARCHAR2(50),
    city_id NUMBER,
    status VARCHAR2(50),
    severity NUMBER,
    officer_id NUMBER,
    victim_id NUMBER
);

CREATE TABLE crime_type (
    type_id NUMBER,
    type_name VARCHAR2(50)
);

CREATE TABLE victim (
    victim_id NUMBER,
    victim_name VARCHAR2(50)
);

CREATE TABLE report (
    victim_id NUMBER,
    case_id NUMBER
);


-- =========================================
-- EMPLOYEE
-- =========================================
INSERT INTO employee VALUES (1,'Amit',40000,10);
INSERT INTO employee VALUES (2,'Rahul',60000,20);
INSERT INTO employee VALUES (3,'Sneha',70000,10);
INSERT INTO employee VALUES (4,'Kiran',30000,30);
INSERT INTO employee VALUES (5,'Anu',65000,20);
INSERT INTO employee VALUES (6,'Priya',55000,20);
INSERT INTO employee VALUES (7,'Arun',52000,10);

-- =========================================
-- DEPARTMENT
-- =========================================
INSERT INTO department VALUES (10,'HR');
INSERT INTO department VALUES (20,'IT');
INSERT INTO department VALUES (30,'Sales');

-- =========================================
-- CUSTOMER
-- =========================================
INSERT INTO customer VALUES (1,'Arun');
INSERT INTO customer VALUES (2,'Meena');
INSERT INTO customer VALUES (3,'John');
INSERT INTO customer VALUES (4,'David');
INSERT INTO customer VALUES (5,'Ravi');

-- =========================================
-- ORDERS
-- =========================================
INSERT INTO orders VALUES (101,1,DATE '2024-01-01');
INSERT INTO orders VALUES (102,1,DATE '2024-02-01');
INSERT INTO orders VALUES (103,2,DATE '2024-03-01');
INSERT INTO orders VALUES (104,2,DATE '2024-04-01');

-- =========================================
-- PRODUCT
-- =========================================
INSERT INTO product VALUES (1,'Laptop');
INSERT INTO product VALUES (2,'Mobile');
INSERT INTO product VALUES (3,'Tablet');
INSERT INTO product VALUES (4,'Watch');
INSERT INTO product VALUES (5,'TV');

-- =========================================
-- ORDER_ITEMS
-- =========================================
INSERT INTO order_items VALUES (101,1);
INSERT INTO order_items VALUES (102,2);

-- =========================================
-- STUDENT
-- =========================================
INSERT INTO student VALUES (1,'Aakash');
INSERT INTO student VALUES (2,'Rahul');
INSERT INTO student VALUES (3,'Sneha');
INSERT INTO student VALUES (4,'Kiran');

-- =========================================
-- STUDENT_MARKS
-- =========================================
INSERT INTO student_marks VALUES (1,'DBMS',80);
INSERT INTO student_marks VALUES (2,'DBMS',60);
INSERT INTO student_marks VALUES (3,'DBMS',90);
INSERT INTO student_marks VALUES (4,'DBMS',85);

-- =========================================
-- OFFICER
-- =========================================
INSERT INTO officer VALUES (1,'Raj',0);
INSERT INTO officer VALUES (2,'Vijay',5);
INSERT INTO officer VALUES (3,'Arjun',0);

-- =========================================
-- CITY
-- =========================================
INSERT INTO city VALUES (1,'Chennai');
INSERT INTO city VALUES (2,'Salem');

-- =========================================
-- CASES
-- =========================================
INSERT INTO cases VALUES (1,'Theft',1,'solved',5,1,1);
INSERT INTO cases VALUES (2,'Murder',1,'unsolved',10,2,2);
INSERT INTO cases VALUES (3,'Theft',2,'solved',10,1,1);
INSERT INTO cases VALUES (4,'Murder',2,'unsolved',10,3,2);
INSERT INTO cases VALUES (5,'Robbery',2,'solved',8,3,2);

-- =========================================
-- CRIME_TYPE
-- =========================================
INSERT INTO crime_type VALUES (1,'Theft');
INSERT INTO crime_type VALUES (2,'Murder');

-- =========================================
-- VICTIM
-- =========================================
INSERT INTO victim VALUES (1,'Ravi');
INSERT INTO victim VALUES (2,'Sita');
INSERT INTO victim VALUES (3,'Kumar');

-- =========================================
-- REPORT
-- =========================================
INSERT INTO report VALUES (1,1);


-- 1) Employee salary comparison
SELECT E.emp_id, E.emp_name, E.salary
FROM employee E
JOIN (SELECT AVG(salary) AS avg_sal FROM employee) A
ON E.salary > A.avg_sal;


-- =========================================
-- 2) Fetch last order of each customer
-- =========================================
SELECT C.cust_name, O.order_date
FROM customer C
JOIN orders O ON C.cust_id = O.cust_id
WHERE O.order_date = (
    SELECT MAX(O2.order_date)
    FROM orders O2
    WHERE O2.cust_id = C.cust_id
);


-- =========================================
-- 3) Customers who have not placed any orders
-- =========================================
SELECT C.cust_id, C.cust_name
FROM customer C
LEFT JOIN orders O ON C.cust_id = O.cust_id
WHERE O.order_id IS NULL;


-- =========================================
-- 4) Departments with maximum employees
-- =========================================
SELECT D.dept_id, D.dept_name, E.emp_count
FROM department D
JOIN (
    SELECT dept_id, COUNT(*) AS emp_count
    FROM employee
    GROUP BY dept_id
) E ON D.dept_id = E.dept_id
WHERE E.emp_count = (
    SELECT MAX(CNT)
    FROM (
        SELECT COUNT(*) CNT
        FROM employee
        GROUP BY dept_id
    )
);


-- =========================================
-- 5) Products that have never been sold
-- =========================================
SELECT P.prod_id, P.prod_name
FROM product P
LEFT JOIN order_items OI ON P.prod_id = OI.prod_id
WHERE OI.prod_id IS NULL;


-- =========================================
-- 6) Students above class average (DBMS)
-- =========================================
SELECT S.student_id, S.student_name, M.subject, M.marks
FROM student S
JOIN student_marks M ON S.student_id = M.student_id
JOIN (
    SELECT subject, AVG(marks) AS avg_marks
    FROM student_marks
    GROUP BY subject
) A ON M.subject = A.subject
WHERE M.subject = 'DBMS'
AND M.marks > A.avg_marks;


-- =========================================
-- 7) Top 3 highest paid employees
-- =========================================
SELECT *
FROM (
    SELECT e.emp_id, e.emp_name, e.salary
    FROM employee e
    JOIN department D ON e.dept_id = D.dept_id
    ORDER BY e.salary DESC
)
WHERE ROWNUM <= 3;


-- =========================================
-- ADDITIONAL QUERIES
-- =========================================

-- 1) Officer who solved most cases
SELECT O.officer_id, O.officer_name
FROM officer O
JOIN cases C ON O.officer_id = C.officer_id
WHERE C.status = 'solved'
GROUP BY O.officer_id, O.officer_name
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM cases
        WHERE status = 'solved'
        GROUP BY officer_id
    )
);

-- =========================================
-- 2) Unsolved cases in highest crime city
-- =========================================
SELECT C.case_id, C.type_name, CT.city_name, C.status
FROM cases C
JOIN city CT ON C.city_id = CT.city_id
WHERE C.city_id = (
    SELECT city_id
    FROM cases
    GROUP BY city_id
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM cases
        GROUP BY city_id
    )
)
AND C.status = 'unsolved';


-- =========================================
-- 3) Most reported crime type
-- =========================================
SELECT CT.type_id, CT.type_name
FROM crime_type CT
JOIN cases C ON CT.type_name = C.type_name
GROUP BY CT.type_id, CT.type_name
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) cnt
        FROM cases
        GROUP BY type_name
    )
);


-- =========================================
-- 4) Victims with no reported cases
-- =========================================
SELECT V.victim_id, V.victim_name
FROM victim V
LEFT JOIN report R ON V.victim_id = R.victim_id
LEFT JOIN cases C ON R.case_id = C.case_id
WHERE C.case_id IS NULL;


-- =========================================
-- 5) Cases handled by officers with no experience
-- =========================================
SELECT C.case_id, C.type_name, O.officer_name
FROM cases C
JOIN officer O ON C.officer_id = O.officer_id
WHERE O.experience = 0;


-- =========================================
-- 6) Officers handling highest severity cases
-- =========================================
SELECT DISTINCT O.officer_id, O.officer_name
FROM officer O
JOIN cases C ON O.officer_id = C.officer_id
WHERE C.severity = (
    SELECT MAX(severity)
    FROM cases
);


-- =========================================
-- 7) Crime prone areas
-- =========================================
SELECT CT.city_name
FROM city CT
JOIN cases C ON CT.city_id = C.city_id
GROUP BY CT.city_name
HAVING COUNT(*) > (
    SELECT AVG(CNT)
    FROM (
        SELECT COUNT(*) CNT
        FROM cases
        GROUP BY city_id
    )
);