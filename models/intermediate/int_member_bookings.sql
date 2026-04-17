with bookings as (

    select *
    from {{ source('fitness_dataset', 'bookings') }}

),

members as (

    select *
    from {{ ref('stg_members') }}

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

        members.first_name,
        members.last_name,
        members.email,
        members.missing_email_flag,
        members.date_of_birth,
        members.join_date,
        members.membership_status,
        members.home_club

    from bookings
    left join members
        on bookings.member_id = members.member_id

)

select *
from joined