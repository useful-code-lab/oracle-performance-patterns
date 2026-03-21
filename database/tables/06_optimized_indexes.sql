-- 1. Узнаем имя индекса, который обслуживает первичный ключ
SELECT index_name 
FROM user_constraints 
WHERE table_name = 'ORDERS' AND constraint_type = 'P';

-- 2. Перестраиваем его в REVERSE (замени SYS_C... на имя из первого запроса)
ALTER INDEX имя_твоего_индекса REBUILD REVERSE;
