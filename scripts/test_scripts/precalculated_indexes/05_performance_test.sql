-- Проверка индекса по функции
EXPLAIN PLAN FOR 
SELECT * FROM products WHERE UPPER(sku) = 'IPH15-BLK';
-- В плане вы должны увидеть 'INDEX RANGE SCAN' на IDX_PRODUCTS_SKU_UPPER
