EXPLAIN PLAN 
    SET STATEMENT_ID = 'parttest' 
    INTO plan_table
    FOR select count(*) from dw_creative_impress_fact where trunc(log_date) = trunc (to_date ('22-Apr-00'));
    
