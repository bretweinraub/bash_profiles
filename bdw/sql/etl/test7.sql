select distinct /*+ ORDERED USE_NL(B) PARALLEL (B, 8) */ B.teaser_sid
from   (select   /*+ PARALLEL (dw_commercelink_fact, 8) */ 
       	       	 dw_input_file_sid, 
       	         row_number
        from     dw_commercelink_fact partition (part_jun_2000) 
	group by dw_input_file_sid, row_number 
	having count(*) > 1) A,
        dw_commercelink_fact partition (part_jun_2000) B
where   B.dw_input_file_sid = A.dw_input_file_sid 
and     B.row_number = A.row_number;
