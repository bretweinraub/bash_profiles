delete from DW_CATEGORY  where                  ETL_ID = &&etl_id;
commit;
delete from DW_CATEGORY_PRODUCT_GROUP  where    CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_COMMERCELINK_FACT where created_etl_id = &&etl_id;
commit;
delete from DW_MERCHANT  where                  CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_MERCHANT_DATE_SUM  where         ETL_ID = &&etl_id;
commit;
delete from DW_PARTNER_CONTACT  where           CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PARTNER_CONTRACT  where          CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PARTNER_CONTRACT_OPTION  where   CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PARTNER_CONTRACT_REPORT  where   CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PPN_TRS where                    CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PRODUCT  where                   CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_PRODUCT_FEE  where               ETL_ID = &&etl_id;
commit;
delete from DW_SERVICE_USER  where              CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE  where                     CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CATEGORY  where            ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CATEGORY_DATE_SUM  where   ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CAT_PROD_GROUP  where      CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CLICKSTREAM_FACT  where    CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CONTACT  where             CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CONTENT  where             CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_STORE_CONTENT_FACT  where        CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_TEASER_PRODUCT_FACT  where       CREATED_ETL_ID = &&etl_id;
commit;
delete from DW_ETL_CONTROL_LOG where etl_id = &&etl_id;
commit;

UPDATE	dw_linkshare_transaction
   SET	in_pay_table=0
WHERE	affiliate_event_id IN (
		SELECT	affiliate_event_id
		FROM	dw_pay
		WHERE	created_etl_id=&&etl_id
		  AND	affiliate_event_id IS NOT NULL
	);

commit;
UPDATE	dw_befree_earnings
   SET	in_pay_table=0
WHERE	affiliate_event_id IN (
		SELECT	affiliate_event_id
		FROM	dw_pay
		WHERE	created_etl_id=&&etl_id
		  AND	affiliate_event_id IS NOT NULL
	);
commit;	
UPDATE	dw_befree_first_time_customer
   SET	in_pay_table=0
WHERE	affiliate_event_id IN (
		SELECT	affiliate_event_id
		FROM	dw_pay
		WHERE	created_etl_id=&&etl_id
		  AND	affiliate_event_id IS NOT NULL
	);

commit;

delete from DW_PAY  where                       CREATED_ETL_ID = &&etl_id;
commit;
