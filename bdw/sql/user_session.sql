set pages 100
set lines 200
column osuser format A12
column machine format A15
column schema format A8
column command format A14
select distinct osuser, sql_address, process, machine, schemaname as schema, terminal, status, sid, serial#, program, sys.audit_actions.name as command from v$session, sys.audit_actions where v$session.command = sys.audit_actions.action and osuser = '&user' order by command ;

set lines 80
