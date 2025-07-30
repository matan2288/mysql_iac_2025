-- Aggregation > COUNT()/SUM()/AVG()/MIN()/MAX() & Group by & HAVING
-- 

--  ** Aggregation  ** --

-- AVG()
SELECT AVG(buyPrice)  
FROM products
WHERE productLine = 'Classic Cars';

-- COUNT()
SELECT COUNT(*)  
FROM products
WHERE productLine = 'Motorcycles';

SELECT COUNT(*)  
FROM products
WHERE productLine = 'Motorcycles';

-- SUM()
-- Purchase (product, date, price, quantity);

-- SELECT SUM(price * quantity)  
-- FROM Purchase


-- SELECT SUM(price * quantity)
-- FROM Purchase
-- Where product = 'bagel'


-- select * from products;

-- Targil 1
SELECT 
    od.orderNumber,
    SUM(od.priceEach * od.quantityOrdered) AS totalOrderAmount
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
WHERE 
    p.productCode LIKE 'S%'
GROUP BY 
    od.orderNumber;