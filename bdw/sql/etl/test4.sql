
set timi on
BEGIN
  execute immediate 'create table bdw_upd_store as select * from stg_upd_store where 1 = 0';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

truncate table bdw_upd_store;

INSERT /*+ APPEND */ INTO bdw_upd_store
    (
-- STORE TABLE
        store_sid,
        store_name,
        store_desc,
        store_number,
        partition,
        search_string,
        publisher_home_url,
        splash_text,
        prebuilt_store_sid,
        store_status,
        product_count,
        featured_count,
        annotated_count,
        merchant_count,
        store_created_by,
        store_updated_by,
        store_created_dt,
        store_updated_dt,
-- PUBLISHER TABLE
        publisher_sid,
        partner_sid,
        publisher_name,
        publisher_desc,
        publisher_tin_type,
        publisher_tax_id,
        publisher_tax_type,
        pay_cycle_frequency,
        pay_cycle_month,
        pay_cycle_day,
        publisher_question,
        publisher_answer,
        response_priority,
        publisher_url,
        last_publisher_login_dt,
        publisher_status,
        charity,
        store_number_nextval,
        monthly_page_views,
        monthly_unique_visitors,
        publisher_created_by,
        publisher_updated_by,
        publisher_created_dt,
        publisher_updated_dt,
-- STORE_TYPE TABLE
        store_type_sid,
        store_type,
        store_type_desc,
-- STORE_THEME TABLE
        store_theme_sid,
        store_theme,
        store_theme_desc,
        store_theme_status,
        layout_template_path,
        store_theme_created_by,
        store_theme_updated_by,
        store_theme_created_dt,
        store_theme_updated_dt,
-- STORE_SPEC TABLE
        store_spec_sid,
        store_spec,
        store_spec_desc,
        store_spec_created_by,
        store_spec_updated_by,
        store_spec_created_dt,
        store_spec_updated_dt,
-- SERVICE_USER TABLE
        store_created_by_user_login,
        store_created_by_user_status,
        store_updated_by_user_login,
        store_updated_by_user_status
    )
    SELECT
-- STORE TABLE - required
        store_sid,
        store_name,
        store_desc,
        store_number,
        partition,
        search_string,
        publisher_home_url,
        splash_text,
        prebuilt_store_sid,
        store_status,
        product_count,
        featured_count,
        annotated_count,
        merchant_count,
        store_created_by,
        store_updated_by,
        store_created_dt,
        store_updated_dt,
-- PUBLISHER TABLE - required
        publisher_sid,
        partner_sid,
        publisher_name,
        publisher_desc,
        publisher_tin_type,
        publisher_tax_id,
        publisher_tax_type,
        pay_cycle_frequency,
        pay_cycle_month,
        pay_cycle_day,
        publisher_question,
        publisher_answer,
        response_priority,
        publisher_url,
        last_publisher_login_dt,
        publisher_status,
        charity,
        store_number_nextval,
        monthly_page_views,
        monthly_unique_visitors,
        publisher_created_by,
        publisher_updated_by,
        publisher_created_dt,
        publisher_updated_dt,
-- STORE_TYPE TABLE - required
        store_type_sid,
        store_type,
        store_type_desc,
-- STORE_THEME TABLE - required
        store_theme_sid,
        store_theme,
        store_theme_desc,
        store_theme_status,
        layout_template_path,
        store_theme_created_by,
        store_theme_updated_by,
        store_theme_created_dt,
        store_theme_updated_dt,
-- STORE_SPEC TABLE
        store_spec_sid,
        store_spec,
        store_spec_desc,
        store_spec_created_by,
        store_spec_updated_by,
        store_spec_created_dt,
        store_spec_updated_dt,
-- SERVICE_USER TABLE
        created_user_user_login,
        created_user_user_status,
        updated_user_user_login,
        updated_user_user_status
    FROM
        dw_stores_v@factory1_src
    WHERE
            store_updated_dt BETWEEN 
	    	to_date ('01272000', 'MMDDYYYY') and to_date ('01272000 235959', 'MMDDYYYY HH24MISS') OR
--                TO_DATE(''' ||
--                    TO_CHAR(i_start_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') AND
--                TO_DATE(''' ||
--                    TO_CHAR(i_end_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') OR 
            publisher_updated_dt BETWEEN 
	    	to_date ('01272000', 'MMDDYYYY') and to_date ('01272000 235959', 'MMDDYYYY HH24MISS') OR	    
--                  TO_DATE(''' ||
--                    TO_CHAR(i_start_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') AND
--                TO_DATE(''' ||
--                    TO_CHAR(i_end_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') OR 
            store_theme_updated_dt BETWEEN 
	    	to_date ('01272000', 'MMDDYYYY') and to_date ('01272000 235959', 'MMDDYYYY HH24MISS') OR	    
--                TO_DATE(''' ||
--                    TO_CHAR(i_start_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') AND
--                TO_DATE(''' ||
--                    TO_CHAR(i_end_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') OR
            store_spec_updated_dt BETWEEN 
	    	to_date ('01272000', 'MMDDYYYY') and to_date ('01272000 235959', 'MMDDYYYY HH24MISS') OR
--                TO_DATE(''' ||
--                    TO_CHAR(i_start_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') AND
--                TO_DATE(''' ||
--                    TO_CHAR(i_end_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') OR
            updated_user_updated_dt BETWEEN 
	    	to_date ('01272000', 'MMDDYYYY') and to_date ('01272000 235959', 'MMDDYYYY HH24MISS')
--                TO_DATE(''' ||
--                    TO_CHAR(i_start_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'') AND
--                TO_DATE(''' ||
--                    TO_CHAR(i_end_dt, 'DD-MON-YYYY HH24:MI:SS') || ''',
--                        ''DD-MON-YYYY HH24:MI:SS'')
    ;
