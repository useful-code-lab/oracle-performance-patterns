/* 
  DESCRIPTION: Настройка маскирования данных (Data Redaction).
  PURPOSE: Защита персональных данных (GDPR/ФЗ-152).
  HOW IT WORKS: База перехватывает SELECT и подменяет символы по маске.
*/

BEGIN
  DBMS_REDACTION.ADD_POLICY (
    object_schema       => USER,
    object_name         => 'CUSTOMERS',
    policy_name         => 'mask_customer_email',
    column_name         => 'EMAIL',
    function_type       => DBMS_REDACTION.PARTIAL, -- Частичная маскировка
    function_parameters => '1,1,3,*,1,15,4',        -- Оставляем 1 символ, 3 заменяем на *, остальное после @
    expression          => '1=1'                    -- Применяется всегда (для всех)
  );
END;
/
