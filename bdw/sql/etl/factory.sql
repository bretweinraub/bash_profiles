set pages 0
select lower (username) || '/' || lower(password)  || '@' || lower(host) from user_db_links where db_link = 'FACTORY1_SRC';
