select * from (
select dw_etl_trace_log.package_name, 
	   dw_etl_trace_log.PROCEDURE_NAME, 
	   dw_etl_trace_log.CODE1,
	   dw_etl_trace_log.CODE2,
	   dw_etl_trace_log.CODE3 
from   dw_etl_trace_log
order by dt desc
) where rownum = 1