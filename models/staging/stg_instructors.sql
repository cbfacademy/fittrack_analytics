with source as (
select * from {{ source('fitness_dataset', 'instructors') }}

),

staged as (
SELECT

cast(instructor_id as integer) as instuctor_id,

trim(instructor_name) as instructor_name,

initcap(trim(speciality)) as speciality,

trim(club_location) as club_location,

cast(hire_date as date) as hire_date,

from SOURCE
)

select * from staged