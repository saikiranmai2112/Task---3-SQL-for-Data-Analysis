
-- Revenue Per User
SELECT 
    c.customer_id,
    c.name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name;

-- Product Category Performance
SELECT 
    cat.category_name,
    SUM(p.price * oi.quantity) AS total_sales
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name
ORDER BY total_sales DESC;

-- Average Order Value
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(p.price * oi.quantity) AS order_total
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY o.order_id
) AS order_totals;

-- Monthly Sales Trend
SELECT 
    strftime('%Y-%m', o.order_date) AS month,
    SUM(p.price * oi.quantity) AS monthly_sales
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;
