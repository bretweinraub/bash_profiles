column    offender format A69
select    directory || '/' || filename || ':' || row_number as offender, 
--    	  dw_store.publisher_home_url,
    	  log_date,
--    	  dwcf.store_sid, 
	  dwcf.teaser_sid, 
	  dwcf.product_sid as product_sid_native,
--	  tpf.product_sid as product_sid_derived,
--	  merchant_name,
--	  dw_product.product,
--	  external_click_id,
--    	  clickthru_type,
    	  client_ip,
	  publisher_home_url,
	  user_agent
--	  referring_url,
--	  redirect_url
from      dw_creative_click_fact dwcf,
    	  dw_input_file,
	  dw_teaser_product_fact tpf,
	  dw_merchant,
	  dw_product,
	  dw_store
where     length (external_click_id) < 29
and       dwcf.dw_input_file_sid = dw_input_file.dw_input_file_sid
and       dwcf.teaser_sid = tpf.teaser_sid
and       tpf.latest = 'T'
and       tpf.merchant_site_id = dw_merchant.merchant_site_id
and       tpf.product_id = dw_product.product_id
--and       log_date between trunc(sysdate - 1) and trunc(sysdate) - (1/86400)
and       dwcf.store_sid = dw_store.store_sid(+)
--and       dw_store.latest(+) = 'T'
order by  log_date
/


