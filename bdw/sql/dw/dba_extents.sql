column segment_name format A30
select owner,segment_name,count(*) from dba_extents where owner = 'PPNT' group by owner,segment_name
having count(*) > 5
/
