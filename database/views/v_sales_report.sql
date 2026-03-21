CREATE OR REPLACE VIEW v_sales_report AS
SELECT 
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_full_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total, -- Сумма по позиции
    o.order_date,
    o.status
FROM orders o
JOIN customers   c  ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id;
