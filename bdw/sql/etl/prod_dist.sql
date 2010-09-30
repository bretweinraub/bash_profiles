
select count(*), to_char (created_dt,'YYYYMMDD')
from product
group by to_char (created_dt,'YYYYMMDD')
order by to_char (created_dt,'YYYYMMDD')
/
