SELECT table_name, partition_name, compression, compress_for 
FROM user_tab_partitions 
WHERE table_name = 'ORDERS_HIST';
