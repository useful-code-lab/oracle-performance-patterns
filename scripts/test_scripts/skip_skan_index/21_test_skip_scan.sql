-- 1. Наполняем данными, чтобы индекс стал "выгодным" (если база пустая)
-- (Нужно минимум несколько сотен строк с разными статусами)

-- 2. Проверяем план выполнения (Explain Plan)
SET TIMING ON;
EXPLAIN PLAN FOR 
SELECT * FROM orders 
WHERE order_date > SYSDATE - 5; -- Мы НЕ указываем STATUS в WHERE

-- 3. Выводим план
SELECT * FROM TABLE(dbms_xplan.display);

-- ЧТО ИСКАТЬ: В колонке Operation должно быть "INDEX SKIP SCAN"
