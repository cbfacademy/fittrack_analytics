with bookings as (

    select *
    from {{ source('fitness_dataset', 'bookings') }}

),

classes as (

    select *
    from {{ source('fitness_dataset', 'classes') }}

),

joined as (

    select
        bookings.booking_id,
        bookings.member_id,
        bookings.class_id,
        bookings.booking_timestamp,
        bookings.attendance_status,
        bookings.check_in_timestamp,
        bookings.cancellation_timestamp,

        classes.class_name,
        classes.scheduled_start,
        classes.scheduled_end,
        classes.category_id,
        classes.instructor_id,
        classes.club_location

    from bookings
    left join classes
        on bookings.class_id = classes.class_id

),

cleaned as (

    select
        *,
        lower(trim(attendance_status)) as attendance_status_clean
    from joined

),

final as (

    select
        booking_id,
        member_id,
        class_id,
        booking_timestamp,
        attendance_status,
        attendance_status_clean,
        check_in_timestamp,
        cancellation_timestamp,
        class_name,
        scheduled_start,
        scheduled_end,
        category_id,
        instructor_id,
        club_location,

        case
            when attendance_status_clean = 'attended' then true
            else false
        end as attended_flag,

        case
            when attendance_status_clean in ('missed', 'no_show', 'no show') then true
            else false
        end as no_show_flag,

        case
            when attendance_status_clean = 'cancelled' then true
            else false
        end as cancelled_flag,

        case
            when attendance_status_clean = 'attended'
                and check_in_timestamp is null
            then true
            else false
        end as attended_but_no_check_in_flag,

        case
            when attendance_status_clean = 'cancelled'
                and cancellation_timestamp is not null
                and scheduled_start is not null
                and cancellation_timestamp > scheduled_start
            then true
            else false
        end as cancelled_after_class_start_flag,

        case
            when check_in_timestamp is not null
                and scheduled_start is not null
                and check_in_timestamp > scheduled_start
            then true
            else false
        end as late_check_in_flag

    from cleaned

)

select *
from final