with instructors as (

    select *
    from {{ ref('stg_instructors') }}

),

final as (

    select
        instructor_id,
        instructor_first_name,
        instructor_last_name,

        concat(instructor_first_name, ' ', instructor_last_name) as instructor_name,

        speciality,
        club_location

    from instructors

)

select *
from final