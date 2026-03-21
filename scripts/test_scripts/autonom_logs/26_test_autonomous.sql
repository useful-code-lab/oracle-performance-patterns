BEGIN
    -- 1. Пишем в лог, что начали операцию
    pkg_orders.log_event('TEST_RUN', 'INFO', 'Начало транзакции');

    -- 2. Делаем какое-то действие (например, создаем заказ)
    INSERT INTO orders (customer_id, status, total_amount) VALUES (1, 'NEW', 777);

    -- 3. ИМИТИРУЕМ КРАХ И ОТМЕНУ
    ROLLBACK; 
    
    -- 4. Пишем в лог, что произошел откат (тоже выживет!)
    pkg_orders.log_event('TEST_RUN', 'ERROR', 'Транзакция отменена пользователем');
END;
/

-- ПРОВЕРКА:
SELECT * FROM orders WHERE total_amount = 777; -- РЕЗУЛЬТАТ: ПУСТО (заказ откатился)
SELECT * FROM app_logs;                        -- РЕЗУЛЬТАТ: 2 ЗАПИСИ (логи сохранились!)
