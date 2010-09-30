
set pages 100
set lines 300
set long 30
column partition_name format A14
column pp format 99
column num_rows format 99999999
column blocks format 999999
column log format A4
column empt_blk format 9999
select partition_name, PARTITION_POSITION as PP  , logging as log , num_rows , blocks, empty_blocks as empt_blk, high_value, pct_free, pct_used, initial_extent, next_extent, pct_increase
 from all_tab_partitions
  where lower(table_name) = lower('&table_name')
  and
    table_owner = '' || USER || ''
 order by PARTITION_POSITION  
 
/

set lines 80

