
DECLARE 
    cursor c1 is 
    	select /*+ PARALLEL (dw_store, 8) */ distinct store_sid from dw_store;
    cursor all_rows (store_sid dw_store.store_sid%TYPE)	IS
    
   
BEGIN
    FOR rec IN c1 
    LOOP
    	
    
    END LOOP;
END;    



















