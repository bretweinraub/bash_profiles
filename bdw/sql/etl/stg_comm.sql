set timi on
alter session set nls_date_format = 'MMDDYYYY HH24MISS';

set serverout on


DECLARE
    start_date DATE := TO_DATE ('03292000 000000');
    end_date DATE := TO_DATE ('04302000 000000');
BEGIN
    DBMS_OUTPUT.ENABLE (1000000);
    
    while start_date < end_date LOOP
      delete from stg_commercelink_fact where log_date < start_date;
      commit;
      dbms_output.put_line ('blew away ' || SQL%ROWCOUNT || ' rows on ' || start_date);
      start_date := start_date + 1;
    END LOOP;
END;
/
