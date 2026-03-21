-- Заказ из прошлого года
INSERT INTO orders_hist (customer_id, order_date, status, total_amount) 
VALUES (1, TO_DATE('01-06-2023', 'DD-MM-YYYY'), 'PAID', 5000);

-- Заказ из этого года
INSERT INTO orders_hist (customer_id, order_date, status, total_amount) 
VALUES (1, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 'NEW', 12000);

COMMIT;

-- Теперь обратимся напрямую к конкретной секции:
SELECT * FROM orders_hist PARTITION (p_2023); -- Должен быть 1 заказ
SELECT * FROM orders_hist PARTITION (p_2024); -- Должен быть 1 заказ
