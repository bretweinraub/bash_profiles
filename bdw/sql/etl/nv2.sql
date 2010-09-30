set serverout on

DECLARE
    max_etl_date DATE;
    max_audit_date DATE;
BEGIN
    select    to_date (context, 'YYYYMMDD') into max_etl_date
    from      component
    where     component_name = 'ETL';
    
    select    max(start_dt) into max_audit_date
    from      dw_step_completion_log
    where     unit_name = 'runDailyAudit.sh'
    and       sub_unit_name = 'runDailyAudit.sh';
    
    if max_audit_date < max_etl_date THEN
    	DBMS_OUTPUT.PUT_LINE (to_char (max_audit_date+1, 'YYYYMMDD'));
    END IF;
END;
/    
