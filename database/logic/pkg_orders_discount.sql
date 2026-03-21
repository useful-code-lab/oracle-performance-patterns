-- В спецификацию (AS) добавь:
-- PROCEDURE pre_calculate_discount(p_cust_id IN NUMBER);

-- В тело (BODY) добавь:
PROCEDURE pre_calculate_discount(p_cust_id IN NUMBER) IS
BEGIN
    -- 1. Очищаем черновик на всякий случай
    DELETE FROM temp_order_calc;

    -- 2. Заполняем временную таблицу данными из корзины (предположим, они там есть)
    -- Или просто имитируем расчет для товаров:
    INSERT INTO temp_order_calc (product_id, quantity, price, discount)
    SELECT product_id, 1, price, 
           CASE WHEN price > 50000 THEN price * 0.1 ELSE 0 END -- Скидка 10% на дорогие товары
    FROM products;

    -- Данные теперь в RAM, их можно быстро анализировать в рамках сессии
    DBMS_OUTPUT.PUT_LINE('Расчет скидок во временной таблице завершен.');
END;
