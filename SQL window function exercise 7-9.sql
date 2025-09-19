--EXERCISE 7

WITH ranked_orders AS (
    SELECT 
        order_id,
        total_amount,
        order_date,
        DENSE_RANK() OVER (
            ORDER BY total_amount DESC, order_date ASC
        ) AS rank
    FROM orders
)
SELECT 
    rank,
    order_id,
    total_amount
FROM ranked_orders
WHERE rank <= 3
ORDER BY rank, order_date;

--EXERCISE 8

SELECT 
    order_id,
    customer_id,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_value,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS delta
FROM orders
ORDER BY customer_id, order_date;

--EXERCISE 9

SELECT 
    c.customer_id,
    c.full_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS running_total
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;
