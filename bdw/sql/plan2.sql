SELECT LPAD(' ',2*(LEVEL-1))||operation||' '||options
   ||' '||object_name
      ||' '||DECODE(id, 0, 'Cost = '||position) "Query Plan"
         FROM plan_table
	    START WITH id = 0 AND statement_id = '&&1'
	       CONNECT BY PRIOR id = parent_id AND statement_id ='&&1';
	
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    delete from plan_table where statement_id = '&&1';
    commit;
end;
/
    
