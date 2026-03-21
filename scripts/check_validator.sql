-- Пытаемся продать iPhone (95 000р) за 5 000р
BEGIN
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (1, 1, 1, 5000);
END;
/
