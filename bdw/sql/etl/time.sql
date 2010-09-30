select start_dt + avg_time + (1/24)
         from  (select max(dt) as start_dt
                from    dw_etl_trace_log
                where   etl_id = (select max(etl_id)
                    	    	  from   dw_etl_control_log)
                and     package_name = 'dw_etl.sh'
                and     code2 = 'Finished Get ETL_ID') A,
	       (select  avg(b.dt - a.dt) avg_time
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
                where a.etl_id = b.etl_id and a.dt < b.dt) B
/		

