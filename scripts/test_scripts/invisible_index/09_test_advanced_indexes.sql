EXPLAIN PLAN FOR SELECT * FROM orders WHERE customer_id = 1 AND status = 'NEW';
SELECT * FROM TABLE(dbms_xplan.display);
-- Результат: TABLE ACCESS FULL (индекс проигнорирован).
