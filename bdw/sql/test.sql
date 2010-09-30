        select
            object_name
        from
            dba_objects
        where
            lower (owner) = lower('TR')
        and
            object_type in ('TABLE', 'VIEW') 
        and 
            object_name not in (
            	select
        	    table_name
        	from
        	    dba_synonyms 
        	where 
        	    lower(table_owner) = lower('TR')
		and 
        	    synonym_name = table_name
        	and	    
            	    lower(owner) = lower('MONITOR')
            );
         
-- alter table dw_creative_impress_fact 
--    split partition part_overflow at (to_date('23-may-2000','dd-mon-yyyy'))
--     into (
--     	partition i_05222000 tablespace DATA1 storage (initial 1M next 1M),
--         partition part_overflow tablespace DATA1 storage (initial 8M next 8M)
--     )
--     parallel 8
-- /	
