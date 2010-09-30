set pages 30
set lines 200
column package_name format A20
column procedure_name format A20
column code1 format A25
column code2 format A25
column code3 format A25
select dw_etl_trace_log.package_name , dw_etl_trace_log.PROCEDURE_NAME , to_char(dt, 'DDMMYYYY HH24:MI:SS'), dw_etl_trace_log.CODE1 , dw_etl_trace_log.CODE2 , dw_etl_trace_log.CODE3 
from   dw_etl_trace_log where etl_id = &etl_id
order by dt
/
