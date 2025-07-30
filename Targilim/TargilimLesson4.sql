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
