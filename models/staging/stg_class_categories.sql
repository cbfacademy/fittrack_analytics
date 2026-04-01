{{
  config(
    materialized='table',
    tags=['staging', 'clean_data']
  )
}}

with source as (
    select * from {{ source('fitness_dataset', 'class_categories') }}
),


## creating a node_id column (effectively child_id) to create a hierarchy. ##

node_id as (
SELECT

category_id,
LOWER(category_name) as category_name,
ROW_NUMBER() OVER (ORDER BY category_id) AS node_id,
parent_category_id

FROM source
)

## creating a grandparent_category and a category_level for distance from top node)

SELECT
  t1.*,
  t2.parent_category_id AS grandparent_category_id,
 CASE
    WHEN t1.parent_category_id IS NULL THEN 1
    WHEN t2.parent_category_id IS NULL THEN 2
    ELSE 3
  END AS category_level
FROM node_id t1
LEFT JOIN node_id t2
  ON t1.parent_category_id = t2.node_id