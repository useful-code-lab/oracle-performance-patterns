CREATE GLOBAL TEMPORARY TABLE temp_order_calc (
    product_id  NUMBER,
    quantity    NUMBER,
    price       NUMBER,
    discount    NUMBER
) ON COMMIT DELETE ROWS; 
