
set serverout on

DECLARE
  o_i NUMBER;
  o_e NUMBER;    
BEGIN
  DW_LOG.debugging := TRUE;

  DW_ETL_STORES.DO_NEW (-666, trunc(sysdate-1), trunc (sysdate), o_i, o_e);
END;
/
