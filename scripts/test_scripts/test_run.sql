-- 1. Проверяем остатки до заказа
SELECT product_id, name, stock_quantity FROM products WHERE product_id = 1;

-- 2. Выполняем заказ
SET SERVEROUTPUT ON; -- Чтобы увидеть сообщение от DBMS_OUTPUT
BEGIN
    pkg_orders.create_order(
        p_customer_id => 1, 
        p_product_id  => 1, 
        p_qty         => 2
    );
END;
/

-- 3. Проверяем остатки после заказа
SELECT product_id, name, stock_quantity FROM products WHERE product_id = 1;

-- 4. Смотрим, что появилось в таблице заказов
SELECT * FROM orders WHERE customer_id = 1;
