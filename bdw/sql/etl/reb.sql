set timi on
set serverout on

define V_SMALL_EXT=64K
define V_MED_EXT=512K
define V_MIDDLING_EXT=1M
define V_LARGE_EXT=4M
define V_HUGE_EXT=8M

-- I know this looks bizarre ... but this cartesion product of a table (1,2) allows the
-- created and updated etl_id to be merged

PROMPT beginning sanity check of dw_store
DECLARE 
  bogus NUMBER;
BEGIN
    select /*+ FIRST_ROWS */ count(*) into bogus 
    from   (
    	    select etl_id 
	    from   (
	    	    select distinct etl_id 
		    from   (
		    	    select DECODE (b.x, 1, a.created_etl_id, a.updated_etl_id) etl_id 
			    from   dw_store a, 
			    	   (
				    select * 
				    from   (
				    	    select 1 as x from dual 
					    union all 
					    select 2 as x from dual
					    )
				    ) b
			    )
	           ) A     	
    	    where  A.etl_id 
	    not in (
	    	    select distinct etl_id from dw_etl_control_log
		   )
	   );  
    if bogus <> 0 THEN
	raise_application_error (-20999, bogus || ' orphaned etl_id(s) exist in dw_store');	   
    end if;
END;
/
PROMPT dw_store looks clean

DECLARE
	no_table	EXCEPTION;
	PRAGMA		EXCEPTION_INIT (no_table, -942);
BEGIN
    execute immediate 'drop table dw_store_rebuild_step1_dyn';
EXCEPTION	
    WHEN no_table THEN
	NULL;
END;
/

	
create table dw_store_rebuild_step1_dyn parallel unrecoverable 
as 
    select rownum as line_number, 
    	   s.* 
    from (
    	    select /*+ PARALLEL (dw_store, 8) */ store_sid, 
	    	   start_window_dt, 
		   dw_store.rowid as dw_store_rowid 
	    from   dw_store, 
	    	   dw_etl_control_log 
	    where  dw_store.created_etl_id = dw_etl_control_log.etl_id 
	    order by store_sid, start_window_dt
	 ) s;

alter table dw_store_rebuild_step1_dyn parallel 1;

-- we need to create a 'dummy' end record so that when dw_store_rebuild_step1_dyn is 
-- joined to itself (where line_number is off by 1), we'll get all the source rows.

insert into dw_store_rebuild_step1_dyn select max(line_number) + 1 , -1 , TO_DATE(NULL), NULL from dw_store_rebuild_step1_dyn;

create index dw_store_rebuild_step1_idx1 on dw_store_rebuild_step1_dyn (line_number);

DECLARE
	no_table	EXCEPTION;
	PRAGMA		EXCEPTION_INIT (no_table, -942);
BEGIN
    execute immediate 'drop table dw_store_rebuild_step2_dyn';
EXCEPTION	
    WHEN no_table THEN
	NULL;
END;
/

create table dw_store_rebuild_step2_dyn
(
    ppn_store_meta_sid number(15), 
    ppn_store_meta_state varchar2 (10), 
    ppn_store_meta_created_dt DATE, 
    merchandiser varchar2 (30)
) nologging;

-- insert into dw_store_rebuild_step2_dyn values (NULL, NULL, NULL, NULL);

create table dw_store_rebuild_step2_dyn nologging as select * from ppn_store_meta@factory1_src;

DECLARE
	no_table	EXCEPTION;
	PRAGMA		EXCEPTION_INIT (no_table, -942);
BEGIN
    execute immediate 'drop table dw_store_rebuild_step3_dyn';
EXCEPTION	
    WHEN no_table THEN
	NULL;
END;
/

create table dw_store_rebuild_step3_dyn nologging pctfree 50 
as 
    select /*+ PARALLEL (a, 8) */ a.store_sid, 
    	   a.start_window_dt, 
	   a.dw_store_rowid, 
	   b.store_sid as next_store_sid, 
	   b.start_window_dt as next_start_window_dt, 
	   to_date(null) as effective_dt, 
	   to_date(NULL)  as expiration_dt , 
	   c.ppn_store_meta_sid,
	   c.ppn_store_meta_state,
	   c.created_dt as ppn_store_meta_created_dt,
	   c.merchandiser
    from   dw_store_rebuild_step1_dyn a, 
    	   dw_store_rebuild_step1_dyn b, 
	   dw_store_rebuild_step2_dyn c
    where  a.line_number = b.line_number - 1
    and    a.store_sid = c.store_sid (+)
;

-- get the 'last' row out of 
insert into dw_store_rebuild_step3_dyn

commit;

alter session enable parallel dml;

update /*+ PARALLEL (dw_store_rebuild_step3_dyn, 8) */ dw_store_rebuild_step3_dyn 
set    effective_dt = start_window_dt, 
       expiration_dt = to_date ('31-DEC-9999', 'DD-MON-YYYY') 
where  store_sid <> next_store_sid;

commit;

