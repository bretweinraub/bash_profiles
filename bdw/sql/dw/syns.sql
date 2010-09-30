
--
-----------------------------------------------------------------
-- Procedure:		build_public_synonyms
--
-- Date:		05.09.2000
--
-- Description:		creates public synonyms for any USER objects
--                      that don't currently have them.  Suitable to
--                      be called from 
--
-----------------------------------------------------------------
--

Prompt *** Creating procedure build_public_synonyms
create or replace procedure build_public_synonyms
as
    cursor c1 is 
        select
            object_name
        from
            dba_objects
        where
            owner = USER
        and
            object_type in ('TABLE', 'VIEW') 
        and 
            object_name not in (
            	select
        	    table_name
        	from
        	    dba_synonyms 
        	where 
        	    table_owner = USER
                and
        	    synonym_name = table_name
        	and	    
            	    owner = 'PUBLIC'
             );
         
begin
    for rec in c1
    loop
    	dbms_output.enable (100000);
	dbms_output.put_line ('create public synonym ' || rec.object_name || ' for ' || USER || '.' || rec.object_name);
    	execute immediate 'create public synonym ' || rec.object_name || ' for ' || USER || '.' || rec.object_name;
    end loop;
end;
/
	     
--
-----------------------------------------------------------------
-- Procedure:		build_private_synonyms
--
-- Date:		05.09.2000
--
-- Description:
--
-----------------------------------------------------------------
--

Prompt *** Creating procedure build_private_synonyms
create or replace procedure build_private_synonyms 
(
    i_owner dba_synonyms.owner%TYPE
)
as
    owner dba_synonyms.owner%TYPE;
    cursor c1 (c_owner dba_synonyms.owner%TYPE) is 
        select
            object_name
        from
            dba_objects
        where
            owner = USER
        and
            object_type in ('TABLE', 'VIEW') 
        and 
            object_name not in (
            	select
        	    table_name
        	from
        	    dba_synonyms 
        	where 
        	    table_owner = USER
                and
        	    synonym_name = table_name
        	and	    
            	    lower(owner) = lower(c_owner)
             );
         
begin
    IF i_owner IS NULL THEN
        BEGIN
	    select 
    	    	distinct owner into build_private_synonyms.owner
            from
    	    	dba_synonyms
            where
    	    	table_owner = USER
            and 
	    	owner <> 'PUBLIC';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
    	    	raise_application_error (-20999, 
		    	    	    	 'could not determine monitor user');
	    WHEN TOO_MANY_ROWS THEN
    	    	raise_application_error (-20998, 
		    	    	    	 'could not determine monitor user');
	END;
    ELSE
    	owner := i_owner;
    END IF;

    dbms_output.put_line ('Monitor user is ' || build_private_synonyms.owner);
    for rec in c1 (build_private_synonyms.owner)
    loop
    	dbms_output.enable (100000);
    	execute immediate 'create synonym ' || build_private_synonyms.owner || '.' || rec.object_name || ' for ' || USER || '.' || rec.object_name;
    	dbms_output.put_line ('created synonym ' || build_private_synonyms.owner || '.' || rec.object_name || ' for ' || USER || '.' || rec.object_name);
    end loop;
end;
/
	     

