

create table bdw_comm_stg_transformed parallel nologging as
select /*+ HASH */
    stg_commercelink_fact.dw_input_file_sid,
    stg_commercelink_fact.row_number,
    stg_commercelink_fact.ROWID as stg_rowid
from
    stg_commercelink_fact,
    dw_commercelink_fact
where 
    stg_commercelink_fact.dw_input_file_sid = dw_commercelink_fact.dw_input_file_sid
and
    stg_commercelink_fact.row_number = dw_commercelink_fact.row_number    
/
