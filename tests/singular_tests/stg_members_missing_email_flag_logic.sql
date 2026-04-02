select *
from {{ ref('stg_members') }}
where
    (email is null and missing_email_flag = false)
    or (email is not null and missing_email_flag = true)