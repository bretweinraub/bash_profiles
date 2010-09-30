DECLARE
  test1 BOOLEAN;
BEGIN
    test1 := DW_STEP_API.STEP_COMPLETE ('DW_ETL_STORES', 'DO_UPDATES', NULL, TO_DATE ('03062000', 'MMDDYYYY'),TO_DATE ('03072000', 'MMDDYYYY'));
    IF test1
    THEN
    	dbms_output.put_line('TRUE');
    ELSE
    	dbms_output.put_line('FALSE');    
    END IF;
END;
/
