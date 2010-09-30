

create or replace procedure bdw_test (
    i_etl_id dw_etl_trace_log.etl_id%TYPE
)
IS
    CURSOR c1 (i_etl_id dw_etl_trace_log.etl_id%TYPE) IS
    select
    	dw_etl_trace_log.package_name, 
	dw_etl_trace_log.PROCEDURE_NAME , 
    	dw_etl_trace_log.dt,
	dw_etl_trace_log.CODE1, 
	dw_etl_trace_log.CODE2, 
	dw_etl_trace_log.CODE3,
	dw_etl_trace_log.CODE4,
	sysdate
    from
    	dw_etl_trace_log 
    where
    	etl_id = i_etl_id 
    order by dt;
    
    TYPE package_name_tab is TABLE of dw_etl_trace_log.package_name%type;
    TYPE PROCEDURE_NAME_tab is table of dw_etl_trace_log.PROCEDURE_NAME%type;
    TYPE dt_tab is table of dw_etl_trace_log.dt%type;
    TYPE CODE1_tab is table of dw_etl_trace_log.CODE1%type;
    TYPE CODE2_tab is table of dw_etl_trace_log.CODE2%type;
    TYPE CODE3_tab is table of dw_etl_trace_log.CODE3%type;
    TYPE CODE4_tab is table of dw_etl_trace_log.CODE4%type;
    package_name package_name_tab;
    PROCEDURE_NAME PROCEDURE_NAME_tab;
    dt dt_tab;
    CODE1 CODE1_tab;
    CODE2 CODE2_tab;
    CODE3 CODE3_tab;
    CODE4 CODE4_tab;
    diffDates dt_tab;
    i number;
BEGIN
    OPEN c1 (i_etl_id);
    
    FETCH c1 bulk collect into package_name, PROCEDURE_NAME, dt, CODE1, CODE2, CODE3, CODE4, diffDates;

    for i in 1..(package_name.COUNT-1) LOOP
--    	diffDates(i) := diffDates(i+1) - diffDates(i);
    	dbms_output.put_line(diffDates(i+1) - diffDates(i));
--    	dbms_output.put_line(diffDates (i));
    END LOOP;
	            
END;
/
show errors
