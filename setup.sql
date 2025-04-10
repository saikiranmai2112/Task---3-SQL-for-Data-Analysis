
-- Create Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

-- Create Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Create Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderItems
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Data
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', '2023-01-10'),
(2, 'Bob', 'bob@example.com', '2023-02-12');

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Clothing');

INSERT INTO Products VALUES
(1, 'Smartphone', 699.99, 1),
(2, 'Laptop', 999.99, 1),
(3, 'Jeans', 49.99, 2);

INSERT INTO Orders VALUES
(1, 1, '2023-03-01'),
(2, 2, '2023-03-05');

INSERT INTO OrderItems VALUES
(1, 1, 1, 1),
(2, 1, 3, 2),
(3, 2, 2, 1);


-- Create an index to optimize join performance
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orderitems_order_id ON OrderItems(order_id);
CREATE INDEX idx_orderitems_product_id ON OrderItems(product_id);

-- Create a VIEW for total customer revenue
CREATE VIEW CustomerRevenue AS
SELECT 
    c.customer_id,
    c.name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name;
