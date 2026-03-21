/* 
  TEST CASE: Проверка маскирования Email.
  EXPECTED RESULT: Вместо ivan@mail.com мы должны увидеть i***@mail.com.
*/

-- 1. Обычный запрос (База сама применит маску)
SELECT first_name, email FROM customers;

-- 2. Проверка, что данные на диске НЕ испорчены
-- (Если зайти под системным админом или отключить политику, данные будут полными)
SELECT column_name, data_redaction_applied 
FROM user_redaction_columns 
WHERE table_name = 'CUSTOMERS';
