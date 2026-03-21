CREATE OR REPLACE PACKAGE pkg_orders AS
    -- Регистрация процедуры создания заказа
    PROCEDURE create_order(p_customer_id IN NUMBER, p_product_id IN NUMBER, p_qty IN NUMBER);
    
    -- РЕГИСТРАЦИЯ нашей новой процедуры (БЕЗ ЭТОГО БУДЕТ ОШИБКА)
    PROCEDURE close_old_orders; 
END pkg_orders;
/


CREATE OR REPLACE PACKAGE BODY pkg_orders AS

    -- Код старой процедуры create_order должен быть тут (просто скопируй его)
    PROCEDURE create_order(p_customer_id IN NUMBER, p_product_id IN NUMBER, p_qty IN NUMBER) IS
    BEGIN
        NULL; -- Здесь твой старый код из предыдущих шагов
    END create_order;

    -- НАША НОВАЯ ПРОЦЕДУРА С BULK COLLECT:
    PROCEDURE close_old_orders IS
        TYPE t_order_ids IS TABLE OF orders.order_id%TYPE;
        v_ids t_order_ids;
    BEGIN
        -- Собираем ID заказов, которые висят больше недели в статусе NEW
        SELECT order_id 
        BULK COLLECT INTO v_ids
        FROM orders 
        WHERE status = 'NEW' AND order_date < SYSDATE - 7;

        IF v_ids.COUNT > 0 THEN
            FORALL i IN 1..v_ids.COUNT
                UPDATE orders 
                SET status = 'CANCELLED' 
                WHERE order_id = v_ids(i);
            
            DBMS_OUTPUT.PUT_LINE('Заказов отменено: ' || v_ids.COUNT);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Старых заказов не найдено.');
        END IF;
        
        COMMIT;
    END close_old_orders;

END pkg_orders;
/
