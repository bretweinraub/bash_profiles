DECLARE
    etl_id NUMBER := 5139;
    i_start_dt DATE := TO_DATE ('07112000 000000', 'MMDDYYYY HH24MISS');
    i_end_dt DATE := TO_DATE ('07112000 235959', 'MMDDYYYY HH24MISS');
    new_row_count NUMBER;
    new_exception_row_count NUMBER;
    package_name VARCHAR2(32) := 'CLICKSTREAM_RECOVER';
    procedure_name VARCHAR2(32) := 'CLICKSTREAM_RECOVER';
    
BEGIN
        DW_ETL_CLICKSTREAM.DO_IT(etl_id, i_start_dt, i_end_dt,
            new_row_count, new_exception_row_count);
EXCEPTION
        WHEN OTHERS THEN
            DW_LOG.ETL_TRACE(etl_id, package_name, procedure_name, '0.1',
                'EV_ETL_CLICKSTREAM_EXCEPTION', NULL, NULL, NULL, NULL);
END;
/    
