-- Заполняем GTT через процедуру
BEGIN
    pkg_orders.pre_calculate_discount(1);
END;
/

-- Проверяем: данные на месте
SELECT * FROM temp_order_calc;

-- Фиксируем транзакцию (или просто пишем COMMIT)
COMMIT;

-- Проверяем снова: данные исчезли мгновенно
SELECT * FROM temp_order_calc;
