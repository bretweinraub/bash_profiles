
set lines 300
column name format A40
drop table bdw_dep_tmp;
create table bdw_dep_tmp nologging as select * from user_dependencies;
select rpad(' ', level*3 - 3) || name as name, type from bdw_dep_tmp start with referenced_name = '&object_name' and referenced_type = '&object_type' connect by prior name = referenced_name and prior type = referenced_type;
--drop table bdw_dep_tmp;
set lines 80
