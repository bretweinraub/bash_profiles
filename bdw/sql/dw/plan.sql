set verify off
column explain_plan format a68
select substr(object_node, 1, 10) Node, lpad(' ',2*level) || operation || ' ' || options || ' ' ||
                object_name explain_plan
from plan_table
where statement_id = '&1'
connect by prior id=parent_id and
        statement_id = '&1'
start with id = 1;


