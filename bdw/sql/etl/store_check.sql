set lines 300
set pages 300

select   store_sid, 
         store_id, 
	 latest, 
	 created_etl_id, 
	 updated_etl_id, 
	 inserted_dt, 
	 updated_dt, 
	 effective_dt, 
	 expiration_dt,
	 ppn_store_meta_sid,
	 ppn_store_meta_state,
	 ppn_store_meta_created_dt,
	 merchandiser
from     dw_store 
where    store_sid in (select   store_sid 
                       from     dw_store 
		       group by store_sid 
		       having count(*) > 1
		      ) 
and      updated_dt is not null
order by store_sid;
