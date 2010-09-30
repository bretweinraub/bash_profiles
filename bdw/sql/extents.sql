select * from (
select file_id, block_id, block_id + blocks, 'F'
from dba_free_space
where tablespace_name='&tablespace_name'
union all
select file_id, block_id, block_id + blocks, 'U'
from dba_extents
where tablespace_name='&tablespace_name'
)
order by 1, 2
/
