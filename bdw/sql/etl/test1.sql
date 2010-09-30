DECLARE
    x DATE;
BEGIN
  select max(end_dt) 
  into   x
  from   dw_step_completion_log
  where  unit_name = 'DW_ETL_STORES'
  and    sub_unit_name = 'DO_NEW';
END;
/
