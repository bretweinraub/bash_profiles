
select procedure from (
    select procedure from (
        select  package_name || '.' || procedure_name as procedure, rownum as rn
        from    dw_etl_trace_log
        where   dt = (	
            	      select  max(dt) 
            	      from    dw_etl_trace_log
            	      where   etl_id = (
                    	    	    	select  max(etl_id)
                    	    	    	from    dw_etl_control_log
        			        )
            	     )
        )
    order by rn desc
)
where rownum = 1
/
