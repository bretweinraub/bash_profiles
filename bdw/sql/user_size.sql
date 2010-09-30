column   segment_name format A32
select   OWNER,
    	 sum (bytes) / (1024 * 1024) 
from     dba_segments 
group by OWNER
order by sum(bytes) asc;
