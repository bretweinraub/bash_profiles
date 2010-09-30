declare
  max_new DATE;
  max_update DATE;
begin
        max_new := DW_STEP_API.LAST_END_DT (package_name, 'NEW', NULL);
      DBMS_OUTPUT.PUT_LINE ('max_new is ' || to_char (max_new, 'MMDDYYYY HH24MISS'));

    max_update := DW_STEP_API.LAST_END_DT (
       	package_name,                          -- unit_name 
	'DO_UPDATES',                          -- sub_unit_name (use NEW ... see 'NEW' proc)
	NULL                                   -- uniqueness 
    );
end;
/
