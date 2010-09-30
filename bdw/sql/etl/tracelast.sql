set pages 30
set lines 200
column package_name format A20
column procedure_name format A20
column code1 format A10
column code2 format A50
column code3 format A20
select 'Last ETL ID is ' || max(etl_id) from dw_etl_control_log;
select dw_etl_trace_log.package_name , dw_etl_trace_log.PROCEDURE_NAME , to_char(dt, 'DDMMYYYY HH24:MI:SS'), dw_etl_trace_log.CODE1 , dw_etl_trace_log.CODE2 , dw_etl_trace_log.CODE3 
from   dw_etl_trace_log where etl_id = (select etl_id from dw_etl_control_log where end_window_dt = (select max(end_window_dt) from dw_etl_control_log))
order by dt
/
