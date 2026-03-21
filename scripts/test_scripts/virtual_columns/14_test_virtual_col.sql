-- 1. Проверяем, что колонка появилась и считает данные
SELECT order_id, total_amount, tax_amount FROM orders;

-- 2. Проверяем, что индекс работает (Index Range Scan)
EXPLAIN PLAN FOR 
SELECT * FROM orders WHERE tax_amount > 1000;

SELECT * FROM TABLE(dbms_xplan.display);
