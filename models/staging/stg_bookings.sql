with source as (

    select *
    from {{ source('fitness_dataset', 'bookings') }}

),

cleaned as (

    select 
        booking_id,
        member_id,
        class_id,

        cast(booking_timestamp as timestamp) as booking_timestamp,

        lower(trim(attendance_status)) as attendance_status, -- standardising values to lowercase.

        cast(check_in_timestamp as timestamp) as check_in_timestamp,
        cast(cancellation_timestamp as timestamp) as cancellation_timestamp

    from source

)

select *
from cleaned 