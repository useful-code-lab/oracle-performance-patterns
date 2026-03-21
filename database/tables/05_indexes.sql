-- Ускоряем поиск по SKU (всегда в верхнем регистре)
CREATE INDEX idx_products_sku_upper ON products(UPPER(sku));

-- Ускоряем поиск заказов, сделанных в выходные (аналитика)
CREATE INDEX idx_orders_weekend ON orders(TO_CHAR(order_date, 'DY'));
