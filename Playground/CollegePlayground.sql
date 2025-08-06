-- מתן אלמליח 205625221

  --** תרגיל 1 **--


-- שאילתא 1
SELECT orderNumber, SUM(priceEach * quantityOrdered)
AS totalOrderAmount
FROM orderdetails
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productCode LIKE 'S%'
GROUP BY orderdetails.orderNumber;




-- שאילתא 2 --
select orderNumber, sum(priceEach * quantityOrdered) / sum(quantityOrdered)
as avgProductPricePerOrder
from orderdetails
group by orderNumber;

  --** תרגיל 2 **--

-- שאילתא 1
select orderNumber, 
sum(priceEach * quantityOrdered) as totalPricePerOrder,
sum(quantityOrdered) as totalItemsPerOrder
from orderdetails
where productCode like 'S%'
and priceEach > 80
group by orderNumber
having totalItemsPerOrder > 200 ORDER BY totalItemsPerOrder DESC;

-- שאילתא 2
select orderNumber, 
sum(priceEach * quantityOrdered) as totalPricePerOrder,
sum(quantityOrdered) as totalItemsPerOrder,
sum(priceEach * quantityOrdered) / sum(quantityOrdered) as avgProductPricePerOrder
from orderdetails
group by orderNumber
having totalItemsPerOrder > 300 ORDER BY totalItemsPerOrder desc;

select * from orders;
  --** תרגיל 3 **--

-- שאילתא 1
select distinct customerNumber
from orders
where orderNumber in (
    select orderNumber
    from orderdetails
    group by orderNumber
    having sum(quantityOrdered) > 10
  )


-- שאילתא 2
select customerNumber, sum(quantityOrdered) as totalQuantity
from orderdetails
inner join orders on orders.orderNumber = orderdetails.orderNumber
group by customerNumber
having sum(quantityOrdered) > 10;

  --** תרגיל 4 **--

-- שאילתא 1
select customerNumber, priceEach
from orderdetails
inner join orders on orders.orderNumber = orderdetails.orderNumber
where priceEach > 50;

-- שאילתא 2
select customerNumber, status, comments
from orders
where orderNumber in (
  select orderNumber
  from orderdetails
  group by orderNumber
  having min(priceEach) > 50
);

  --** תרגיל 5 **--

-- שאילתא 1
select comments, COUNT(*) AS itemCount
from orderdetails
join orders on orders.orderNumber = orderDetails.orderNumber
where comments like 'Ch%'
GROUP BY comments;

-- שאילתא 2
select sum (notCh) as sumNotCh
from (
    select count(*) as notCh
    from orderdetails
      join orders on orders.orderNumber = orderdetails.orderNumber
    where comments not like 'Ch%'
    group by comments
  ) as subNotCh;
  

-- שאילתא 3
select COUNT(*) AS totalRows
from orderdetails;

-- שאילתא 4
select count(*) nullComments
from orders
where comments is null;

  --** תרגיל 6 **--

-- שאילתא 1 (no join)
select distinct customerNumber
from orders,
  orderdetails
where priceEach > 50;

-- שאילתא 2 inner join
select distinct customerNumber
from orders
  left outer join orderdetails on orderdetails.orderNumber = orders.orderNumber
where priceEach > 50;

-- outer join

  --** תרגיל 7 **--

-- שאילתא 1

-- שאילתא 2 inner join



select orderNumber
from orderdetails, orders
group by orderNumber