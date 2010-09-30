
begin
    execute immediate 'drop table trace_log_longrunner_dyn';
exception
    when others then
    	NULL;
end;
/

begin
    execute immediate 'drop sequence trace_log_longrunner_dyn_s';
exception
    when others then
    	NULL;
end;
/

create sequence trace_log_longrunner_dyn_s;

create table trace_log_longrunner_dyn nologging as select ROWNUM as trace_log_longrunner_dyn_sid, A.* from ( select
    	dw_etl_trace_log.package_name, 
	dw_etl_trace_log.PROCEDURE_NAME , 
    	dw_etl_trace_log.dt,
	dw_etl_trace_log.CODE1, 
	dw_etl_trace_log.CODE2, 
	dw_etl_trace_log.CODE3,
	dw_etl_trace_log.CODE4,
	1 as diffDates
    from
    	dw_etl_trace_log 
    where
    	etl_id = (
	    select max(etl_id) from dw_etl_control_log
	    )
    order by dt ) A
/    

DECLARE
    CURSOR c1 IS
    select
    	trace_log_longrunner_dyn_sid,
    	dt
    from
    	trace_log_longrunner_dyn
    order by dt;

    curRec c1%ROWTYPE;
    nextRec c1%ROWTYPE;    
BEGIN        

    open c1;
    fetch c1 into curRec;

    dbms_output.enable (1000000);
    LOOP
    	fetch c1 into nextRec;
	update 
	    trace_log_longrunner_dyn
	set
	    diffDates = ((nextRec.dt - curRec.dt) * 86400)
	where 
	    trace_log_longrunner_dyn.trace_log_longrunner_dyn_sid = curRec.trace_log_longrunner_dyn_sid;

    	commit;
--	dbms_output.put_line (curRec.trace_log_longrunner_dyn_sid);
--    	dbms_output.put_line (SQL%ROWCOUNT);
--	dbms_output.put_line (to_char (nextRec.dt, 'MM/DD/YYYY HH24:MI:SS') || '    ' || to_char (curRec.dt, 'MM/DD/YYYY HH24:MI:SS') || '    ' || to_char((nextRec.dt - curRec.dt) * 86400));
	curRec := nextRec;
    	exit when c1%NOTFOUND;
    end loop;

    commit;    
END;
/

set pages 30
set lines 200
column package_name format A20
column procedure_name format A20
column code1 format A25
column code2 format A25
column code3 format A25
select diffDates, package_name , PROCEDURE_NAME , to_char(dt, 'DDMMYYYY HH24:MI:SS'), CODE1 , CODE2 , CODE3
from   trace_log_longrunner_dyn 
order by diffDates
/

