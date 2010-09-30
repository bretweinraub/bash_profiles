
--create table xxx_bdw_xxx as select a.store_id from dw_store a, dw_store b
create table dw_store_repair as select a.store_id as to_be_removed, b.store_id as keeper_row from dw_store a, dw_store b
where
    a.rowid <> b.rowid and
    a.store_id < b.store_id and
    a.STORE_SID = b.STORE_SID and
    nvl (a.STORE_NAME, 'NULL') = nvl (b.STORE_NAME,'NULL') and
    nvl (a.STORE_DESC, 'NULL') = nvl (b.STORE_DESC,'NULL') and
    nvl (a.STORE_NUMBER,0) = nvl (b.STORE_NUMBER,0) and
    nvl (a.PARTITION,0) = nvl (b.PARTITION,0) and
    nvl (a.SEARCH_STRING, 'NULL') = nvl (b.SEARCH_STRING,'NULL') and
    nvl (a.PUBLISHER_HOME_URL, 'NULL') = nvl (b.PUBLISHER_HOME_URL,'NULL') and
    nvl (a.SPLASH_TEXT, 'NULL') = nvl (b.SPLASH_TEXT,'NULL') and
    nvl (a.PREBUILT_STORE_SID,0) = nvl (b.PREBUILT_STORE_SID,0) and
    nvl (a.STORE_STATUS, 'NULL') = nvl (b.STORE_STATUS,'NULL') and
    nvl (a.PRODUCT_COUNT,0) = nvl (b.PRODUCT_COUNT,0) and
    nvl (a.FEATURED_COUNT,0) = nvl (b.FEATURED_COUNT,0) and
    nvl (a.ANNOTATED_COUNT,0) = nvl (b.ANNOTATED_COUNT,0) and
    nvl (a.MERCHANT_COUNT,0) = nvl (b.MERCHANT_COUNT,0) and
    nvl( a.STORE_CREATED_BY, 'NULL') = nvl(b.STORE_CREATED_BY, 'NULL') and
    nvl( a.STORE_UPDATED_BY, 'NULL') = nvl(b.STORE_UPDATED_BY, 'NULL') and
    nvl (a.STORE_CREATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_CREATED_DT,to_date ('01-Jan-00')) and
    nvl (a.STORE_UPDATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_UPDATED_DT,to_date ('01-Jan-00')) and
    nvl (a.PUBLISHER_SID,0) = nvl (b.PUBLISHER_SID,0) and
    nvl (a.PARTNER_SID,0) = nvl (b.PARTNER_SID,0) and
   nvl( a.PUBLISHER_NAME, 'NULL') = nvl(b.PUBLISHER_NAME, 'NULL') and
   nvl( a.PUBLISHER_DESC, 'NULL') = nvl(b.PUBLISHER_DESC, 'NULL') and
   nvl( a.PUBLISHER_TIN_TYPE, 'NULL') = nvl(b.PUBLISHER_TIN_TYPE, 'NULL') and
   nvl( a.PUBLISHER_TAX_ID, 'NULL') = nvl(b.PUBLISHER_TAX_ID, 'NULL') and
   nvl( a.PUBLISHER_TAX_TYPE, 'NULL') = nvl(b.PUBLISHER_TAX_TYPE, 'NULL') and
   nvl( a.PAY_CYCLE_FREQUENCY, 'NULL') = nvl(b.PAY_CYCLE_FREQUENCY, 'NULL') and
   nvl (a.PAY_CYCLE_MONTH,0) = nvl (b.PAY_CYCLE_MONTH,0) and
   nvl (a.PAY_CYCLE_DAY,0) = nvl (b.PAY_CYCLE_DAY,0) and
   nvl( a.PUBLISHER_QUESTION, 'NULL') = nvl(b.PUBLISHER_QUESTION, 'NULL') and
   nvl( a.PUBLISHER_ANSWER, 'NULL') = nvl(b.PUBLISHER_ANSWER, 'NULL') and
   nvl (a.RESPONSE_PRIORITY,0) = nvl (b.RESPONSE_PRIORITY,0) and
   nvl( a.PUBLISHER_URL, 'NULL') = nvl(b.PUBLISHER_URL, 'NULL') and
   nvl (a.LAST_PUBLISHER_LOGIN_DT,to_date('01-Jan-00')) = nvl (b.LAST_PUBLISHER_LOGIN_DT,to_date ('01-Jan-00')) and
   nvl( a.PUBLISHER_STATUS, 'NULL') = nvl(b.PUBLISHER_STATUS, 'NULL') and
   nvl( a.CHARITY, 'NULL') = nvl(b.CHARITY, 'NULL') and
   nvl (a.STORE_NUMBER_NEXTVAL,0) = nvl (b.STORE_NUMBER_NEXTVAL,0) and
   nvl (a.MONTHLY_PAGE_VIEWS,0) = nvl (b.MONTHLY_PAGE_VIEWS,0) and
   nvl (a.MONTHLY_UNIQUE_VISITORS,0) = nvl (b.MONTHLY_UNIQUE_VISITORS,0) and
   nvl( a.PUBLISHER_CREATED_BY, 'NULL') = nvl(b.PUBLISHER_CREATED_BY, 'NULL') and
   nvl( a.PUBLISHER_UPDATED_BY, 'NULL') = nvl(b.PUBLISHER_UPDATED_BY, 'NULL') and
   nvl (a.PUBLISHER_CREATED_DT,to_date('01-Jan-00')) = nvl (b.PUBLISHER_CREATED_DT,to_date ('01-Jan-00')) and
   nvl (a.PUBLISHER_UPDATED_DT,to_date('01-Jan-00')) = nvl (b.PUBLISHER_UPDATED_DT,to_date ('01-Jan-00')) and
   nvl( a.STORE_TYPE_SID, 0) = nvl(b.STORE_TYPE_SID, 0) and
   nvl (a.STORE_TYPE,0) = nvl (b.STORE_TYPE,0) and
   nvl( a.STORE_TYPE_DESC, 'NULL') = nvl(b.STORE_TYPE_DESC, 'NULL') and
   nvl( a.STORE_THEME_SID, 0) = nvl(b.STORE_THEME_SID, 0) and
   nvl (a.STORE_THEME,0) = nvl (b.STORE_THEME,0) and
   nvl( a.STORE_THEME_DESC, 'NULL') = nvl(b.STORE_THEME_DESC, 'NULL') and
   nvl( a.STORE_THEME_STATUS, 'NULL') = nvl(b.STORE_THEME_STATUS, 'NULL') and
   nvl( a.LAYOUT_TEMPLATE_PATH, 'NULL') = nvl(b.LAYOUT_TEMPLATE_PATH, 'NULL') and
   nvl( a.STORE_THEME_CREATED_BY, 'NULL') = nvl(b.STORE_THEME_CREATED_BY, 'NULL') and
   nvl( a.STORE_THEME_UPDATED_BY, 'NULL') = nvl(b.STORE_THEME_UPDATED_BY, 'NULL') and
   nvl (a.STORE_THEME_CREATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_THEME_CREATED_DT,to_date ('01-Jan-00')) and
   nvl (a.STORE_THEME_UPDATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_THEME_UPDATED_DT,to_date ('01-Jan-00')) and
   nvl( a.STORE_SPEC_SID, 0) = nvl(b.STORE_SPEC_SID, 0) and
   nvl (a.STORE_SPEC,0) = nvl (b.STORE_SPEC,0) and
   nvl( a.STORE_SPEC_DESC, 'NULL') = nvl(b.STORE_SPEC_DESC, 'NULL') and
   nvl (a.STORE_SPEC_CREATED_BY,0) = nvl (b.STORE_SPEC_CREATED_BY,0) and
   nvl (a.STORE_SPEC_UPDATED_BY,0) = nvl (b.STORE_SPEC_UPDATED_BY,0) and
   nvl (a.STORE_SPEC_CREATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_SPEC_CREATED_DT,to_date ('01-Jan-00')) and
   nvl (a.STORE_SPEC_UPDATED_DT,to_date('01-Jan-00')) = nvl (b.STORE_SPEC_UPDATED_DT,to_date ('01-Jan-00'));

