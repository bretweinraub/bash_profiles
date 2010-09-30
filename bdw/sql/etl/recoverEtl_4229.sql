set timi on

delete /*+ PARALLEL(DW_COMMERCELINK_FACT,8) */ from DW_COMMERCELINK_FACT where created_etl_id = &&etl_id;
commit;
delete /*+ PARALLEL(DW_PARTNER_CONTRACT,8) */ from DW_PARTNER_CONTRACT  where          CREATED_ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_PARTNER_CONTRACT_OPTION,8) */ from DW_PARTNER_CONTRACT_OPTION  where   CREATED_ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_PARTNER_CONTRACT_REPORT,8) */ from DW_PARTNER_CONTRACT_REPORT  where   CREATED_ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_STORE_CATEGORY,8) */ from DW_STORE_CATEGORY  where            ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_STORE_CATEGORY_DATE_SUM,8) */ from DW_STORE_CATEGORY_DATE_SUM  where   ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_STORE_CLICKSTREAM_FACT,8) */ from DW_STORE_CLICKSTREAM_FACT  where    CREATED_ETL_ID = &&etl_id;
commit;
delete /*+ PARALLEL(DW_TEASER_PRODUCT_FACT,8) */ from DW_TEASER_PRODUCT_FACT  where       CREATED_ETL_ID = &&etl_id;
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

delete /*+ PARALLEL(DW_PAY,8) */  from DW_PAY  where                       CREATED_ETL_ID = &&etl_id;
commit;
