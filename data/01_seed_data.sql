-- Добавляем тестовых клиентов
INSERT INTO customers (first_name, last_name, email, preferences) 
VALUES ('Иван', 'Иванов', 'ivan@mail.com', '{"theme": "dark", "notify": true}');

INSERT INTO customers (first_name, last_name, email, preferences) 
VALUES ('Анна', 'Петрова', 'anna@mail.com', '{"theme": "light", "notify": false}');

-- Добавляем товары на склад
INSERT INTO products (name, sku, price, stock_quantity, category) 
VALUES ('iPhone 15', 'IPH15-BLK', 90000, 10, 'Electronics');

INSERT INTO products (name, sku, price, stock_quantity, category) 
VALUES ('MacBook Air M2', 'MBA-M2-S', 120000, 5, 'Laptops');

COMMIT;
