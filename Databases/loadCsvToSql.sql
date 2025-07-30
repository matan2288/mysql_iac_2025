CREATE TABLE sneakers_table (
  Date DATE,
  Product_Name VARCHAR(100),
  Product_Type VARCHAR(50),
  Brand VARCHAR(50),
  Gender VARCHAR(20),
  Category VARCHAR(50),
  Country VARCHAR(50),
  Quantity INT,
  Unit_Price DECIMAL(10,2),
  Amount DECIMAL(10,2),
  Payment_Mode VARCHAR(50)
);


LOAD DATA LOCAL INFILE '/Users/user/Desktop/Code/MySQL/IACRamatGanDBs/Databases/sneakers_streetwear_sales_data.csv'
INTO TABLE sneakers_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE DATABASE sneakers;
USE sneakers;