update /*+ PARALLEL (dw_store_rebuild_step3_dyn, 8) */ dw_store_rebuild_step3_dyn 
set    effective_dt = start_window_dt, 
       expiration_dt = (next_start_window_dt - (1/86400)) 
where  store_sid = next_store_sid;

commit;

DECLARE
	no_table	EXCEPTION;
	PRAGMA		EXCEPTION_INIT (no_table, -942);
BEGIN
    execute immediate 'drop table dw_store_new';
EXCEPTION	
    WHEN no_table THEN
	NULL;
END;
/

CREATE TABLE dw_store_new
 (
  store_id                   NUMBER(15),
  store_sid                  NUMBER(15),
  store_name                 VARCHAR2(100),
  store_desc                 VARCHAR2(500),
  store_number               NUMBER,
  partition                  NUMBER,
  search_string              VARCHAR2(1000),
  publisher_home_url         VARCHAR2(500),
  splash_text                VARCHAR2(500),
  prebuilt_store_sid         NUMBER(15),
  store_status               VARCHAR2(1),
  product_count              NUMBER(15),
  featured_count             NUMBER(15),
  annotated_count            NUMBER(15),
  merchant_count             NUMBER(15),
  store_created_by           VARCHAR2(20),
  store_updated_by           VARCHAR2(20),
  store_created_dt           DATE,
  store_updated_dt           DATE,
  publisher_sid              NUMBER(15),
  partner_sid                NUMBER(15),
  publisher_name             VARCHAR2(50),
  publisher_desc             VARCHAR2(150),
  publisher_tin_type         VARCHAR2(3),
  publisher_tax_id           VARCHAR2(20),
  publisher_tax_type         VARCHAR2(30),
  pay_cycle_frequency        VARCHAR2(10),
  pay_cycle_month            NUMBER,
  pay_cycle_day              NUMBER,
  publisher_question         VARCHAR2(100),
  publisher_answer           VARCHAR2(50),
  response_priority          NUMBER(10),
  publisher_url              VARCHAR2(500),
  last_publisher_login_dt    DATE,
  publisher_status           VARCHAR2(1),
  charity                    VARCHAR2(1),
  store_number_nextval       NUMBER(*,0),
  monthly_page_views         NUMBER(15),
  monthly_unique_visitors    NUMBER(15),
  publisher_created_by       VARCHAR2(20),
  publisher_updated_by       VARCHAR2(20),
  publisher_created_dt       DATE,
  publisher_updated_dt       DATE,
  store_type_sid             NUMBER(15),
  store_type                 VARCHAR2(30),
  store_type_desc            VARCHAR2(100),
  store_theme_sid            NUMBER(15),
  store_theme                VARCHAR2(30),
  store_theme_desc           VARCHAR2(100),
  store_theme_status         VARCHAR2(1),
  layout_template_path       VARCHAR2(500),
  store_theme_created_by     VARCHAR2(20),
  store_theme_updated_by     VARCHAR2(20),
  store_theme_created_dt     DATE,
  store_theme_updated_dt     DATE,
  store_spec_sid             NUMBER(15),
  store_spec                 VARCHAR2(30),
  store_spec_desc            VARCHAR2(100),
  store_spec_created_by      NUMBER(15),
  store_spec_updated_by      NUMBER(15),
  store_spec_created_dt      DATE,
  store_spec_updated_dt      DATE,
  latest                     VARCHAR2(1),
  updated                    VARCHAR2(1),
  created_etl_id             NUMBER(15),
  updated_etl_id             NUMBER(15),
  store_created_by_user_login  VARCHAR2(20),
  store_created_by_user_status  VARCHAR2(1),
  store_updated_by_user_login  VARCHAR2(20),
  store_updated_by_user_status  VARCHAR2(1),
  store_url                  VARCHAR2(500),
-- PPN META DATA
  ppn_store_meta_sid         NUMBER(15),
  ppn_store_meta_state       VARCHAR2(10),
  ppn_store_meta_created_dt  DATE, 
  merchandiser               VARCHAR2(30), 
-- LOCAL DATA  
  effective_dt               DATE,                    -- date this row became effective
  expiration_dt              DATE,                    -- date this row expired.
  inserted_dt                DATE,                    -- date this row was inserted (auditing)
  updated_dt                 DATE                     -- date this row was updated (auditing)
 )
 NOLOGGING   
 PCTFREE    0
 TABLESPACE data1
 INITRANS   8
 STORAGE   (
      FREELISTS   8
      INITIAL     &V_SMALL_EXT
      NEXT        &V_MIDDLING_EXT
      PCTINCREASE 0
      MINEXTENTS  1
      MAXEXTENTS  2000
   )
/

