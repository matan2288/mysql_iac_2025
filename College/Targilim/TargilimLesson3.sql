-- מתן אלמליח 205625221

use classicmodels;

-- 1

SELECT orderNumber,SUM(quantityOrdered * priceEach ) AS TotalSales
FROM orderdetails
WHERE productCode like 'S%'
GROUP BY orderNumber;

SELECT orderNumber, 1.0*SUM(priceEach * quantityOrdered)*1.0 / count(*) AS avgPricePerItem
FROM orderdetails
GROUP BY orderNumber;

-- 2

SELECT orderNumber,SUM(quantityOrdered * priceEach ) AS TotalSales
FROM orderdetails
WHERE productCode like 'S%' AND priceEach > 80
GROUP BY orderNumber
HAVING TotalSales > 200;

SELECT 	orderNumber,SUM(priceEach * quantityOrdered) / count(*) AS avgPricePerItem
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 300;

-- 3

SELECT distinct customerName
FROM  customers
WHERE (
	SELECT distinct customerNumber
	FROM orders
	WHERE customers.customerNumber = orders.customerNumber AND (
		SELECT sum(quantityOrdered)
		FROM orderdetails
		WHERE orderdetails.orderNumber = orders.orderNumber) > 10 );


-- 4
SELECT DISTINCT c.customerName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE od.priceEach > 50;

SELECT DISTINCT c.customerName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE NOT EXISTS (
  SELECT 1
  FROM orderdetails od
  WHERE od.orderNumber = o.orderNumber
    AND od.priceEach <= 50
);


-- 5
SELECT COUNT(*) AS count_starts_with_Ch
FROM orders
WHERE comments LIKE 'Ch%';

SELECT COUNT(*) AS count_not_starting_with_Ch
FROM orders
WHERE comments IS NOT NULL AND comments NOT LIKE 'Ch%';

-- 6 
SELECT distinct customerNumber
from orders, orderdetails
WHERE orderdetails.orderNumber = orders.orderNumber 
	and priceEach > 50;

SELECT distinct customerNumber
FROM orders
	INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
    where priceEach > 50;

-- 7

SELECT distinct customers.customerNumber
FROM customers
LEFT OUTER JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orders.status = "Shipped" OR orders.status is null;

SELECT emp.employeeNumber, emp.firstName 'employee name', man.employeeNumber,man.firstName 'manager name'
FROM employees emp
LEFT OUTER JOIN employees man ON emp.reportsTo = man.employeeNumber;


-- 8

SELECT amount,
		SUM(amount) OVER (ORDER BY paymentDate) AS total_daily
from payments;

SELECT paymentDate,amount,customerNumber,
		SUM(amount) OVER
        (PARTITION BY customerNumber
		 ORDER BY paymentDate)  AS total_byCustomer_daily
from payments;

SELECT customerNumber,
		amount,
		avg(amount) OVER (PARTITION BY customerNumber) as avg_by_customer,
        amount/avg(amount) OVER (PARTITION BY customerNumber) as proportions
from payments;

SELECT paymentDate,
	   customerNumber,
       amount,
       LAG(amount,1) OVER (PARTITION BY customerNumber ORDER BY paymentDate) AS lag_1_amount
from payments;

SELECT paymentDate,
	   customerNumber,
       amount,
       amount/LAG(amount,1) OVER (PARTITION BY customerNumber ORDER BY paymentDate) AS lag_1_amount
from payments;