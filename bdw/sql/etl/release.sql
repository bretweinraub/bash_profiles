
set serverout on
DECLARE
  i_release cm_database_version.release%TYPE;
  i_patchlevel cm_patch_log.patchlevel%TYPE;
  factory_link varchar2(32);
  etl_host varchar2(32) := 'unknown';
  etl_directory varchar2(128) := 'unknown';
  etl_status varchar2(16) := 'unknown';
  etl_window varchar2(20) := 'unknown';
  current_step varchar2(128) := 'unknown';
  cursor A is select  package_name || '.' || procedure_name as procedure_name
                    from    dw_etl_trace_log
                    where   dt = (	
                        	      select  max(dt) 
                        	      from    dw_etl_trace_log
                        	      where   etl_id = (
                                	    	    	select  max(etl_id)
                                	    	    	from    dw_etl_control_log
                    			        )
                        	     );
                    

BEGIN
    select  cm_database_version.release, 
	    max(patchlevel) 
    into    i_release, 
    	    i_patchlevel
    from    cm_database_version, 
	    cm_patch_log 
    where   cm_database_version.release = cm_patch_log.release 
    group by schema_name, cm_database_version.release ;
    
    select  lower(username) || '@' || lower(host) 
    into    factory_link
    from    dba_db_links 
    where   db_link = 'FACTORY1_SRC' 
    and	    owner = USER;

    BEGIN
        select value into etl_host
        from   component_parameters, 
               component
        where  component.component_id = component_parameters.component_id
        and    component.component_name = 'ETL'
        and    parameter = 'Installation Host';
    EXCEPTION
    	WHEN OTHERS THEN
	    NULL;
    END;

    BEGIN    
        select value into etl_directory
        from   component_parameters, 
               component
        where  component.component_id = component_parameters.component_id
        and    component.component_name = 'ETL'
        and    parameter = 'Installation Directory';
    EXCEPTION
    	WHEN OTHERS THEN
	    NULL;
    END;

    BEGIN
        select 
          status, NVL(TO_CHAR(TO_DATE(context, 'YYYYMMDD'), 'MM.DD.YYYY'), 'unknown')
	into
	  etl_status, etl_window
        from
          component 
        where 
          component_name = 'ETL';
    EXCEPTION
    	WHEN OTHERS THEN
	    NULL;
    END;
    if etl_status = 'RUNNING' THEN
        BEGIN
	    for rec in A LOOP
	    	current_step := rec.procedure_name;
	    END LOOP;

        EXCEPTION
        	WHEN OTHERS THEN
	    	    current_step := 'unknown';		
    	    NULL;
        END;
    ELSE
    	current_step := 'N/A';
    END IF;

    DBMS_OUTPUT.PUT_LINE (i_release);
    DBMS_OUTPUT.PUT_LINE (i_patchlevel);
    DBMS_OUTPUT.PUT_LINE (factory_link);
    if etl_host <> 'unknown' THEN
	DBMS_OUTPUT.PUT_LINE (etl_host || ':' || etl_directory);
    ELSE	
	DBMS_OUTPUT.PUT_LINE (etl_host);
    END IF;
    DBMS_OUTPUT.PUT_LINE (etl_status);
    DBMS_OUTPUT.PUT_LINE (etl_window);
    DBMS_OUTPUT.PUT_LINE (current_step);
END;
/    
