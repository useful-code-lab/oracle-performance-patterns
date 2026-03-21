-- 1. СПЕЦИФИКАЦИЯ (Header) - Публичный интерфейс
CREATE OR REPLACE PACKAGE pkg_orders AS
    -- Регистрация заказа
    PROCEDURE create_order(p_customer_id IN NUMBER, p_product_id IN NUMBER, p_qty IN NUMBER);
    
    -- Массовая отмена старых заказов (Bulk Collect)
    PROCEDURE close_old_orders;
    
    -- Автономное логирование (Доступно снаружи)
    PROCEDURE log_event(p_proc IN VARCHAR2, p_type IN VARCHAR2, p_msg IN VARCHAR2);
END pkg_orders;
/

-- 2. ТЕЛО ПАКЕТА (Body) - Внутренняя реализация
CREATE OR REPLACE PACKAGE BODY pkg_orders AS

    -- Процедура создания заказа (Логика из Шага 2)
    PROCEDURE create_order(p_customer_id IN NUMBER, p_product_id IN NUMBER, p_qty IN NUMBER) IS
        v_price products.price%TYPE;
    BEGIN
        SELECT price INTO v_price FROM products WHERE product_id = p_product_id FOR UPDATE;
        
        INSERT INTO orders (customer_id, status, total_amount)
        VALUES (p_customer_id, 'NEW', v_price * p_qty);
        
        log_event('CREATE_ORDER', 'INFO', 'Заказ создан для клиента ' || p_customer_id);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            log_event('CREATE_ORDER', 'ERROR', SQLERRM);
            RAISE;
    END create_order;

    -- Массовая отмена (Логика из Шага 27)
    PROCEDURE close_old_orders IS
        TYPE t_order_ids IS TABLE OF orders.order_id%TYPE;
        v_ids t_order_ids;
    BEGIN
        SELECT order_id BULK COLLECT INTO v_ids
        FROM orders WHERE status = 'NEW' AND order_date < SYSDATE - 7;

        IF v_ids.COUNT > 0 THEN
            FORALL i IN 1..v_ids.COUNT
                UPDATE orders SET status = 'CANCELLED' WHERE order_id = v_ids(i);
            log_event('CLOSE_OLD', 'INFO', 'Отменено заказов: ' || v_ids.COUNT);
        END IF;
        COMMIT;
    END close_old_orders;

    -- Автономное логирование (Логика из Шага 30)
    PROCEDURE log_event(p_proc IN VARCHAR2, p_type IN VARCHAR2, p_msg IN VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO app_logs (proc_name, log_type, message)
        VALUES (p_proc, p_type, p_msg);
        COMMIT;
    END log_event;

END pkg_orders;
/
