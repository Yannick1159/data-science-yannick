SELECT
    o.order_number,
    o.created_at AS order_date,
    c.customer_number,
    c.email AS customer_email,
    oa.street AS address_street,
    oa.zipcode AS address_zipcode,
    oa.city AS address_city,
    co.iso AS address_country_name,
    oli.label AS product_name,
    JSON_EXTRACT(oli.price, '$.quantity') AS product_quantity,
    JSON_EXTRACT(oli.price, '$.unitPrice') AS product_unit_price,
    JSON_EXTRACT(oli.price, '$.totalPrice') AS product_total_price
FROM
    `order` o
        LEFT JOIN
    order_customer c ON o.id = c.order_id
        LEFT JOIN
    order_address oa ON o.id = oa.order_id
        LEFT JOIN
    order_line_item oli ON o.id = oli.order_id
        LEFT JOIN
    country co ON oa.country_id = co.id
WHERE
    o.created_at >= '2024-01-01' AND o.created_at < '2024-04-01'
ORDER BY o.created_at;
