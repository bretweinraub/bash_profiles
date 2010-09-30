
set pages 100
set lines 300
column partition_name format A14
column pp format 99
column nr format 99999999
select partition_name, PARTITION_POSITION as PP  , logging as log , num_rows , blocks, empty_blocks, high_value
 from all_tab_partitions
  where table_name = 'DW_CREATIVE_IMPRESS_FACT'
  and
    table_owner = '' || USER || ''
 order by PARTITION_POSITION  
 
/

select sum( floor (bytes / ( 8 * 1048576)) )from dba_free_space where bytes >= (8 * 1048576) and tablespace_name = 'DATA1' order by bytes desc ;


set lines 80

