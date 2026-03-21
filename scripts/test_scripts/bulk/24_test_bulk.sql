-- 1. Создаем тестовый заказ
INSERT INTO orders (customer_id, status, order_date, total_amount) 
VALUES (1, 'NEW', SYSDATE - 10, 500);
COMMIT;

-- 2. Запускаем процедуру
SET SERVEROUTPUT ON;
BEGIN
    pkg_orders.close_old_orders;
END;
/
