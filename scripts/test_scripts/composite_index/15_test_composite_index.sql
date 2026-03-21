EXPLAIN PLAN FOR 
SELECT * FROM orders 
WHERE customer_id = 1 AND status = 'PAID';

SELECT * FROM TABLE(dbms_xplan.display);
-- Ты увидишь: INDEX RANGE SCAN на IDX_ORDERS_CUST_STATUS
-- Это в разы быстрее, чем искать сначала по ID, а потом фильтровать статус.
