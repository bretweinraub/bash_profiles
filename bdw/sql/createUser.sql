
set pagesize 0

select 'this script will first drop/cascade the user you specify ....' from dual;

drop user &&user cascade;

create user &&user identified by &&password temporary tablespace temp default tablespace data1;
grant connect to &&user;
grant resource to &&user;
grant create table to &&user;
grant create snapshot to &&user;
grant create any outline to &&user;
grant drop any outline to &&user;

select 'setenv CONNECTSTRING &&user/&&password@' || lower(NAME) from v$database;
select 'export CONNECTSTRING=&&user/&&pasword@' || lower(NAME) from v$database;
