--
-- TODO:
-- 
-- 1. This is not valid after 06.29.2000 converts. (bdw)
-- 2. add store and site-home url ... and redirect if its there (bdw)
-- 3. add fraud and crawler logic (jcm) ... DONE ...

spool clt

PROMPT Deriving # of distinct publishers

select count(*) 
from   (
    	select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct publisher_sid 
	from   dw_commercelink_fact partition (part_jun_2000)
	where  log_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') 
	    	    	AND     TO_DATE ('06282000 235959', 'MMDDYYYY HH24MISS')
       ) IV,
       service_stats_legit_pub SSLP
where  IV.publisher_sid=SSLP.publisher_sid
/       

PROMPT Deriving # of distinct storefronts

select count(*) 
from   (
        select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct store_sid,
	                publisher_sid 
	from   dw_commercelink_fact partition (part_jun_2000)
	where  log_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') 
	    	    	and     TO_DATE ('06282000 235959', 'MMDDYYYY HH24MISS')
       ) IV,
       service_stats_legit_pub SSLP
where  IV.publisher_sid=SSLP.publisher_sid
/       

PROMPT Deriving # of distinct commercelinks

select count(*) 
from   (
    	select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct teaser_sid,
	       publisher_sid
	from   dw_commercelink_fact partition (part_jun_2000)
	where  log_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') 
	    	    	and     to_date ('06282000 235959', 'MMDDYYYY HH24MISS')
       ) IV,
       service_stats_legit_pub SSLP
where  IV.publisher_sid=SSLP.publisher_sid
/       

PROMPT Deriving total # of impressions

select  /*+ PARALLEL(CLF, 8) */  
    	count(*) 
from    dw_commercelink_fact partition (part_jun_2000) CLF,
        service_stats_legit_pub SSLP
where   log_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') 
    	         and     to_date ('06282000 235959', 'MMDDYYYY HH24MISS')
and    	CLF.publisher_sid=SSLP.publisher_sid
/

PROMPT Deriving total # of clickthrus

select /* PARALLEL(CSF, 8) */
       count(*) 
from   dw_store_clickstream_fact CSF,
       service_stats_legit_pub SSLP,
       dw_store S
where  S.publisher_sid=SSLP.publisher_sid
and    S.store_id=CSF.store_id
and    CSF.teaser_sid is not null 
and    CSF.click_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') and to_date ('06282000 235959', 'MMDDYYYY HH24MISS')
and    NVL(CSF.fraud_flag,0) = 0
and    CSF.adjustment_id IS NULL
and    CSF.ip_exclusion_id IS NULL
and    CSF.client_ip NOT IN (select ip_addr from dw_ip_exclusion)
/

PROMPT Deriving impression table

set pages 200
column  clickthru_rate Format 9.9999

select   'http://shop.affinia/com' || lower(store_url) as store_url,
    	 top100VIEW.*
from     (	 
          select   * 
          from     (
                    select   CLTVIEW.*, nvl(STOREVIEW.total_clickthrus,0) as total_clickthrus, nvl(STOREVIEW.total_clickthrus,0) / total_impressions AS clickthru_rate
                    from     (
                              select     CLF.* 
                              from       (
                                          select    /*+ PARALLEL(CLF, 8) */ 
                                                    CLF.publisher_sid, 
                                                    CLF.store_sid, 
                                                    CLF.teaser_sid,
                                                    count(*) as total_impressions
                                          from      dw_commercelink_fact partition (part_jun_2000) CLF
                                          where     CLF.log_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') 
                                          and       TO_DATE ('06282000 235959', 'MMDDYYYY HH24MISS')
                                          group by  CLF.publisher_sid, CLF.store_sid, CLF.teaser_sid
                                         ) CLF,
                                         service_stats_legit_pub SSLP
                              WHERE      CLF.publisher_sid=SSLP.publisher_sid
                             ) CLTVIEW,
                             (
                              select    sum(total_clickthrus_by_store) as total_clickthrus,
                                        teaser_sid
                              from      (
                              -- returns in 3:39
                                         select    /*+ PARALLEL (dw_store_clickstream_fact, 8) */
                                                   count(*) as total_clickthrus_by_store, 
                                                   teaser_sid,
                                                   store_id
                                         from      dw_store_clickstream_fact 
                                         where     teaser_sid IS NOT NULL
                                         and       click_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') and to_date ('06282000 235959', 'MMDDYYYY HH24MISS') 
                                         and       NVL(fraud_flag,0) = 0
                                         and       adjustment_id IS NULL
                                         and       ip_exclusion_id IS NULL
                                         and       client_ip NOT IN (
					                             select   ip_addr 
								     from     dw_ip_exclusion
								    )
                                         group by  teaser_sid,
                                                   store_id
                                        ) CSFVIEW,
                                        (
                                         select   DWS.store_id,
                                                  DWS.publisher_sid
                                         from     dw_store DWS,
                                                  service_stats_legit_pub SSLP
                                         where    DWS.publisher_sid = SSLP.publisher_sid                                          
                                        ) PSVIEW
                              where     CSFVIEW.store_id = PSVIEW.store_id
                              group by  teaser_sid
                             ) STOREVIEW
          	  where    CLTVIEW.teaser_sid = STOREVIEW.teaser_sid(+)
                    order by total_impressions desc
                  )   
          where   rownum < 101
	 ) TOP100VIEW,
	 dw_store
where    top100view.store_sid = dw_store.store_sid
/	 

-- old 'storeview'
--                  select    count(*) as total_clickthrus, 
--                            CSF.teaser_sid 
--                  from      dw_store_clickstream_fact CSF,
--		            service_stats_legit_pub SSLP,
--			    dw_store DWS
--                  where     NVL(CSF.fraud_flag,0) = 0
--                  and       CSF.adjustment_id IS NULL
--                  and       CSF.ip_exclusion_id IS NULL
--                  and       CSF.client_ip NOT IN (select ip_addr from dw_ip_exclusion)
--                  and       CSF.click_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') and to_date ('06282000 235959', 'MMDDYYYY HH24MISS') 
--		  and       CSF.store_id = DWS.store_id
--		  and       DWS.publisher_sid = SSLP.publisher_sid
--                  group by  CSF.teaser_sid
