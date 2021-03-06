select  task.task_id,
        lpad(' ',3*(l-1)) indent,
        lpad(' ',3*(l-1)) || task.taskname taskname,
        actionname,
        task.status,
        actionpid,
        task.mapper || action.actionmapper mapper,
        actionstatus,
        parent_task_id,
        decode (actionstatus, 'running', to_char((SYSDATE - action.inserted_dt) * (86400)),
                                         (nvl(action.updated_dt,SYSDATE) - action.inserted_dt) * (86400)) secs
from    task,
        (
select task_id,
       l,
       rownum r
from   (
                select  task_id,
                        level l
                from    task
                start with
                        task_id in (select task_id from task where parent_task_id is null and status in ('running', 'waiting', 'queued') union (select task1.task_id from task task1, task task2 where task1.parent_task_id = task2.task_id and task2.status = 'succeeded' and task1.status in ('running', 'waiting', 'queued')))
                connect by prior
                        task_id = parent_task_id
                order   siblings
                by      task_id
)
        ) iv,
        action
where   task.task_id= iv.task_id
and     task.cur_action_id = action.action_id
and     task.status in ('waiting', 'queued','running')
order   by r
/