-- PROMPT Checking DW_STORE_CAT_PROD_GROUP
-- select /*+ PARALLEL (DW_STORE_CAT_PROD_GROUP, 8) */ count(*) from DW_STORE_CAT_PROD_GROUP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CONTENT_TMP3
-- select /*+ PARALLEL (STG_DW_STORE_CONTENT_TMP3, 8) */ count(*) from STG_DW_STORE_CONTENT_TMP3 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CATEGORY_DATE_TMP1
-- select /*+ PARALLEL (STG_STORE_CATEGORY_DATE_TMP1, 8) */ count(*) from STG_STORE_CATEGORY_DATE_TMP1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CATEGORY_DATE_TMP2
-- select /*+ PARALLEL (STG_STORE_CATEGORY_DATE_TMP2, 8) */ count(*) from STG_STORE_CATEGORY_DATE_TMP2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CATEGORY_DATE_TMP3
-- select /*+ PARALLEL (STG_STORE_CATEGORY_DATE_TMP3, 8) */ count(*) from STG_STORE_CATEGORY_DATE_TMP3 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CLICKSTREAM_EXCP
-- select /*+ PARALLEL (STG_STORE_CLICKSTREAM_EXCP, 8) */ count(*) from STG_STORE_CLICKSTREAM_EXCP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CONTENT_TMP1
-- select /*+ PARALLEL (STG_DW_STORE_CONTENT_TMP1, 8) */ count(*) from STG_DW_STORE_CONTENT_TMP1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CONTENT_TMP2
-- select /*+ PARALLEL (STG_DW_STORE_CONTENT_TMP2, 8) */ count(*) from STG_DW_STORE_CONTENT_TMP2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CAT_PROD_GRP_TMP1
-- select /*+ PARALLEL (STG_DW_STORE_CAT_PROD_GRP_TMP1, 8) */ count(*) from STG_DW_STORE_CAT_PROD_GRP_TMP1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CAT_PROD_GRP_TMP2
-- select /*+ PARALLEL (STG_DW_STORE_CAT_PROD_GRP_TMP2, 8) */ count(*) from STG_DW_STORE_CAT_PROD_GRP_TMP2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CAT_PROD_GROUP
-- select /*+ PARALLEL (STG_DW_STORE_CAT_PROD_GROUP, 8) */ count(*) from STG_DW_STORE_CAT_PROD_GROUP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_TEASER_PRODUCT_FACT
-- select /*+ PARALLEL (DW_TEASER_PRODUCT_FACT, 8) */ count(*) from DW_TEASER_PRODUCT_FACT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_CLICKTHRU_LOG_TMP1
-- select /*+ PARALLEL (STG_CLICKTHRU_LOG_TMP1, 8) */ count(*) from STG_CLICKTHRU_LOG_TMP1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_PRODUCT_DETAIL_LOG_TMP1
-- select /*+ PARALLEL (STG_PRODUCT_DETAIL_LOG_TMP1, 8) */ count(*) from STG_PRODUCT_DETAIL_LOG_TMP1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking SERVICE_STATS_STORE_REFERRALS
-- select /*+ PARALLEL (SERVICE_STATS_STORE_REFERRALS, 8) */ count(*) from SERVICE_STATS_STORE_REFERRALS where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_CLICKTHRU_LOG_TMP2
-- select /*+ PARALLEL (STG_CLICKTHRU_LOG_TMP2, 8) */ count(*) from STG_CLICKTHRU_LOG_TMP2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STORE_SID_ID_TMP
-- select /*+ PARALLEL (STORE_SID_ID_TMP, 8) */ count(*) from STORE_SID_ID_TMP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking SERVICE_STATS_STORE_VISITS
-- select /*+ PARALLEL (SERVICE_STATS_STORE_VISITS, 8) */ count(*) from SERVICE_STATS_STORE_VISITS where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_T2_UPD_STORE
-- select /*+ PARALLEL (STG_T2_UPD_STORE, 8) */ count(*) from STG_T2_UPD_STORE where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_STORE_CONTENT_FACT
-- select /*+ PARALLEL (DW_STORE_CONTENT_FACT, 8) */ count(*) from DW_STORE_CONTENT_FACT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_STORE_CATEGORY_DATE_SUM
-- select /*+ PARALLEL (DW_STORE_CATEGORY_DATE_SUM, 8) */ count(*) from DW_STORE_CATEGORY_DATE_SUM where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CAT_DATE_DYN1
-- select /*+ PARALLEL (STG_STORE_CAT_DATE_DYN1, 8) */ count(*) from STG_STORE_CAT_DATE_DYN1 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_LAST_REFERRED_EVENT
-- select /*+ PARALLEL (STG_LAST_REFERRED_EVENT, 8) */ count(*) from STG_LAST_REFERRED_EVENT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_PRODUCT_DETAIL_LOG_TMP2
-- select /*+ PARALLEL (STG_PRODUCT_DETAIL_LOG_TMP2, 8) */ count(*) from STG_PRODUCT_DETAIL_LOG_TMP2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_T1_BU
-- select /*+ PARALLEL (STG_STORE_T1_BU, 8) */ count(*) from STG_STORE_T1_BU where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_NEW_REFERRED_EVENT
-- select /*+ PARALLEL (STG_NEW_REFERRED_EVENT, 8) */ count(*) from STG_NEW_REFERRED_EVENT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_COMMERCELINK_FACT
-- select /*+ PARALLEL (DW_COMMERCELINK_FACT, 8) */ count(*) from DW_COMMERCELINK_FACT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_COMMERCELINK_FACT_FOO
-- select /*+ PARALLEL (DW_COMMERCELINK_FACT_FOO, 8) */ count(*) from DW_COMMERCELINK_FACT_FOO where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_CATEGORY_DATE_DYN2
-- select /*+ PARALLEL (STG_STORE_CATEGORY_DATE_DYN2, 8) */ count(*) from STG_STORE_CATEGORY_DATE_DYN2 where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_REFERRAL_GROUP
-- select /*+ PARALLEL (STG_REFERRAL_GROUP, 8) */ count(*) from STG_REFERRAL_GROUP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_REFERRAL_GROUP_EVENT
-- select /*+ PARALLEL (STG_REFERRAL_GROUP_EVENT, 8) */ count(*) from STG_REFERRAL_GROUP_EVENT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_STORE_CONTACT
-- select /*+ PARALLEL (DW_STORE_CONTACT, 8) */ count(*) from DW_STORE_CONTACT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_CONTACT_EXCP
-- select /*+ PARALLEL (STG_DW_STORE_CONTACT_EXCP, 8) */ count(*) from STG_DW_STORE_CONTACT_EXCP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_STORE_LATEST
-- select /*+ PARALLEL (STG_STORE_LATEST, 8) */ count(*) from STG_STORE_LATEST where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_AFFILIATE_ETL
-- select /*+ PARALLEL (STG_AFFILIATE_ETL, 8) */ count(*) from STG_AFFILIATE_ETL where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_DW_STORE_EXCP
-- select /*+ PARALLEL (STG_DW_STORE_EXCP, 8) */ count(*) from STG_DW_STORE_EXCP where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_TEASER_PRODUCT_FACT_DYN
-- select /*+ PARALLEL (STG_TEASER_PRODUCT_FACT_DYN, 8) */ count(*) from STG_TEASER_PRODUCT_FACT_DYN where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_TPF_EXC_DYN
-- select /*+ PARALLEL (STG_TPF_EXC_DYN, 8) */ count(*) from STG_TPF_EXC_DYN where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_STORE_CLICKSTREAM_FACT
-- select /*+ PARALLEL (DW_STORE_CLICKSTREAM_FACT, 8) */ count(*) from DW_STORE_CLICKSTREAM_FACT where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_PAY
-- select /*+ PARALLEL (DW_PAY, 8) */ count(*) from DW_PAY where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking DW_PPN_TRS
-- select /*+ PARALLEL (DW_PPN_TRS, 8) */ count(*) from DW_PPN_TRS where store_id in (select * from xxx_bdw_xxx);
-- PROMPT Checking STG_PPN_AFFILIATE_ETL
-- select /*+ PARALLEL (STG_PPN_AFFILIATE_ETL, 8) */ count(*) from STG_PPN_AFFILIATE_ETL where store_id in (select * from xxx_bdw_xxx);
