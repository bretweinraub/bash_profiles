set pages 30
set lines 200
column name format A25
column value format A30
column description format A30

select NAME, VALUE, ISDEFAULT, ISSES_MODIFIABLE, ISSYS_MODIFIABLE, ISMODIFIED, ISADJUSTED, DESCRIPTION
from v$parameter where name like '%&pattern%';
/
/
/
/
/
/
/
/
/
    
