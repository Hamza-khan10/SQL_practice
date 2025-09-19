--EXERCISE 1

SELECT 
    cl.clothing_name AS clothes,
    co.color_name AS color,
    cu.last_name,
    cu.first_name
FROM clothing.clothing_order o
INNER JOIN clothing.clothing cl 
ON o.clothing_id = cl.clothing_id
INNER JOIN clothing.color co 
ON cl.color_id = co.color_id
INNER JOIN clothing.customer cu 
ON o.customer_id = cu.customer_id
WHERE cl.color_id = cu.favorite_color_id
ORDER BY co.color_name ASC;

--EXERCISE 2

SELECT 
    cu.last_name,
    cu.first_name,
    co.color_name AS favorite_color
FROM clothing.customer cu
INNER JOIN clothing.color co 
    ON cu.favorite_color_id = co.color_id
WHERE NOT EXISTS (
    SELECT 1
    FROM clothing.clothing_order o
    WHERE o.customer_id = cu.customer_id
);

--EXERCISE 3

SELECT 
    parent.category_name AS category,
    child.category_name AS subcategory
FROM clothing.category parent
LEFT JOIN clothing.category child
ON parent.category_id = child.parent_id
WHERE parent.parent_id IS NULL;






