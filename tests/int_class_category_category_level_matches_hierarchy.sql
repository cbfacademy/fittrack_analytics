select *
from {{ ref('int_class_category_hierarchy') }}
where
    (category_level = 1 and parent_category_id is not null)
    or
    (category_level = 2 and (parent_category_id is null or grandparent_category_id is not null))
    or
    (category_level = 3 and (parent_category_id is null or grandparent_category_id is null))
    or
    (category_level not in (1, 2, 3))