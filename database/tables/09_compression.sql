-- Перестраиваем таблицу с продвинутым сжатием для транзакций
ALTER TABLE orders_hist MOVE COMPRESS FOR OLTP;

ALTER TABLE orders_hist MOVE PARTITION p_2023 COMPRESS FOR ARCHIVE HIGH;


