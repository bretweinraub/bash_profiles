 column   segment_name format A32
 select   
 	segment_name, 
 	 owner,
 	 tablespace_name,
     	 sum (bytes) / (1024 * 1024) 
 from     dba_segments 
 group by 
 	segment_name,
 	owner,
 	tablespace_name
 order by sum(bytes) asc;
