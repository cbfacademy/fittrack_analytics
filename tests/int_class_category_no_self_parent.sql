select *
from {{ ref('int_class_category_hierarchy') }}
where category_id = parent_category_id