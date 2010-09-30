
set timi on
set serverout on

DECLARE
    new_row_count PLS_INTEGER;
BEGIN
        new_row_count := DW_ETL_COMMERCELINK_TRACKING.TRANSFORM_AUTO
	(
	    2,
	    'CLT',
	    'commercelink_access_80-',
    	    5097
        );
    DBMS_OUTPUT.PUT_LINE(new_row_count);
END;
/    
   
