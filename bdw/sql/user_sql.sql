SELECT  s.sid, 
        t.sql_text
FROM    v$session               s,
        v$sqltext_with_newlines t
WHERE   s.type = 'USER'
  AND   s.sql_address    = t.address (+)
  AND   s.sql_hash_value = t.hash_value (+)
  and   s.sid = &sid
ORDER BY s.sid, t.piece;
