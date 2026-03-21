ALTER TABLE orders ADD (
    tax_amount AS (total_amount * 0.20) -- НДС 20% вычисляется автоматически
);

CREATE INDEX idx_orders_tax ON orders(tax_amount);

