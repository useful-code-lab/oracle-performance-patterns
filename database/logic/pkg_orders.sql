CREATE OR REPLACE PACKAGE pkg_orders AS
    -- Процедура для создания заказа
    PROCEDURE create_order(
        p_customer_id IN customers.customer_id%TYPE,
        p_product_id  IN products.product_id%TYPE,
        p_qty         IN NUMBER
    );
END pkg_orders;
/

CREATE OR REPLACE PACKAGE BODY pkg_orders AS
    PROCEDURE create_order(
        p_customer_id IN customers.customer_id%TYPE,
        p_product_id  IN products.product_id%TYPE,
        p_qty         IN NUMBER
    ) IS
        v_price     products.price%TYPE;
        v_stock     products.stock_quantity%TYPE;
        v_order_id  orders.order_id%TYPE;
    BEGIN
        -- 1. Проверяем остатки на складе
        SELECT price, stock_quantity 
          INTO v_price, v_stock 
          FROM products 
         WHERE product_id = p_product_id
           FOR UPDATE; -- Блокируем строку от изменений другими транзакциями

        IF v_stock < p_qty THEN
            RAISE_APPLICATION_ERROR(-20001, 'Недостаточно товара на складе!');
        END IF;

        -- 2. Создаем «голову» заказа
        INSERT INTO orders (customer_id, status, total_amount)
        VALUES (p_customer_id, 'NEW', v_price * p_qty)
        RETURNING order_id INTO v_order_id;

        -- 3. Добавляем позицию в заказ
        INSERT INTO order_items (order_id, product_id, quantity, unit_price)
        VALUES (v_order_id, p_product_id, p_qty, v_price);

        -- 4. Уменьшаем остаток на складе
        UPDATE products 
           SET stock_quantity = stock_quantity - p_qty
         WHERE product_id = p_product_id;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Заказ #' || v_order_id || ' успешно создан.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END create_order;
END pkg_orders;
/
