with source as (

    select * from {{ source('fitness_dataset', 'membership_plans') }}

), 

renamed as (

    select
        membership_id, 
        member_id,

        lower(trim(plan_type)) as plan_type, -- standardising the plan type column to lowercase.

        cast(monthly_price as numeric) as monthly_price, -- making sure values are numerical.

        is_active,

        cast(start_date as date) as start_date, -- making sure my date columns are valid.
        cast(end_date as date) as end_date

    from source

)

select * from renamed

