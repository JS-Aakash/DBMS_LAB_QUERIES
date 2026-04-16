DROP TABLE sales_transactions;
DROP TABLE customers;
DROP TABLE mobilephones;
DROP TABLE employees;
DROP TABLE product_categories;

-- Mobile Phones
CREATE TABLE mobilephones (
    phoneID NUMBER PRIMARY KEY,
    brand VARCHAR2(50),
    model VARCHAR2(50),
    price NUMBER,
    releaseYear NUMBER,
    stockQuantity NUMBER
);

-- Customers
CREATE TABLE customers (
    customerID NUMBER PRIMARY KEY,
    customerName VARCHAR2(50),
    email VARCHAR2(50),
    phone VARCHAR2(15)
);

-- Sales
CREATE TABLE sales_transactions (
    transactionID NUMBER PRIMARY KEY,
    customerID NUMBER,
    phoneID NUMBER,
    transactionDate DATE
);

-- Employees
CREATE TABLE employees (
    employeeID NUMBER PRIMARY KEY,
    employeeName VARCHAR2(50),
    role VARCHAR2(50),
    salary NUMBER,
    hireDate DATE DEFAULT SYSDATE
);

-- Categories
CREATE TABLE product_categories (
    categoryID NUMBER PRIMARY KEY,
    categoryName VARCHAR2(50),
    description VARCHAR2(100)
);

-- 1. Insert Mobile Phone
INSERT INTO mobilephones (phoneID, brand, model, price, releaseYear, stockQuantity)
VALUES (101, 'Samsung', 'Galaxy S23', 750, 2023, 10);

SELECT * FROM mobilephones;
-- 2. Insert Customer + Transaction
INSERT INTO customers VALUES (301,'John Doe','john@example.com','1234567890');

INSERT INTO sales_transactions VALUES (2001,301,101,DATE '2026-01-20');

SELECT * FROM customers;
SELECT * FROM sales_transactions;
-- 3. Update Stock
UPDATE mobilephones SET stockQuantity = 50 WHERE phoneID = 101;

SELECT * FROM mobilephones;
-- 4. Delete Transaction
DELETE FROM sales_transactions WHERE transactionID = 2001;

SELECT * FROM sales_transactions;
-- 5. Update Model Name
UPDATE mobilephones SET model = 'iPhone 15' WHERE phoneID = 102;

SELECT * FROM mobilephones;
-- 6. Update Price with Condition
UPDATE mobilephones 
SET price = price + 50 
WHERE phoneID = 103 AND price > 0;

SELECT * FROM mobilephones;
-- 7. Insert Composite Key Sale
INSERT INTO sales_transactions VALUES (2002,301,101,SYSDATE);

SELECT * FROM sales_transactions;
-- 8. Update Brand
UPDATE mobilephones 
SET brand = 'Samsung Electronics' 
WHERE brand = 'Samsung';

SELECT * FROM mobilephones;
-- 9. Insert Employee (Default Date)
INSERT INTO employees (employeeID, employeeName, role)
VALUES (201,'Jane Smith','Manager');

SELECT * FROM employees;
-- 10. Delete Phone
DELETE FROM mobilephones WHERE phoneID = 105;

SELECT * FROM mobilephones;
-- 11. Insert Category
INSERT INTO product_categories VALUES (10,'Smartphones','Mobile devices');

SELECT * FROM product_categories;
-- 12. Insert Sale (Referential)
INSERT INTO sales_transactions VALUES (3002,301,101,SYSDATE);

SELECT * FROM sales_transactions;
-- 13. Set Release Year NULL
UPDATE mobilephones SET releaseYear = NULL WHERE phoneID = 101;

SELECT * FROM mobilephones;

ROLLBACK;
SELECT * FROM mobilephones;
-- 14. Insert Employee Auto
INSERT INTO employees (employeeName, role) VALUES ('Mike Brown','Developer');

SELECT * FROM employees;
-- 15. Update Price Conditions
UPDATE mobilephones 
SET price = 200 
WHERE phoneID = 102 AND price < 200 AND price IS NOT NULL;

SELECT * FROM mobilephones;
-- 16. Update Email
UPDATE customers SET email='arun@newmail.com' WHERE customerID=301;

SELECT * FROM customers;
-- 17. Delete Customer
DELETE FROM customers WHERE customerID = 302;

SELECT * FROM customers;
-- 18. Increase Stock
UPDATE mobilephones 
SET stockQuantity = stockQuantity + 100 
WHERE phoneID = 104;

SELECT * FROM mobilephones;
-- 19. Reduce Stock
UPDATE mobilephones 
SET stockQuantity = stockQuantity - 3 
WHERE phoneID = 105;

SELECT * FROM mobilephones;
-- 20. Update Employee Role
UPDATE employees 
SET role='Senior Developer' 
WHERE employeeID=201;

SELECT * FROM employees;
-- 21. Insert Multiple Phones
INSERT ALL
INTO mobilephones VALUES (107,'Apple','iPhone 14',900,2022,10)
INTO mobilephones VALUES (108,'Samsung','Galaxy A54',400,2023,15)
INTO mobilephones VALUES (109,'OnePlus','Nord CE',650,2023,20)
SELECT * FROM dual;

SELECT * FROM mobilephones;
-- 22. Increase Apple Price
UPDATE mobilephones 
SET price = price * 1.10 
WHERE brand='Apple';

SELECT * FROM mobilephones;
-- 23. Delete Customer Transactions
DELETE FROM sales_transactions WHERE customerID=304;

SELECT * FROM sales_transactions;
-- 24. Select Phones < 500
SELECT * FROM mobilephones WHERE price < 500;
-- 25. Employees This Year
SELECT * FROM employees 
WHERE EXTRACT(YEAR FROM hireDate)=EXTRACT(YEAR FROM SYSDATE);
-- 26. Bulk Insert Sales
INSERT ALL
INTO sales_transactions VALUES (3001,305,106,SYSDATE)
INTO sales_transactions VALUES (3002,305,107,SYSDATE)
SELECT * FROM dual;

SELECT * FROM sales_transactions;
-- 27. Correct Transaction Date
UPDATE sales_transactions 
SET transactionDate = DATE '2026-01-20' 
WHERE transactionID = 4001;

SELECT * FROM sales_transactions;
-- 28. Increase Salary
UPDATE employees 
SET salary = salary + 2000 
WHERE role='Manager' AND salary < 50000;

SELECT * FROM employees;

-- 29. Delete Outdated Products
DELETE FROM mobilephones
WHERE releaseYear < 2020;

SELECT * FROM mobilephones;

-- 30. Retrieve Sales of Specific Customer
SELECT 
    s.transactionID,
    s.customerID,
    m.phoneID,
    m.brand,
    m.model,
    m.price,
    s.transactionDate
FROM sales_transactions s
JOIN mobilephones m
ON s.phoneID = m.phoneID
WHERE s.customerID = 301;