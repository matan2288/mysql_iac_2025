-- מתן אלמליח 205625221

-- * Lesson 1 *--

--? Exercise 1
-- 1
select customerNumber, creditLimit from customers;

-- 2
select * from products;

-- 3
select productCode, quantityOrdered, priceEach from orderdetails;

-- 4
SELECT productCode AS PC, 
       quantityOrdered, 
       quantityOrdered * priceEach AS totalPrice
FROM orderdetails;

--? Exercise 2
-- 1
select * from customers where creditLimit > 50000;

-- 2
select * from productlines where productLine = "Ships";

-- 3
select orderNumber, quantityOrdered, priceEach
from orderdetails
where quantityOrdered > 30 and priceEach > 100;

-- 4
select orderNumber, quantityOrdered, priceEach
from orderdetails
where quantityOrdered < 30 or priceEach > 100;

--? Exercise 3
-- 1
select customerNumber, creditLimit
from customers
where creditLimit > 50000
order by customerNumber;

-- 2
select orderNumber, quantityOrdered, priceEach
from orderdetails
where quantityOrdered > 30 and priceEach > 10
order by priceEach desc;

--? Exercise 4
-- 1
select distinct orderNumber
from orderdetails
where quantityOrdered > 30 and priceEach > 10
order by orderNumber desc;

--? Exercise 5
-- 1
select DISTINCT orderNumber
from orderdetails
where quantityOrdered > 30 and priceEach between 100 and 200
and orderNumber between 10100 and 10110
order by orderNumber;

--? Exercise 6
-- 1
select distinct employeeNumber
from employees
where firstName like 'An%';

--? Exercise 7
-- 1
select * from orders
where customerNumber in(
    select customerNumber
    from customers
    where contactFirstName
    like 'A%');

