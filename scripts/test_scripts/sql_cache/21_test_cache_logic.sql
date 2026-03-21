-- Сценарий 1: Запрос с датой (Кэш НЕ создастся, так как SYSDATE меняется)
EXPLAIN PLAN FOR
SELECT /*+ RESULT_CACHE */ * FROM orders WHERE order_date < SYSDATE;

SELECT * FROM TABLE(dbms_xplan.display);
-- В плане НЕ БУДЕТ строки "ResultCache"

-- Сценарий 2: Чистый запрос по константе (Кэш ЗАРАБОТАЕТ)
EXPLAIN PLAN FOR
SELECT /*+ RESULT_CACHE */ count(*) FROM products WHERE category = 'Electronics';

SELECT * FROM TABLE(dbms_xplan.display);
-- В плане ПОЯВИТСЯ строка "ResultCache"
