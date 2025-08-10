select distinct customerNumber
from orders
where orderNumber in (
  select orderNumber
  from orderdetails
  group by orderNumber
  having sum(quantityOrdered) > 10
)

select distinct customerNumber
from orderdetails
inner join orders on orders.orderNumber =  orderdetails.orderNumber
group by customerNumber
having sum(quantityOrdered) > 10;



select distinct customerNumber
from orders
where orderNumber in  (
  select orderNumber
  from orderdetails
  group by orderNumber
  having min(priceEach) > 50
)


select distinct customerNumber, min(priceEach) as min_price
from orders
inner join orderdetails on orderdetails.orderNumber = orders.orderNumber
group by customerNumber
having min_price > 50;

select distinct customerNumber
from orders
inner join orderdetails on orderdetails.orderNumber = orders.orderNumber
where priceEach > 50
group by customerNumber;




select count(orderNumber) as orders_matching_condition
from orders
where comments like 'Ch%';


select count(orderNumber) as orders_matching_condition
from orders
where comments not like 'Ch%';


select count(orderNumber) as mispar_shurot
from orders;


select count(*) as count_matching_condition
from orders
where comments is null;



SELECT DISTINCT c.customerNumber, c.customerName
FROM customers AS c
LEFT JOIN orders AS o
  ON o.customerNumber = c.customerNumber
WHERE o.status = 'Shipped' OR o.orderNumber IS NULL;


select distinct a.employeeNumber, a.reportsTo
from employees as a
left join employees as b on a.employeeNumber = b.reportsTo




select paymentDate, sum(amount) over (order by paymentDate) as running_total
from payments;

select customerNumber, paymentDate,
  sum(amount) over (
    partition by customerNumber
    order by paymentDate
    ) as running_total
from payments;


select customerNumber,
amount,
avg(amount) over ( partition by customerNumber ) as avg_amount_per_order,
amount / avg(amount) over ( partition by customerNumber ) as relative_price_from_avg
from payments;


select * from payments
