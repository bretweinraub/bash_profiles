define test_column=merchandiser
select &test_column, count(*) from (
   SELECT
        store.store_sid,
        store.store_name,
        store.store_desc,
        store.store_number,
        store.partition,
        store.search_string,
        store.publisher_home_url,
        store.splash_text,
        store.prebuilt_store_sid,
        store.store_status,
        store.product_count,
        store.featured_count,
        store.annotated_count,
        store.merchant_count,
        store.created_by,
        store.updated_by,
        store.created_dt,
        store.updated_dt,
-- PUBLISHER TABLE - required
        publisher.publisher_sid,
        publisher.partner_sid,
        publisher.publisher_name,
        publisher.publisher_desc,
        publisher.publisher_tin_type,
        publisher.publisher_tax_id,
        publisher.publisher_tax_type,
        publisher.pay_cycle_frequency,
        publisher.pay_cycle_month,
        publisher.pay_cycle_day,
        publisher.publisher_question,
        publisher.publisher_answer,
        publisher.response_priority,
        publisher.publisher_url,
        publisher.last_publisher_login_dt,
        publisher.publisher_status,
        publisher.charity,
        publisher.store_number_nextval,
        publisher.monthly_page_views,
        publisher.monthly_unique_visitors,
        publisher.created_by,
        publisher.updated_by,
        publisher.created_dt,
        publisher.updated_dt,
-- STORE_TYPE TABLE - required
        store_type.store_type_sid,
        store_type.store_type,
        store_type.store_type_desc,
-- STORE_THEME TABLE - required
        store_theme.store_theme_sid,
        store_theme.store_theme,
        store_theme.store_theme_desc,
        store_theme.store_theme_status,
        store_theme.layout_template_path,
        store_theme.created_by,
        store_theme.updated_by,
        store_theme.created_dt,
        store_theme.updated_dt,
-- STORE_SPEC TABLE
        store_spec.store_spec_sid,
        store_spec.store_spec,
        store_spec.store_spec_desc,
        store_spec.created_by,
        store_spec.updated_by,
        store_spec.created_dt,
        store_spec.updated_dt,
-- SERVICE_USER TABLE
        created_user.user_login,
        created_user.user_status,
        updated_user.user_login,
        updated_user.user_status,
	ppn_store_meta_sid,
	ppn_store_meta_state,
	ppn_store_meta.created_dt as ppn_store_meta_created_dt,
	merchandiser
    FROM
        store_type@factory1_src,
        store_theme@factory1_src,
        store_spec@factory1_src,
        publisher@factory1_src,
        store@factory1_src,
        service_user@factory1_src created_user,
        service_user@factory1_src updated_user,
	ppn_store_meta@factory1_src 
    WHERE
        store.store_type_sid = store_type.store_type_sid AND
        store.store_theme_sid = store_theme.store_theme_sid AND
        store.publisher_sid = publisher.publisher_sid AND
        store.created_by = created_user.service_user_sid AND
        store.updated_by = updated_user.service_user_sid (+) AND
        store.store_spec_sid = store_spec.store_spec_sid (+) AND
	store.store_sid = ppn_store_meta.store_sid (+) and
        store.created_dt BETWEEN trunc (sysdate - 200) and (trunc (sysdate) - (1/86400))
) group by &test_column;	
