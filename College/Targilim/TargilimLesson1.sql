-- מתן אלמליח 205625221

-- תרגיל 1
SELECT customerNumber, creditLimit
FROM customers;

SELECT *
FROM productlines;

SELECT productCode, quantityOrdered, priceEach
FROM orderdetails;

SELECT productCode AS PC, 
       quantityOrdered, 
       quantityOrdered * priceEach AS totalPrice
FROM orderdetails;


-- תרגיל 2
SELECT customerNumber, creditLimit
FROM customers
WHERE creditLimit > 50000;

SELECT *
FROM productlines
WHERE productLine = 'Ships';

SELECT orderNumber, quantityOrdered, priceEach
FROM orderdetails
WHERE quantityOrdered > 30 AND priceEach > 100;

SELECT orderNumber, quantityOrdered, priceEach
FROM orderdetails
WHERE quantityOrdered < 30 OR priceEach > 100;


-- תרגיל 3
SELECT customerNumber, creditLimit
FROM customers
WHERE creditLimit > 50000
ORDER BY customerNumber;

SELECT productCode, quantityOrdered, priceEach
FROM orderdetails
WHERE quantityOrdered > 30 AND priceEach > 100
ORDER BY priceEach DESC;


-- תרגיל 4
SELECT DISTINCT orderNumber
FROM orderdetails
WHERE quantityOrdered > 30 AND priceEach > 100
ORDER BY orderNumber;


-- תרגיל 5
SELECT DISTINCT orderNumber
FROM orderdetails
WHERE quantityOrdered > 30
  AND priceEach BETWEEN 100 AND 200
  AND orderNumber IN (10100, 10101, 10102, 10103, 10105, 10110)
ORDER BY orderNumber;


-- תרגיל 6
SELECT DISTINCT employeeNumber
FROM employees
WHERE firstName LIKE 'An%';


-- תרגיל 7
SELECT *
FROM orders
WHERE customerNumber IN (
    SELECT DISTINCT customerNumber
    FROM customers
    WHERE contactFirstName LIKE 'A%'
);
