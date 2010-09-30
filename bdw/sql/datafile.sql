-- need status from v$datafile if file in is recovery
set pages 300
set lines 200
column file_name format A60
select 	tablespace_name, file_name, bytes, status
from 	dba_data_files
order 	by tablespace_name, file_name
/
