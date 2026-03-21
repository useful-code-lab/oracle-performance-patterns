CREATE MATERIALIZED VIEW mv_monthly_sales
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT 
    TRUNC(order_date, 'MM') as sale_month,
    COUNT(order_id) as total_orders,
    SUM(total_amount) as revenue
FROM orders
GROUP BY TRUNC(order_date, 'MM');
