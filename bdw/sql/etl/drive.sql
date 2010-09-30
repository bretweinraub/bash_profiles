
set timi on

DECLARE
    o_i NUMBER;
    o_e NUMBER;
    o_u NUMBER;
    o_ue NUMBER;
BEGIN
    DW_ETL_STORES.debugging := TRUE;
    DW_ETL_STORES.AUTO (-669, o_i, o_e, o_u, o_ue, TRUE);
END;
/
