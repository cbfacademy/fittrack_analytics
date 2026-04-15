select *
from {{ ref('dim_date') }}
where (day_of_week in (1, 7) and is_weekend != true)
   or (day_of_week not in (1, 7) and is_weekend != false)