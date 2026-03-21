/* 
  СЦЕНАРИЙ: Менеджер пытается удалить заказ №1.
  ОЖИДАЕМЫЙ РЕЗУЛЬТАТ: Ошибка ORA-20005, заказ остается в базе со статусом CANCELLED.
*/

-- 1. Попытка удаления
DELETE FROM orders WHERE order_id = 1;

-- 2. Проверка, что строка на месте, но статус изменился
SELECT order_id, status FROM orders WHERE order_id = 1;
