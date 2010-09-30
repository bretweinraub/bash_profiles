
define log_directory=/nfs_ppn/ppn01
-- remember to reset partition date when changing this file	
define file_to_check=creative-1-v2.2-20000628-0800.log

column filename format A33
set lines 100
PROMPT Checking impression cookie data:
select  filename,
    	row_number,
    	user_cookie
-- remember to reset partition date when changing this file	
from    dw_creative_impress_fact partition (i_06282000) imp, 
    	dw_input_file ift
where   imp.dw_input_file_sid = ift.dw_input_file_sid
and	imp.dw_input_file_sid in 
    	(
    	    select  dw_input_file_sid 
	    from    dw_input_file
	    where   filename like '&file_to_check'
	    and     directory = '&log_directory'
	    and     file_type = 'CIL'
	);
PROMPT Checking clickthru impression date:
select  filename,
    	row_number,
    	user_cookie
from    dw_creative_click_fact imp, 
    	dw_input_file ift
where   imp.dw_input_file_sid = ift.dw_input_file_sid
and	imp.dw_input_file_sid in 
    	(
    	    select  dw_input_file_sid 
	    from    dw_input_file
	    where   filename like '&file_to_check'
	    and     directory = '&log_directory'
	    and     file_type = 'CCTM'
	);
