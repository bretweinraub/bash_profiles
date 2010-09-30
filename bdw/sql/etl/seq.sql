    set serverout on
    DECLARE
	seq NUMBER;
    BEGIN
	seq := DW_ETL_CREATIVE_IMPRESS.MAX_CLICK_ID;
	DBMS_OUTPUT.PUT_LINE (seq+1);
    END;
/
