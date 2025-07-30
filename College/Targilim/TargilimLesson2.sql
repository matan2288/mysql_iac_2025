-- מתן אלמליח 205625221

  --** תרגיל 1 **--

-- שאילתא 1
SELECT orderdetails.orderNumber, SUM(orderdetails.priceEach * orderdetails.quantityOrdered)
AS totalOrderAmount
FROM orderdetails
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productCode LIKE 'S%'
GROUP BY orderdetails.orderNumber;

-- שאילתא 2 --
SELECT orderNumber,
  SUM(priceEach * quantityOrdered) / SUM(quantityOrdered) AS avgPricePerItem
FROM orderdetails
GROUP BY orderNumber;



  --** תרגיל 2 **--

-- שאילתא 1
SELECT orderNumber, SUM(orderdetails.priceEach * orderdetails.quantityOrdered)
AS totalOrderAmount 
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productCode LIKE 'S%' and orderdetails.priceEach > 80.0
GROUP BY orderdetails.orderNumber
HAVING SUM(orderdetails.priceEach * orderdetails.quantityOrdered) > 200.0;

-- שאילתא 2
SELECT  orderNumber, SUM(priceEach * quantityOrdered) / COUNT(*) AS avgPricePerItem
FROM  orderdetails
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 300;

  --** תרגיל 3 **--

-- שאילתא 1
SELECT DISTINCT customerNumber
FROM orders
WHERE (
    SELECT SUM(quantityOrdered)
    FROM orderdetails
    WHERE orderdetails.orderNumber = orders.orderNumber
) > 10;


-- שאילתא 2
SELECT customers.customerNumber
FROM customers, orders, orderdetails
WHERE customers.customerNumber = orders.customerNumber
  AND orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerNumber
HAVING SUM(orderdetails.quantityOrdered) > 10;

  --** תרגיל 6 **--

-- שאילתא 1 (no join)
SELECT DISTINCT customerNumber
from orders, orderdetails
where orderdetails.orderNumber = orders.orderNumber and priceEach > 50;


-- שאילתא 2 inner join
SELECT DISTINCT customerNumber
from orders INNER JOIN orderdetails on orders.orderNumber = orderdetails.orderNumber
where priceEach > 50;

-- outer join

  --** תרגיל 7 **--

-- שאילתא 1
SELECT customers.customerNumber
FROM customers
LEFT OUTER JOIN orders ON orders.customerNumber = customers.customerNumber
WHERE orders.status = 'Shipped';

-- שאילתא 2 inner join
SELECT 
    emp.employeeNumber AS emp_number, 
    CONCAT(emp.firstName, ' ', emp.lastName) AS employee_name,
    manager.employeeNumber AS manager_number, 
    CONCAT(manager.firstName, ' ', manager.lastName) AS manager_name
FROM 
    employees emp 
LEFT OUTER JOIN 
    employees manager 
ON 
    emp.reportsTo = manager.employeeNumber;


-- 
select emp.employeeNumber emp_number,  manager.employeeNumber manager_number
from employees emp left outer join employees manager 
on emp.reportsTo = manager.employeeNumber;