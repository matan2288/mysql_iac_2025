--? Lesson 4 - DDL, Data definition language

--* Create table {tablename} *-- 
  -- CREATE
    -- PRIMARY KEY > A primary key uniquely identifies each row in a table.
    CREATE TABLE book BookId varchar(10),
      BookTitle varchar(10),
      language varchar(10),
      primary key varchar(10);

--* FORGEIN KEY -> A foreign key is a column that links to the primary key of another table to enforce data relationships.
--* PRIMARY KEY ->
    CREATE TABLE ProductionItemsTest (
      productCode VARCHAR(255),
      itemCode VARCHAR(20),
      Description VARCHAR(255),
      productionCost INT,
      PRIMARY KEY (productCode, itemCode),
      FOREIGN KEY (itemCode) REFERENCES items(itemCode),
      FOREIGN KEY (productCode) REFERENCES products(productCode)
        --? (delete, update) Cascade, Set null, Set Default
        --ON DELETE CASCADE
        --ON UPDATE CASCADE
    );
  

--* Alter (add constraint)
ALTER TABLE ProductionItems
ADD CONSTRAINT fk_item
FOREIGN KEY (itemCode)
REFERENCES items(itemCode)
ON UPDATE CASCADE;

--* ENUM
CREATE TABLE orders_status (
  orderID INT PRIMARY KEY,
  status ENUM('Pending', 'Shipped', 'Cancelled')
);

--* VIEWS > a package query that a non technical user can use to access data
  -- Define the VIEW
  CREATE VIEW customerContacts AS
    SELECT 
      customerNumber,
      customerName,
      contactFirstName,
      contactLastName,
      phone
    FROM customers;

  -- Access the VIEW
  SELECT * FROM customerContacts;

--* Transactions - Commit/Rollback