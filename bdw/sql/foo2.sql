select  task_id,
	level l
from    task
start 	with task_id in 
	(
		select 	task_id 
		from 	task 
		where 	parent_task_id is null 
		and 	status in ('running', 'waiting', 'queued') 
		union 	(
				select 	task1.task_id 
				from 	task task1, 
					task task2 
				where 	task1.parent_task_id = task2.task_id 
				and 	task2.status = 'succeeded' 
				and 	task1.status in ('running', 'waiting', 'queued')
			)
	)
connect by prior
	task_id = parent_task_id
order   siblings
by      task_id
/

