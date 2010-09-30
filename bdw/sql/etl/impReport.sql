
set serverout on
set pages 0
alter session set nls_date_format = 'MMDDYYYY';

DECLARE 
    i_date DATE := SYSDATE - 1;
    total NUMBER;
    total_rows NUMBER;
    pn VARCHAR2(16);
BEGIN    
    DBMS_OUTPUT.ENABLE(1000000);	
    DBMS_OUTPUT.PUT_LINE ('Total Minutes		Total Rows	Rows/Min	Date');
    WHILE i_date >= SYSDATE - 45 LOOP
    	    pn := 'I_' || to_char (i_date);

    	    select
	    	num_rows into total_rows
	    from 
	    	all_tab_partitions
	    where
	    	table_owner = USER
	    and
	    	table_name = 'DW_CREATIVE_IMPRESS_FACT'
	    and
	    	partition_name = pn ;
	    
	    select
		sum ((updated_dt - created_dt) * 1400) into total
	    from
		dw_input_file 
	    where
		file_type = 'CIL' 
	    and
		rtrim (ltrim (filename, 'creative-'), '.log') like to_char(i_date, 'YYYYMMDD') || '-' || '%' 
	    group by
		(substr (rtrim (ltrim (filename, 'creative-'), '.log'), 1, 8));

	    DBMS_OUTPUT.PUT_LINE (((floor(total*100))/100) || '			' || total_rows || '		' || floor(total_rows/total) || '		' || i_date);
	    i_date := i_date - 1;
    END LOOP;
END;
/    
