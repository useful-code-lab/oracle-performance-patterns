CREATE OR REPLACE TRIGGER trg_orders_soft_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    -- 1. Вместо удаления обновляем статус в текущей строке
    -- Но так как DELETE уже запущен, нам нужно сделать UPDATE в автономной транзакции
    -- или просто пометить запись. В нашем случае мы меняем логику:
    
    UPDATE orders 
    SET status = 'CANCELLED' -- Или 'DELETED', если добавил в CHECK
    WHERE order_id = :OLD.order_id;

    -- 2. Генерируем ошибку, чтобы САМ DELETE не прошел
    RAISE_APPLICATION_ERROR(-20005, 'Удаление запрещено. Заказ переведен в статус CANCELLED.');
END;
/
