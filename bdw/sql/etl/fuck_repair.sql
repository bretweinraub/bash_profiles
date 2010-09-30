


alter table dw_creative_impress_fact drop partition i_06292000;
alter table dw_creative_impress_fact drop partition i_06282000;

delete from dw_creative_click_fact partition (part_jun_2000) 
where       dw_input_file_sid in 
     (select dw_input_file_sid 
     from    dw_input_file
     where   filename like 'creative-%-v2.2%' 
     and file_type = 'CCTM');
     
 commit;    

alter table dw_creative_click_fact   modify user_cookie varchar2(40);
alter table dw_creative_impress_fact modify user_cookie varchar2(40);

alter table stg_commercelink_fact    drop constraint stg_commercelink_fact_fk01;
alter table dw_commercelink_fact     drop constraint dw_commercelink_fact_fk01;
alter table dw_creative_click_fact   drop constraint dw_creative_click_fact_fk01;

delete from dw_input_file where filename like 'creative-%-v2.2%' and file_type = 'CCTM';

delete from dw_input_file where (filename like '%-20000628-%' or filename like '%-20000629-%') and file_type = 'CIL';

analyze table dw_creative_impress_fact partition (i_06282000) estimate statistics;

analyze table dw_creative_impress_fact partition (i_06292000) estimate statistics;


commit;
