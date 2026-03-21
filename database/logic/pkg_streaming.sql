-- Сначала создаем типы данных для стрима
CREATE OR REPLACE TYPE t_order_row AS OBJECT (
    id NUMBER, 
    amt NUMBER
);
/
CREATE OR REPLACE TYPE t_order_table AS TABLE OF t_order_row;
/

-- Создаем саму функцию
CREATE OR REPLACE FUNCTION get_orders_stream 
RETURN t_order_table PIPELINED IS
BEGIN
    FOR r IN (SELECT order_id, total_amount FROM orders) LOOP
        -- "Выплевываем" строку в поток немедленно
        PIPE ROW(t_order_row(r.order_id, r.total_amount));
    END LOOP;
    RETURN;
END;
/
