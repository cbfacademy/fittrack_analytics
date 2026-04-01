with source as (

    select *
    from {{ source('fitness_dataset', 'members') }}

),

cleaned as (

    select
        member_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,

        case
            when email is null or trim(email) = '' then null
            else trim(email)
        end as email,

        case
            when email is null or trim(email) = '' then true
            else false
        end as missing_email_flag,

        date_of_birth,
        join_date,

        case
            when membership_status is null or trim(membership_status) = '' then 'unknown'
            when lower(trim(membership_status)) = 'active' then 'active'
            when lower(trim(membership_status)) = 'inactive' then 'inactive'
            else 'unknown'
        end as membership_status,

        trim(home_club) as home_club

    from source

)

select *
from cleaned