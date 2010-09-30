

select 
    partition_name , to_date (substr (partition_name, 3), 'MMDDYYYY') 
from
    all_tab_partitions 
where
    table_owner = USER
and
    table_name = 'DW_CREATIVE_IMPRESS_FACT'
and 
    lower (partition_name) like lower ('i_%') 
and 
    to_date (substr (partition_name, 3), 'MMDDYYYY') 
and
    (last_analyzed is null or num_rows = 0) ;
    
