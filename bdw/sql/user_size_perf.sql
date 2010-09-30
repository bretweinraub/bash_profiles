column   segment_name format A32
select   task_id,
    	 sum (bytes) / (1024 * 1024) 
from     dba_segments, 
	(
		select 	task_id, 
			value 
		from 	perfreport.task_context 
		where 	tag = 'LRA_Fixed_DBName'
	) A
where    owner = 'PERFREPORT'
and	 segment_name like '%_' || A.value
group by task_id
order by sum(bytes) asc;
