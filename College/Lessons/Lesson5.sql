--? Lesson 5 - DDL, Data definition language


-- שיעור 5

--* Insert *-- 

insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
values (11111, 'Elmaliach', 'Matan', '123456', 'test@email.com', 1, 1002, 'mechanic');

-- insert multiple values
insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
values 
(11341, 'Elmaliach', 'Matan', '123456', 'test@email.com', 1, 1002, 'mechanic'),
(11144, 'Test', 'Mata', '123456', 'test123@email.com', 2, 1002, 'diver');


-- הכנסת נתונים מטבלה אחרת

--* Update *-- 
update employees
set employeeNumber = 11111, lastName = 'Elmaliach', firstName = 'MatanUpdated', extension = '123456', email = 'test312231@email.com', officeCode = 1, reportsTo = 1002, jobTitle = 'pilot'
where employeeNumber = 11111;



--* Update with join *-- 
select * from employees
where employeeNumber = 11111

--* Transactions *-- 
