with bookings as (

    select *
    from {{ ref('stg_bookings') }}

),

final as (

    select
        booking_id,
        member_id,
        class_id,

        booking_timestamp,
        date(booking_timestamp) as booking_date,

        attendance_status,

        case when attendance_status = 'attended' then true else false end as is_attended,
        case when attendance_status = 'cancelled' then true else false end as is_cancelled,
        case when attendance_status = 'no_show' then true else false end as is_no_show,

        check_in_timestamp,
        cancellation_timestamp

    from bookings

)

select *
from final