
SELECT * FROM sys.dba_role_privs where lower(grantee) = '&&user';

SELECT * FROM sys.dba_sys_privs where lower(grantee) = '&&user';

SELECT table_name, privilege, grantable FROM sys.dba_tab_privs
    WHERE lower(grantee) = '&&user';

SELECT grantee, table_name, column_name, privilege    FROM sys.dba_col_privs
 where lower(grantee) = '&&user';
