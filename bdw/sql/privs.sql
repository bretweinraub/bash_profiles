
SELECT * FROM sys.dba_role_privs where lower(grantee) = '&&user';

SELECT * FROM sys.dba_sys_privs where lower(grantee) = '&&user';

SELECT table_name, privilege, grantable FROM sys.dba_tab_privs
    WHERE lower(grantee) = '&&user';

select * from session_roles;

select * from session_privs;


