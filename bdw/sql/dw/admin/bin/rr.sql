connect tr/affinia@prod1.world
set pages 1000
select	*
from	tr.remedy_polling
where	ticket_type = 'System Information'
and	created_dt > sysdate - (1/24)
and	remedy_message = 'SBORA1: testing again 1';
exit
