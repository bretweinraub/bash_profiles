-- #############################################################################################
--
-- %Purpose: Drop all objects of the user that executes this script.
--
-- #############################################################################################
--
-- Akadia SQL Utility Scripts
--
-- Requires Oracle 8.1
--
------------------------------------------------------------------------------

PROMPT
PROMPT Generating script to drop the objects...

set pagesize 0
set feedback off
set termout off
set linesize 100
set trimspool on
set wrap on

spool drop_user_objects.lst.sql

PROMPT PROMPT
PROMPT PROMPT Dropping public synonyms...

SELECT 'PROMPT ... dropping public synonym '||synonym_name
,      'drop public synonym '||synonym_name||';'
FROM   all_synonyms
WHERE  table_owner = ( SELECT user
                       FROM   dual
                     )
/

PROMPT PROMPT
PROMPT PROMPT Dropping relational constraints...

SELECT 'PROMPT ... dropping constraint '||constraint_name||' on table '||table_name
,      'alter table '||table_name||' drop constraint '||constraint_name||';'
FROM   user_constraints
WHERE  constraint_type = 'R'
/

PROMPT PROMPT
PROMPT PROMPT Dropping remaining user objects...

select 'PROMPT ... dropping '||object_type||' '||object_name
,      'drop '||object_type||' '||object_name||';'
from   user_objects
WHERE  object_type != 'INDEX'
/

spool off
set feedback on
set termout on
spool drop_user_objects.log
@drop_user_objects.lst.sql

PROMPT
PROMPT All database objects of the user dropped.
PROMPT Please review the log file drop_user_objects.log in the current directory.
PROMPT
PROMPT Count of remaining objects:

set feedback off

SELECT count(*) REMAINING_USER_OBJECTS
FROM   user_objects
/

set feedback on
spool off

quit
