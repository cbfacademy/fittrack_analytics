{{
  config(
    materialized='table',
    tags=['staging', 'clean_data']
  )
}}

with source as (
    select * from {{ source('fitness_dataset', 'class_categories') }}
)


SELECT

category_id,
LOWER(category_name) as category_name,
CAST(parent_category_id AS INT64) as parent_category_id,
CAST(category_level AS INT64) as category_level

FROM source
