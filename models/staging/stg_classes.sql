with source as (
    select * from {{ source('fitness_dataset', 'classes') }}
),

staged as (
    select
        
        cast(class_id as integer) as class_id,
        
        cast(instructor_id as integer) as instructor_id,
        
        cast(category_id as integer) as category_id,

        initcap(trim(class_name)) as class_name,

        trim(club_location) as club_location,
        
        cast(scheduled_start as timestamp) as start_time,

        cast(scheduled_end as timestamp) as end_time,

        -- Calculating duration_minutes
        timestamp_diff(
            cast(scheduled_end as timestamp), 
            cast(scheduled_start as timestamp), 
            minute
        ) as duration_minutes

    from source
)

select * from staged