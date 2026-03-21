UPDATE products SET price = 95000 WHERE product_id = 1;
COMMIT;

-- И посмотри, как триггер сам заполнил историю:
SELECT * FROM price_history;