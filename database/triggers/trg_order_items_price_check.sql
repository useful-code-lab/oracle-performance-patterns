CREATE OR REPLACE TRIGGER trg_check_price_integrity
BEFORE INSERT OR UPDATE ON order_items
FOR EACH ROW
DECLARE
    v_base_price products.price%TYPE;
BEGIN
    -- Получаем актуальную цену товара из справочника
    SELECT price INTO v_base_price 
    FROM products 
    WHERE product_id = :NEW.product_id;

    -- Если цена в заказе ниже базовой более чем на 50% — блокируем операцию
    IF :NEW.unit_price < (v_base_price * 0.5) THEN
        RAISE_APPLICATION_ERROR(-20003, 
            'Критическая ошибка: Цена в заказе (' || :NEW.unit_price || 
            ') слишком низкая относительно базовой (' || v_base_price || '). Проверьте прайс-лист!');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Проверка цены для товара ID ' || :NEW.product_id || ' пройдена успешно.');
END;
/
