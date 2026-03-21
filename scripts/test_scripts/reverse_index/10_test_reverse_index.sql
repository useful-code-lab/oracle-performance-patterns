-- 1. Проверяем тип индекса в системном каталоге
SELECT index_name, index_type 
FROM user_indexes 
WHERE index_name = 'IDX_ORDERS_ID_REV';

-- Ожидаемый результат в колонке INDEX_TYPE: "NORMAL/REV"
