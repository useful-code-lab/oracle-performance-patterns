CREATE OR REPLACE VIEW v_hot_products_cache AS
SELECT /*+ RESULT_CACHE */ 
    product_id, 
    name, 
    COUNT(*) as sales_count,
    SUM(quantity) as total_qty
FROM order_items
JOIN products USING (product_id)
GROUP BY product_id, name
ORDER BY sales_count DESC;
