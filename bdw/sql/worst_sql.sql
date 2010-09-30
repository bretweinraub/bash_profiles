SELECT
    hash_value "SQL Stmt ID",
    disk_reads "Physical Reads",
    buffer_gets "Logical Reads",
    sorts "Sorts",
    users_executing "Runs",
    loads "Cache Loads",
    (((disk_reads * 100) + buffer_gets) / 1000) / 
        DECODE(users_executing, NULL, 1000000000, 0, 1000000000, 
        users_executing) "Load"
FROM
    v$sqlarea
WHERE
        disk_reads > 100000
    OR
        buffer_gets > 100000
ORDER BY
    7 DESC
/
