select  t.tablespace_name "Tablespace",
        s.total_space,
        f.free_space,
        (f.free_space / s.total_space) * 100 pct_free
from    dba_tablespaces                  t,
        (select         tablespace_name,
                        sum(bytes) / 1048576 total_space
         from           dba_data_files
         group by       tablespace_name) s,
        (select         tablespace_name,
                        sum(bytes) / 1048576 free_space
         from           dba_free_space
         group by       tablespace_name) f
where      s.tablespace_name = t.tablespace_name
and     f.tablespace_name(+) = t.tablespace_name
/
