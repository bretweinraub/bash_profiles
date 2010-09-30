
select start_dt, end_dt 
from   dw_step_completion_log
where  unit_name = 'DW_ETL_STORES'
and    sub_unit_name = 'NEW'
and    nvl (uniqueness, 'NULL') = nvl (NULL, 'NULL')
and    inserted_dt = (
  select max (inserted_dt) 
  from   dw_step_completion_log 
  where  unit_name = 'DW_ETL_STORES'
  and    sub_unit_name = 'NEW'
  and    nvl (uniqueness, 'NULL') = nvl (NULL, 'NULL')
);
