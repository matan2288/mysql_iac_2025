--* delete, truncate, drop *--

-- drop, deletes the whole table
-- truncate, empties the whole table
-- delete

use classicmodels;
select * from employees;
-- 1.

create table inserted_from_other_table as 
select lastName, firstName
from employees

delete from employees where lastName = 'Murphy';
  
-- 2.
create table inserted_from_other_table2 as 
select lastName, firstName
from employees

delete from inserted_from_other_table2
where lastName in ('Firrelli', 'Murphy', 'Patterson');


-- 3.

Create table inserted_from_other_table as 
select lastName, firstName
from employees

delete from inserted_from_other_table

select * from inserted_from_other_table;

-- 4.
Create table inserted_from_other_table_to_trunctuate as 
select lastName, firstName
from employees

truncate table inserted_from_other_table_to_trunctuate;
select * from inserted_from_other_table_to_trunctuate;

-- 5.
Create table inserted_from_other_table_to_drop as 
select lastName, firstName
from employees

drop table inserted_from_other_table_to_drop;
select * from inserted_from_other_table_to_drop;