insert /*+ APPEND PARALLEL (new, 8) */ into dw_store_new 
(
  store_id,
  store_sid,
  store_name,
  store_desc,
  store_number,
  partition,
  search_string,
  publisher_home_url,
  splash_text,
  prebuilt_store_sid,
  store_status,
  product_count,
  featured_count,
  annotated_count,
  merchant_count,
  store_created_by,
  store_updated_by,
  store_created_dt,
  store_updated_dt,
  publisher_sid,
  partner_sid,
  publisher_name,
  publisher_desc,
  publisher_tin_type,
  publisher_tax_id,
  publisher_tax_type,
  pay_cycle_frequency,
  pay_cycle_month,
  pay_cycle_day,
  publisher_question,
  publisher_answer,
  response_priority,
  publisher_url,
  last_publisher_login_dt,
  publisher_status,
  charity,
  store_number_nextval,
  monthly_page_views,
  monthly_unique_visitors,
  publisher_created_by,
  publisher_updated_by,
  publisher_created_dt,
  publisher_updated_dt,
  store_type_sid,
  store_type,
  store_type_desc,
  store_theme_sid,
  store_theme,
  store_theme_desc,
  store_theme_status,
  layout_template_path,
  store_theme_created_by,
  store_theme_updated_by,
  store_theme_created_dt,
  store_theme_updated_dt,
  store_spec_sid,
  store_spec,
  store_spec_desc,
  store_spec_created_by,
  store_spec_updated_by,
  store_spec_created_dt,
  store_spec_updated_dt,
  latest,
  updated,
  created_etl_id,
  updated_etl_id,
  store_created_by_user_login,
  store_created_by_user_status,
  store_updated_by_user_login,
  store_updated_by_user_status,
  store_url,
  effective_dt,
  expiration_dt,
  ppn_store_meta_sid,
  ppn_store_meta_state,
  ppn_store_meta_created_dt,
  merchandiser
) 
select /*+ FULL PARALLEL (old, 8) */ 
  store_id,
  old.store_sid,
  store_name,
  store_desc,
  store_number,
  partition,
  search_string,
  publisher_home_url,
  splash_text,
  prebuilt_store_sid,
  store_status,
  product_count,
  featured_count,
  annotated_count,
  merchant_count,
  store_created_by,
  store_updated_by,
  store_created_dt,
  store_updated_dt,
  publisher_sid,
  partner_sid,
  publisher_name,
  publisher_desc,
  publisher_tin_type,
  publisher_tax_id,
  publisher_tax_type,
  pay_cycle_frequency,
  pay_cycle_month,
  pay_cycle_day,
  publisher_question,
  publisher_answer,
  response_priority,
  publisher_url,
  last_publisher_login_dt,
  publisher_status,
  charity,
  store_number_nextval,
  monthly_page_views,
  monthly_unique_visitors,
  publisher_created_by,
  publisher_updated_by,
  publisher_created_dt,
  publisher_updated_dt,
  store_type_sid,
  store_type,
  store_type_desc,
  store_theme_sid,
  store_theme,
  store_theme_desc,
  store_theme_status,
  layout_template_path,
  store_theme_created_by,
  store_theme_updated_by,
  store_theme_created_dt,
  store_theme_updated_dt,
  store_spec_sid,
  store_spec,
  store_spec_desc,
  store_spec_created_by,
  store_spec_updated_by,
  store_spec_created_dt,
  store_spec_updated_dt,
  latest,
  updated,
  created_etl_id,
  updated_etl_id,
  store_created_by_user_login,
  store_created_by_user_status,
  store_updated_by_user_login,
  store_updated_by_user_status,
  store_url,
  effective_dt,
  expiration_dt,
  ppn_store_meta_sid,
  ppn_store_meta_state,
  ppn_store_meta_created_dt,
  merchandiser
 from  dw_store old, 
       dw_store_rebuild_step3_dyn
 where dw_store.ROWID = dw_store_rebuild_step3_dyn.dw_store_rowid
/

commit;

alter table dw_store_new parallel 1;

drop index dw_store_idx1
/

drop index dw_store_idx2
/

drop index dw_store_idx3
/

drop index dw_store_idx4
/

drop index dw_store_idx5
/

drop index dw_store_idx6
/

drop index dw_store_idx7
/

CREATE INDEX "DW_STORE_IDX1" ON "DW_STORE_NEW" ("STORE_NAME" )  
PCTFREE 0 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_LARGE_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX2" ON "DW_STORE_NEW" ("STORE_SID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_MED_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX3" ON "DW_STORE_NEW" ("PUBLISHER_NAME" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_LARGE_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX4" ON "DW_STORE_NEW" ("PUBLISHER_SID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_MED_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX5" ON "DW_STORE_NEW" ("STORE_URL" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_LARGE_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX6" ON "DW_STORE_NEW" ("STORE_ID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_MED_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
CREATE INDEX "DW_STORE_IDX7" ON "DW_STORE_NEW" ("PARTNER_SID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 STORAGE(INITIAL &V_SMALL_EXT NEXT &V_MED_EXT MINEXTENTS 1 MAXEXTENTS 2000 PCTINCREASE 0
 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "INDEX1" NOLOGGING PARALLEL ( DEGREE 4 INSTANCES 1)
 /
 
alter table dw_store rename to dw_store_old;

alter table dw_store_new rename to dw_store;

drop table dw_store_rebuild_step1_dyn;
drop table dw_store_rebuild_step2_dyn;
drop table dw_store_rebuild_step3_dyn;
