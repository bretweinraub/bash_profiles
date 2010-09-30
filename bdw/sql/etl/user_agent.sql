
DECLARE
    click_width user_tab_columns.data_length%TYPE;
    impress_width user_tab_columns.data_length%TYPE;
BEGIN

    select data_length into click_width
    from   user_tab_columns 
    where  table_name = 'DW_CREATIVE_CLICK_FACT' 
    and    column_name = 'USER_AGENT';
    
    if click_width < 350 THEN
    	EXECUTE IMMEDIATE 'alter table dw_creative_click_fact modify user_agent varchar2(350)';
    END IF;

    select data_length into impress_width
    from   user_tab_columns 
    where  table_name = 'DW_CREATIVE_IMPRESS_FACT' 
    and    column_name = 'USER_AGENT';
    
    if impress_width < 350 THEN
    	EXECUTE IMMEDIATE 'alter table dw_creative_impress_fact modify user_agent varchar2(350)';
    END IF;

END;
/
    

