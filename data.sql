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
    JSON_EXTRACT(oli.price, '$.totalPrice') AS product_total_price,

    -- Dynamische categorieën
    (
        SELECT JSON_ARRAYAGG(ct.name)
        FROM category c2
        JOIN product_stream ps ON ps.id = c2.product_stream_id
        JOIN product_stream_mapping psm ON psm.product_stream_id = ps.id
        JOIN category_translation ct ON ct.category_id = c2.id
        WHERE psm.product_id = oli.product_id
          AND ct.language_id = UNHEX('2fbb5fe2e29a4d70aa5854ce7ce3e20b')
    ) AS category_names

FROM
    `order` o
LEFT JOIN order_customer c ON o.id = c.order_id
LEFT JOIN order_address oa ON o.id = oa.order_id
LEFT JOIN order_line_item oli ON o.id = oli.order_id
LEFT JOIN country co ON oa.country_id = co.id

WHERE
    o.created_at >= '2024-01-01'
    AND o.created_at < '2024-12-31';