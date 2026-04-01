select * 
from {{ ref('stg_membership_plans') }}
where end_date is not null
  and end_date < start_date 