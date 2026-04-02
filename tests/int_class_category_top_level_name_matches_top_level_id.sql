select child.*
from {{ ref('int_class_category_hierarchy') }} child
left join {{ ref('int_class_category_hierarchy') }} top_level
    on child.top_level_category_id = top_level.category_id
where child.top_level_category_id is not null
  and child.top_level_category_name != top_level.category_name