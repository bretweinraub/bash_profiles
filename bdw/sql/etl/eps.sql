
column bytes_per_mil_imp format 99999999999
column wasted_per_mil_imp format 99999999999
set lines 100

select   partition_name,  
         num_rows, 
         blocks, 
         empty_blocks as empt_blocks, 
         (8192 * (1000000 / num_rows) * blocks) / (1024 * 1024) as bytes_per_mil_imp,
         (8192 * (1000000 / num_rows) * empty_blocks) / (1024 * 1024) as wasted_per_mil_imp
from     all_tab_partitions
where    lower(table_name) = lower('DW_CREATIVE_IMPRESS_FACT')
and      table_owner = USER 
order by PARTITION_POSITION  
/
