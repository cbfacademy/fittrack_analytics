with classes as (
    select * from {{ ref('stg_classes') }}
),

category_hierarchy as (
    select * from {{ ref('int_class_category_hierarchy') }}
),

instructors as (
    select * from {{ ref('stg_instructors') }}
),

final as (
    select
        -- Class Details
        c.class_id,
        c.class_name,
        c.club_location,
        
        -- Splitting Date and Time
        date(c.start_time) as class_date,
        format_timestamp('%H:%M', c.start_time) as start_time,
        format_timestamp('%H:%M', c.end_time) as end_time,
        
        c.duration_minutes,
        c.capacity,
        
        -- Category Hierarchy (Capitalized)
        initcap(cat.category_name) as category_name,
        initcap(coalesce(cat.parent_category_name, cat.category_name)) as parent_category_name,
        initcap(coalesce(cat.grandparent_category_name, cat.parent_category_name, cat.category_name)) as top_level_category,

        -- Instructor Details
        i.instructor_first_name || ' ' || i.instructor_last_name as instructor_name

    from classes c
    left join category_hierarchy cat 
        on c.category_id = cat.category_id
    left join instructors i 
        on c.instructor_id = i.instructor_id
)

select * from final