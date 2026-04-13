select *
from {{ ref('fact_bookings') }}
where
    (attendance_status = 'attended' and (is_attended = false or is_cancelled = true or is_no_show = true))
    or
    (attendance_status = 'cancelled' and (is_attended = true or is_cancelled = false or is_no_show = true))
    or 
    (attendance_status = 'no_show' and (is_attended = true or is_cancelled = true or is_no_show = false))

