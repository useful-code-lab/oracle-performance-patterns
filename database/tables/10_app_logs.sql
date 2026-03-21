CREATE TABLE app_logs (
    log_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    log_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    proc_name   VARCHAR2(100),
    log_type    VARCHAR2(10) CHECK (log_type IN ('INFO', 'ERROR')),
    message     VARCHAR2(4000)
);
