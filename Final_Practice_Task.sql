SELECT ship_name, shipped_date
FROM Orders
ORDER BY shipped_date DESC
LIMIT 5;
SELECT
    p.product_name AS Product,
    c.category_name AS Category,
    ROUND(p.unit_price, 2) AS Price
FROM
    Products AS p
        JOIN
    Categories AS c ON p.category_id = c.category_id
WHERE
        p.units_in_stock = 0
ORDER BY
    p.unit_price DESC
LIMIT 3;
SELECT
    s.company_name AS Company
FROM
    Suppliers AS s
        JOIN
    Products AS p ON s.supplier_id = p.supplier_id
GROUP BY
    s.company_name
HAVING
        COUNT(p.product_id) > 3
ORDER BY
    s.company_name DESC;
WITH OrderTotals AS (
    SELECT
        o.order_id,
        c.company_name,
        COUNT(od.product_id) AS ProductCount,
        ROUND(SUM(od.Quantity * od.unit_price), 2) AS OrderTotal
    FROM
        Orders AS o
            JOIN
        Customers AS c ON o.customer_id = c.customer_id
            JOIN
        order_details AS od ON o.order_id = od.order_id
    GROUP BY
        o.order_id, c.company_name
)

SELECT
    ot.order_id,
    ot.company_name,
    ot.ProductCount,
    ot.OrderTotal
FROM
    OrderTotals AS ot
ORDER BY
    ot.OrderTotal DESC
LIMIT 5;