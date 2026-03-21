CREATE OR REPLACE TRIGGER trg_orders_status_audit
BEFORE UPDATE OF status ON orders
FOR EACH ROW
BEGIN
    -- Выводим в лог (или можно писать в спец. таблицу аудита)
    DBMS_OUTPUT.PUT_LINE('Статус заказа #' || :OLD.order_id || 
                         ' изменен с ' || :OLD.status || 
                         ' на ' || :NEW.status);
END;
/
