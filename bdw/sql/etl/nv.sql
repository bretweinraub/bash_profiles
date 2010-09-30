
select   max(start_dt) as runDate
from     dw_step_completion_log
where    unit_name = 'runDailyAudit.sh'
and      sub_unit_name = 'runDailyAudit.sh'
union    all
select   to_date (nvl(context, '19990531'), 'YYYYMMDD') + 1
from     component
where    component_name = 'ETL'
/
