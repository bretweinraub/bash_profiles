explain plan for INSERT /*+ PARALLEL (dw_store_category1_date_sum, 8) APPEND */ INTO dw_store_category1_date_sum
    (
        summary_date,
        publisher_sid,
        store_name,
        category_1_name,
        total_products,
        total_product_detail_views,
        total_click_thrus,
        total_revenue
    )
   SELECT /*+ PARALLEL (dw_store, 8) */
         sd.summary_date,
         st.publisher_sid,
         st.store_name,
         sc.category_1                     category_1_name,
         SUM(sd.product_count)             total_products,
         SUM(sd.product_detail_page_count) total_product_detail_views,
         SUM(sd.click_through_count)       total_click_thrus,
         SUM(sd.total_revenue)             total_revenue
FROM
         dw_store                   st,	 
         (
    	    SELECT  
	    	    stg_store_category_date_dyn2.store_id,
                    stg_store_category_date_dyn2.category_id,'''||
                    l_date ||'''  summary_date,
                    stg_store_category_date_dyn2.product_count               product_count,
                    NVL(stg_store_category_date_tmp3.total_revenue, 0)       total_revenue,
                    NVL(stg_store_category_date_tmp3.click_through_count, 0)  
                       click_through_count,
                    NVL(stg_store_category_date_tmp3.product_detail_page_count, 0) 
                       product_detail_page_count
            FROM    stg_store_category_date_dyn2,
                    stg_store_category_date_tmp3
            WHERE   stg_store_category_date_dyn2.store_id = stg_store_category_date_tmp3.store_id (+) 
	    AND     stg_store_category_date_dyn2.category_id = stg_store_category_date_tmp3.store_category_id (+)
         ) sd,
         dw_store_category          sc
WHERE    sd.category_id = sc.category_id
AND      sd.store_id          = st.store_id
GROUP BY st.publisher_sid,st.store_name,sd.summary_date, sc.category_1;
	       
@?/rdbms/admin/utlxplp
