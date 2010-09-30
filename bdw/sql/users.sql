set pagesize 20 
set lines 200
select username, default_tablespace, temporary_tablespace, created from dba_users;
