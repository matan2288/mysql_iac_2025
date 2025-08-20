-- hello world

use classicmodels;

delimiter $$
create procedure my_proc()
begin
    select 'hello, world!';
end$$
delimiter ;

-- calling the procedure
call my_proc;

-- 1
delimiter $$
create procedure add_tax(in price decimal(10.2), out final_price decimal(10.2))
begin
	set final_price = price * 1.17; -- add 17% tax
end $$
delimiter ;

-- calling the procedure
set @result = 0;
call add_tax(100,@result);
select @result;

-- 2
delimiter $$
create procedure get_order_count(
	in in_customer_id  int,
    out out_order_count  int
)
begin
	select count(*)
    into out_order_count
    from orders
    where customernumber = in_customer_id;
end $$
delimiter ;

-- calling the procedure
set @order_count = 0;
call get_order_count(103,@order_count);
select @order_count as total_orders;

-- 3
use classicmodels;

delimiter $$
create procedure update_credit(
	in in_customer_id int,
	in in_th decimal(10,2),
    in in_increase_amount decimal(10,2)
)
begin
	declare total_payment decimal(10,2);
    
	select coalesce(sum(amount),0) into total_payment
    from payments
    where customernumber = in_customer_id;

    if total_payment > in_th then
		update customers
        set creditlimit = creditlimit + in_increase_amount
        where customernumber = in_customer_id;
        select concat ('amount of ' , in_increase_amount ,
						' added to customer  ',  in_customer_id) as message;
	else 
		select concat ('total_payment: ', total_payment,
						'.no credit limit changes were made') as message;
	end if;
end $$
delimiter ;

-- calling the procedure
call update_credit(103,200,300);

-- functions
-- 1
select
  c.customernumber,
  upper(concat(c.contactfirstname, ' ', c.contactlastname))        as fullname,
  lower(substring(c.country, 1, 3))                                 as country_code,
  replace(replace(trim(c.phone), ' ', ''), '-', '')                 as areaphone,
  o.firstorderyear
from customers c
left join (
  select customernumber, year(min(orderdate)) as firstorderyear
  from orders
  group by customernumber
) o
  on o.customernumber = c.customernumber
order by o.firstorderyear, fullname;

select
  c.customernumber,
  upper(concat(c.contactfirstname, ' ', c.contactlastname))        as fullname,
  lower(substring(c.country, 1, 3))                                 as country_code,
  substring(replace(replace(replace(replace(replace(trim(c.phone), ' ', ''), '-', ''), '+', ''), '(',''), ')','')
  ,1,3)               as areaphone,
  o.firstorderyear
from customers c
left outer join (
  select customernumber, year(min(orderdate)) as firstorderyear
  from orders
  group by customernumber
) o
  on o.customernumber = c.customernumber
order by o.firstorderyear, fullname;

-- 2
delimiter $$
create function total_payments(cust_id int)
returns decimal(10,2)
deterministic 
begin
    return (
        select coalesce(sum(amount), 0)
        from payments
        where customernumber = cust_id
    );
end$$
delimiter ;

select 
    total_payments(103) as totalpayments,
    creditlimit,
    total_payments(103) / creditlimit as utilization
from customers
where customernumber = 103;

select 
    c.customernumber,
    c.customername,
    total_payments(c.customernumber) as totalpayments,
    c.creditlimit,
    total_payments(c.customernumber) / c.creditlimit as utilization
from customers c
having totalpayments >= 5000
order by totalpayments desc;
