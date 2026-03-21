-- Обращаемся к функции как к таблице
SELECT * FROM TABLE(get_orders_stream());
