
set pages 100
set lines 200
column name format a40
select name, value from v$sysstat where lower(name) like '%' || lower ('&match') || '%';
