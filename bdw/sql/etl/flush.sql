

delete from DW_CREATIVE_IMPRESS_FACT where dw_input_file_sid = &&sid;

delete from dw_creative_click_fact where dw_input_file_sid = &&sid;

delete from dw_commercelink_fact where   dw_input_file_sid = &&sid;

delete from stg_commercelink_fact where   dw_input_file_sid = &&sid;

delete from dw_input_file where dw_input_file_sid = &&sid;

commit;
