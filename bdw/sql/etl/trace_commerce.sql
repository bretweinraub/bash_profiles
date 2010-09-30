set pages 5
set lines 200

select distinct dw_etl_trace_log.code3, A.* from dw_etl_trace_log,
(
    select dw_etl_trace_log.package_name , 
	    dw_etl_trace_log.PROCEDURE_NAME , 
	    to_char(dt, 'DDMMYYYY HH24:MI:SS'), 
	    dw_etl_trace_log.CODE1 , 
	    dw_etl_trace_log.CODE2 , 
	    dw_etl_trace_log.CODE3 ,
	    etl_id
    from   
	    dw_etl_trace_log where
    package_name = 'DW_ETL_COMMERCELINK_TRACKING' and
    procedure_name = 'DO_IT'
    and
    code1 = 'EV_PROCEDURE_EXECUTION_TIME'
    order by dt
) A
where dw_etl_trace_log.etl_id = A.etl_id
and dw_etl_trace_log.code2 = 'EV_ROWCOUNT'
/
