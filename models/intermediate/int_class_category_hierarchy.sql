{{
  config(
    materialized='table',
    tags=['intermediate']
  )
}}

with source as (
    select * from {{ ref('stg_class_categories') }}
),


final as(
SELECT
  t1.category_id,
  t1.category_name,
  t1.parent_category_id,

-- adding all the category_IDs
  t2.parent_category_id AS grandparent_category_id,

-- adding the category names
  t2.category_name AS parent_category_name,
  t3.category_name AS grandparent_category_name,

-- putting IDs and names together
  CASE
    WHEN t1.parent_category_id IS NULL THEN t1.category_id
    WHEN t2.parent_category_id IS NULL THEN t1.parent_category_id
    ELSE t2.parent_category_id
  END AS top_level_category_id,

  CASE
    WHEN t1.parent_category_id IS NULL THEN t1.category_name
    WHEN t2.parent_category_id IS NULL THEN t2.category_name
    ELSE t3.category_name
  END AS top_level_category_name,

-- enforcing category level
  CASE
    WHEN t1.parent_category_id IS NULL THEN 1
    WHEN t2.parent_category_id IS NULL THEN 2
    ELSE 3
  END AS category_level

FROM source t1
LEFT JOIN source t2
  ON t1.parent_category_id = t2.category_id
LEFT JOIN source t3
  ON t2.parent_category_id = t3.category_id)


-- adding columns in the correct order
SELECT
category_id, 
category_name,
parent_category_id,
parent_category_name,
grandparent_category_id,
grandparent_category_name,
top_level_category_id,
top_level_category_name,
category_level

FROM final
