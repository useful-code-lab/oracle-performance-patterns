CREATE OR REPLACE TRIGGER trg_product_price_audit
AFTER UPDATE OF price ON products
FOR EACH ROW
BEGIN
    -- Записываем лог только если цена действительно изменилась
    IF :OLD.price <> :NEW.price THEN
        INSERT INTO price_history (
            product_id, 
            old_price, 
            new_price, 
            changed_by
        ) VALUES (
            :OLD.product_id, 
            :OLD.price, 
            :NEW.price, 
            USER -- Системная переменная Oracle (кто выполнил UPDATE)
        );
    END IF;
END;
/
