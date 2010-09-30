select   /*+ PARALLEL (dw_teaser_product_fact, 8) */ teaser_sid, count(*)
from     dw_teaser_product_fact partition (part_t)
group by teaser_sid
having   count(*) > 1;
