with source as (
    select * from {{ source('fitness_dataset', 'instructors') }}
),

staged as (
    select
        cast(instructor_id as integer) as instructor_id,

        split(trim(instructor_name), ' ')[safe_offset(0)] as instructor_first_name,

        split(trim(instructor_name), ' ')[safe_offset(1)] as instructor_last_name,

        initcap(trim(speciality)) as speciality,

        trim(club_location) as club_location,

        cast(hire_date as date) as hire_date

    from source
)

select * from staged