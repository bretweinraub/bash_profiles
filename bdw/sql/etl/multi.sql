DECLARE
    cursor c1 is
	select /*+ PARALLEL (dw_store_new, 8) */ 
	       single_stores.store_sid, 
	       start_window_dt,
               dw_store_new.ROWID
	from   (
	    	select   /*+ PARALLEL (dw_store_new, 8) */ 
		         store_sid 
	        from     dw_store_new 
		group by store_sid 
		having   count(*) > 1
	       ) single_stores, 
	       dw_store_new, 
	       dw_etl_control_log
        where  single_stores.store_sid = dw_store_new.store_sid
        and    dw_store_new.created_etl_id = dw_etl_control_log.etl_id
        order  by single_stores.store_sid;    

    firstrow c1%ROWTYPE;
    nextrow c1%ROWTYPE;
    end_date DATE := TO_DATE ('31-DEC-9999', 'DD-MON-YYYY'); 
BEGIN
    open c1;
    fetch c1 into firstrow;
    LOOP
    	IF firstrow.store_sid = nextrow.store_sid
	THEN
	    update dw_store_new
	    set    effective_dt = firstrow.start_window_dt,
	    	   expiration_dt = nextrow.start_window_dt - (1/86400)
	    where  rowid = firstrow.rowid;
        ELSE
	    update dw_store_new
	    set    effective_dt = firstrow.start_window_dt,
	    	   expiration_dt = end_date
	    where  rowid = firstrow.rowid;
        END IF;	    
	firstrow := nextrow;
        fetch c1 into nextrow;
    	EXIT WHEN c1%NOTFOUND; -- exit when last row is fetched
    END LOOP;
    update dw_store_new
    set    effective_dt = firstrow.start_window_dt,
    	   expiration_dt = end_date
    where  rowid = firstrow.rowid;
END;
/    
