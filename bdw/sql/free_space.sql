select bytes, count(*) from dba_free_space where tablespace_name = '&tablespace' group by bytes order by bytes;
