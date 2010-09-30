select avg (count (dbms_rowid.rowid_row_number(rowid))) avg_rows_per_block
from dw_creative_impress_fact
group by 
dbms_rowid.rowid_object(rowid),
dbms_rowid.rowid_relative_fno(rowid),
dbms_rowid.rowid_block_number(rowid);
