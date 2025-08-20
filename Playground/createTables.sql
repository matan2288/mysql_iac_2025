-- טבלת לקוחות
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Alice', 'Tel Aviv'),
(2, 'Bob', 'Jerusalem'),
(3, 'Charlie', 'Haifa');

-- טבלת הזמנות
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(101, 1, '2025-08-01'),
(102, 1, '2025-08-05'),
(103, 2, '2025-08-03');

-- טבלת פרטי הזמנה (מוצרים בהזמנה)
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_items VALUES
(1, 101, 'Laptop', 1, 3000.00),
(2, 101, 'Mouse', 2, 50.00),
(3, 102, 'Keyboard', 1, 200.00),
(4, 103, 'Monitor', 2, 800.00);
