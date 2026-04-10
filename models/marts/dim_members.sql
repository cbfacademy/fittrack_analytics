with members as (

    select *
    from {{ ref('stg_members') }}

),

final as (

    select 
        member_id,
        first_name,
        last_name,
        email,
        missing_email_flag,
        date_of_birth,
        join_date,
        membership_status,
        home_club
    from members

)

select *
from final