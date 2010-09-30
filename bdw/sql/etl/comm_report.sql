
spool clt

PROMPT Deriving # of distinct publishers

select count(*) 
from   (
    	select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct publisher_sid 
	from   dw_commercelink_fact partition (part_jun_2000)
       )
/       

PROMPT Deriving # of distinct storefronts

select count(*) 
from   (
        select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct store_sid 
	from   dw_commercelink_fact partition (part_jun_2000)
       )
/       

PROMPT Deriving # of distinct commercelinks

select count(*) 
from   (
    	select /*+ PARALLEL(dw_commercelink_fact, 8) */ 
	       distinct teaser_sid 
	from   dw_commercelink_fact partition (part_jun_2000)
       )
/       

PROMPT Deriving total # of impressions

select  /*+ PARALLEL(dw_commercelink_fact, 8) */  
    	count(*) 
from    dw_commercelink_fact partition (part_jun_2000)
/

PROMPT Deriving total # of clickthrus

select count(*) 
from   dw_store_clickstream_fact 
where  teaser_sid is not null 
and    click_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') and to_date ('06282000 235959', 'MMDDYYYY HH24MISS')
/

PROMPT Deriving impression table

set pages 200
column  clickthru_rate Format 9.9999
select * 
from   (
        select   CLTVIEW.*, nvl(STOREVIEW.total_clickthrus,0) as total_clickthrus, nvl(STOREVIEW.total_clickthrus,0) / total_impressions AS clickthru_rate
        from     (
                  select   /*+ PARALLEL(dw_commercelink_fact, 8) */ 
                           publisher_sid, 
                           store_sid, 
                           teaser_sid,
                      	 count(*) as total_impressions
                  from     dw_commercelink_fact partition (part_jun_2000)
                  group by publisher_sid, store_sid, teaser_sid
                 ) CLTVIEW,
		 (
                  select    count(*) as total_clickthrus, 
                            teaser_sid 
                  from      dw_store_clickstream_fact 
                  where     click_date between TO_DATE ('01-Jun-2000', 'DD-Mon-YYYY') and to_date ('06282000 235959', 'MMDDYYYY HH24MISS') 
                  group by  teaser_sid
		 ) STOREVIEW
	where    CLTVIEW.teaser_sid = STOREVIEW.teaser_sid(+)
        order by total_impressions desc
       ) 
where rownum < 101;


