-- Посмотреть вообще все продажи
SELECT * FROM v_sales_report;

-- Найти продажи только по конкретному товару
SELECT customer_full_name, quantity, line_total 
FROM v_sales_report 
WHERE product_name = 'iPhone 15';

-- Посчитать общую выручку по всем заказам
SELECT SUM(line_total) as total_revenue 
FROM v_sales_report;
