

alter table dw_creative_impress_fact 
    split partition part_apr_2000 at (to_date('17-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_1_16 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_17_30 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_1_16 at (to_date('09-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_1_8 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_9_16 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_1_8 at (to_date('05-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_1_4 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_5_8 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_9_16 at (to_date('13-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_9_12 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_13_16 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_1_4 at (to_date('03-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_1_2 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_3_4 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_5_8 at (to_date('07-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_5_6 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_7_8 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_9_12 at (to_date('11-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_9_10 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_11_12 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_13_16 at (to_date('15-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_13_14 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_15_16 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_1_2 at (to_date('02-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04012000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04022000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_3_4 at (to_date('04-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04032000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04042000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_5_6 at (to_date('06-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04052000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04062000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_7_8 at (to_date('08-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04072000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04082000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_9_10 at (to_date('10-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04092000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04102000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_11_12 at (to_date('12-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04112000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04122000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_13_14 at (to_date('14-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04132000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04142000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_15_16 at (to_date('15-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04152000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04162000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_17_30 at (to_date('25-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_17_24 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_25_31 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_17_24 at (to_date('21-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_17_20 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_21_24 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_25_31 at (to_date('29-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_25_28 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_29_30 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_17_20 at (to_date('19-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_17_18 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_19_20 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_17_18 at (to_date('18-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04172000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04182000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_19_20 at (to_date('20-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04192000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04202000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	


alter table dw_creative_impress_fact 
    split partition i_apr_21_24 at (to_date('23-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_21_22 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_23_24 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_21_22 at (to_date('22-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04212000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04222000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_23_24 at (to_date('24-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04232000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04242000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_25_28 at (to_date('27-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_apr_25_26 tablespace DATA1 storage (initial 6M next 6M),
        partition i_apr_27_28 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_25_26 at (to_date('27-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04252000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04262000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_27_28 at (to_date('28-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04272000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04282000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

alter table dw_creative_impress_fact 
    split partition i_apr_29_30 at (to_date('30-apr-2000','dd-mon-yyyy'))
    into (
    	partition i_04292000 tablespace DATA1 storage (initial 6M next 6M),
        partition i_04302000 tablespace DATA1 storage (initial 6M next 6M)
    )
    parallel 8
/	

