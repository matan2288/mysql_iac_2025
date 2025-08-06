--* CREATE Exercise 1
  --Part 1
  CREATE TABLE items (
    itemCode VARCHAR(20) PRIMARY KEY,
    items description TEXT,
    retailCost DECIMAL(10, 2),
    supplier VARCHAR(100)
  );

--Part 2
  CREATE TABLE ProductionItems (
    productCode VARCHAR(20),
    itemCode VARCHAR(20),
    description TEXT,
    productionCost DECIMAL(10, 2),
    FOREIGN KEY (productCode) REFERENCES products(productCode),
    FOREIGN KEY (itemCode) REFERENCES items(itemCode)
  );

--* Exercise 2
  CREATE TABLE ProductionItems2 (
    productCode VARCHAR(255),
    itemCode VARCHAR(20),
    Description VARCHAR(255),
    productionCost INT,
    PRIMARY KEY (productCode, itemCode),
    FOREIGN KEY (itemCode) REFERENCES items(itemCode),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
  );

--* Exercise 3



--* Exercise 4
  -- Part 1
  CREATE VIEW customerOrders AS
  SELECT 
    orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber
      FROM orders;

  -- Part 2
  CREATE VIEW orderDetailsWithCustomer AS
    SELECT 
      od.*,
      o.customerNumber
        FROM orderdetails od
        JOIN orders o ON od.orderNumber = o.orderNumber;

  -- Part 3
  CREATE VIEW ordersBySalesRep AS
    SELECT 
      o.*,
      c.customerName,
      e.firstName AS salesRepFirstName,
      e.lastName AS salesRepLastName
        FROM orders o
        JOIN customers c ON o.customerNumber = c.customerNumber
        JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
        WHERE e.firstName = 'Leslie' AND e.lastName = 'Jennings';

--* Exercise 5
-- Part 1
create view sales_man as 
select *
from employees
where customerNumber = 363;

-- Part 2
create view customer_363_order_details as
select ord.customerNumber, od.*  from orders ord inner join  orderdetails od on ord.orderNumber = od.orderNumber 
where customerNumber = 363;

-- Part 3
CREATE VIEW sales_person AS 
SELECT o.*
FROM orders o JOIN customers c
ON o.customerNumber = c.customerNumber
              JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.employeeNumber = 1621;




--* Exercise 6

-- Part 1
SELECT * 
FROM employees 
WHERE firstName LIKE '%Nir%';

-- Part 2
INSERT INTO employees
VALUES (222222, 'Regev2', 'Nir2', '123456', 'regev.nir@iac.ac.il', '1', 1002, 'VP DB');


-- Part 3
INSERT INTO employees
VALUES 
(33333, 'Regev3', 'Nir3', '123456', 'regev.nir@iac.ac.il', '1', 1002, 'VP DB'),
(4444, 'Regev4', 'Nir4', '123456', 'regev.nir@iac.ac.il', '1', 1002, 'VP DB');

-- Part 4
INSERT INTO customers
VALUES 
(33333, 'Regev3', 'Nir3', '123456', 'regev.nir@iac.ac.il', '1', 1002, 'VP DB'),
(4444, 'Regev4', 'Nir4', '123456', 'regev.nir@iac.ac.il', '1', 1002, 'VP DB');

-- Part 5
UPDATE employees
JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
SET reportsTo = 1002
WHERE customers.creditLimit > 50000;



--* Exercise 7
-- Part 1
SET SQL_SAFE_UPDATES = 0; -- for disable update safe model

START TRANSACTION;

SET @emp1_manager := (SELECT reportsTo FROM employees WHERE employeeNumber = 1088);
SET @emp2_manager := (SELECT reportsTo FROM employees WHERE employeeNumber = 1076);

UPDATE employees SET reportsTo = @emp2_manager WHERE employeeNumber = 1088;
UPDATE employees SET reportsTo = @emp1_manager WHERE employeeNumber = 1076;

COMMIT;

-- Part 2


-- Part 3
START TRANSACTION;

-- שלב 1: מצא את מספר הלקוח עם הקרדיט הכי קטן
SET @min_credit_id := (
    SELECT customerNumber
    FROM customers
    WHERE creditLimit = (SELECT MIN(creditLimit) FROM customers)
);

-- שלב 2: חשב את ממוצע הקרדיט של כל הלקוחות
SET @avg_credit := (
    SELECT AVG(creditLimit)
    FROM customers
);

-- שלב 3: הוסף את הבונוס ללקוח עם הקרדיט הנמוך ביותר
UPDATE customers
SET creditLimit = creditLimit + @avg_credit
WHERE customerNumber = @min_credit_id;

-- שלב 4: הפחת 10% קרדיט לכל שאר הלקוחות
UPDATE customers
SET creditLimit = creditLimit * 0.9
WHERE customerNumber != @min_credit_id;

COMMIT;