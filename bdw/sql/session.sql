set pages 20
set lines 200
column process format A7
column sid format 999
column serial# format 99999
column osuser format A8
column machine format A21
column schema format A10
column command format A8
column terminal format A8
column program format A29

select distinct 
       osuser, 
--       sql_address, 
       process, 
       machine, 
       schemaname as schema, 
       terminal, 
       status, 
       sid, 
       serial#, 
       substr(program,1,instr(program,'@')-1) program,
       sys.audit_actions.name as command 
from   v$session, 
       sys.audit_actions 
where  v$session.command = sys.audit_actions.action 
-- and    osuser <> 'oracle'
order by command
/


