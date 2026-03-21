-- Создаем индекс для механизма Skip Scan
-- Индекс по (мало уникальных значений, много уникальных значений)
CREATE INDEX idx_orders_skip_scan 
ON orders(status, order_date);
