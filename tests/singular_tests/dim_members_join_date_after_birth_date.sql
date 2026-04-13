select *
from {{ ref('dim_members') }}
where join_date < date_of_birth
