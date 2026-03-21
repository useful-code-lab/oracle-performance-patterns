PROCEDURE log_event(p_proc IN VARCHAR2, p_type IN VARCHAR2, p_msg IN VARCHAR2);

PROCEDURE log_event(
    p_proc IN VARCHAR2, -- Вот тут они объявляются
    p_type IN VARCHAR2, 
    p_msg  IN VARCHAR2
) IS
    PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN
    INSERT INTO app_logs (proc_name, log_type, message)
    VALUES (p_proc, p_type, p_msg); -- Теперь это ПАРАМЕТРЫ, и ошибки не будет
    
    COMMIT; 
END log_event;
