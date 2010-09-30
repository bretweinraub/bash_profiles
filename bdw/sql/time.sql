select  A.etl_id, 
    	A.dt as start, 
	B.dt as end 
from  ( select etl_id, 
    	       dt
        from   dw_etl_trace_log 
	where  package_name = 'dw_etl.sh' 
	and   (code2 = 'done' or code2 = 'Finished Get ETL_ID') 
	and trunc(dt) > sysdate - 7
      ) A, 
      ( select etl_id, 
    	       dt
        from   dw_etl_trace_log 
	where  package_name = 'dw_etl.sh' 
	and   (code2 = 'done' or code2 = 'Finished Get ETL_ID') 
	and trunc(dt) > sysdate - 7
      ) B 
where a.etl_id = b.etl_id and a.dt < b.dt;

