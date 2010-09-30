    SELECT /*+ HASH */ Distinct
      stg_commercelink_fact.DW_INPUT_FILE_SID,
      stg_commercelink_fact.ROW_NUMBER,
      stg_commercelink_fact.LOG_DATE,
      stg_commercelink_fact.TEASER_SID,
      stg_commercelink_fact.STORE_SID,
      stg_commercelink_fact.PRODUCT_SID,
      stg_commercelink_fact.PUBLISHER_SID,
      stg_commercelink_fact.CLIENT_IP,
      stg_commercelink_fact.REFERRING_URL,
      dw_commercelink_fact_s.NEXTVAL,
      dw_time.time_id,
      dw_calendar_date.DATE_ID,
      dw_teaser_product_fact.teaser_product_id,
      dw_store.store_id,
      dw_product.product_id,
      dw_product.merchant_site_sid,
      dw_merchant.merchant_site_id,
      4249
    from
      stg_commercelink_fact, 
      dw_time,
      dw_teaser_product_fact,
      dw_calendar_date,
      dw_store,
      dw_product,
      dw_merchant
    where  
      stg_commercelink_fact.dw_input_file_sid = 10129
    and
      stg_commercelink_fact.row_number = 92846
    and
      to_number (to_char (log_date, 'HH')) = dw_time.hour(+)
    and
      to_number (to_char (log_date, 'MM')) = dw_time.minute(+)
    and
      to_number (to_char (log_date, 'SS')) = dw_time.second(+)
    and
      stg_commercelink_fact.teaser_sid = dw_teaser_product_fact.teaser_sid(+)
    and  
      stg_commercelink_fact.log_date BETWEEN dw_teaser_product_fact.effective_dt(+) AND dw_teaser_product_fact.expiration_dt(+)
    and
      trunc (stg_commercelink_fact.LOG_DATE) = dw_calendar_date.FULL_DATE(+)
    and
      stg_commercelink_fact.STORE_SID = dw_store.STORE_SID(+)
    and
      dw_store.latest(+) = 'T'
    and
      stg_commercelink_fact.PRODUCT_SID = dw_product.product_sid(+)
    and
      dw_product.LATEST(+) = 'T'
    and
      dw_product.merchant_site_sid = dw_merchant.merchant_site_sid(+)
    and
      dw_merchant.latest(+) = 'T';      
