/* CLEANUP */
DROP TABLE product_reviews;
DROP TABLE sales;
DROP TABLE products;
DROP TABLE categories;

/* 1. PRODUCTS */
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    description VARCHAR2(100),
    price NUMBER(10,2),
    stock_quantity NUMBER
);

/* 2. CATEGORIES + FK */
CREATE TABLE categories (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(50)
);

ALTER TABLE products ADD category_id NUMBER;

ALTER TABLE products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id)
REFERENCES categories(category_id);

/* 3. DISCOUNT */
ALTER TABLE products
ADD discount_percentage NUMBER(5,2)
CHECK (discount_percentage BETWEEN 0 AND 100);

/* 4. DATE ADDED */
ALTER TABLE products
ADD date_added DATE NOT NULL;

/* 5. REVIEWS */
CREATE TABLE product_reviews (
    review_id NUMBER PRIMARY KEY,
    product_id NUMBER,
    review_text VARCHAR2(100),
    rating NUMBER,
    CONSTRAINT fk_review_product
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

/* 6. UNIQUE NAME */
ALTER TABLE products
ADD CONSTRAINT uq_product_name UNIQUE (product_name);

/* 7. DROP COLUMN */
ALTER TABLE product_reviews
DROP COLUMN rating;

/* 8. PRICE CHECK */
ALTER TABLE products
ADD CONSTRAINT chk_price CHECK (price > 0);

/* 10. NOT NULL + STOCK */
ALTER TABLE products
MODIFY product_name VARCHAR2(100) NOT NULL;

ALTER TABLE products
ADD CONSTRAINT chk_stock CHECK (stock_quantity >= 0);

/* 12. CASCADE DELETE */
ALTER TABLE product_reviews
DROP CONSTRAINT fk_review_product;

ALTER TABLE product_reviews
ADD CONSTRAINT fk_review_product
FOREIGN KEY (product_id)
REFERENCES products(product_id)
ON DELETE CASCADE;

/* 13. COMPOSITE UNIQUE */
ALTER TABLE products
ADD CONSTRAINT uq_name_category
UNIQUE (product_name, category_id);

/* 14. LAST UPDATED */
ALTER TABLE products ADD last_updated DATE;
ALTER TABLE products MODIFY last_updated NOT NULL;

/* TRIGGER instead of CHECK */
CREATE OR REPLACE TRIGGER trg_last_updated
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
BEGIN
    IF :NEW.last_updated > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'Future date not allowed');
    END IF;
END;
/

/* 15. SALES + TRIGGER */
CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    product_id NUMBER,
    quantity_sold NUMBER
);

CREATE OR REPLACE TRIGGER trg_check_stock
BEFORE INSERT ON sales
FOR EACH ROW
DECLARE
    available_stock NUMBER;
BEGIN
    SELECT stock_quantity INTO available_stock
    FROM products
    WHERE product_id = :NEW.product_id;

    IF available_stock < :NEW.quantity_sold THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock');
    END IF;
END;
/

/* 16. DESCRIPTION CHECK */
ALTER TABLE products
ADD CONSTRAINT chk_description_length
CHECK (description IS NULL OR LENGTH(description) >= 10);