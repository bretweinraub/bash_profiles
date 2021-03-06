INSERT /*+ APPEND */ INTO stg_upd_store
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
        store_updated_by_user_status,
	ppn_store_meta_sid,
	ppn_store_meta_state,
	ppn_store_meta_created_dt,
	merchandiser
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
        updated_user_user_status,
	ppn_store_meta_sid,
	ppn_store_meta_state,
    ppn_store_meta_created_dt,
	merchandiser
    FROM
        dw_stores_v@factory1_src
    WHERE
        store_updated_dt between (sysdate -1) and sysdate or
        publisher_updated_dt between (sysdate -1) and sysdate or
        store_theme_updated_dt between (sysdate -1) and sysdate or
        store_spec_updated_dt between (sysdate -1) and sysdate or
        updated_user_updated_dt between (sysdate -1) and sysdate or
        ppn_store_meta_updated_dt between (sysdate -1) and sysdate
;
