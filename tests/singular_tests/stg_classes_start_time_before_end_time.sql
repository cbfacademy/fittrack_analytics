-- This test looks for any rows where the start_time is logically impossible (i.e., it happens after the end_time).
-- If this query returns any rows, the dbt test will fail.

select
    class_id,
    start_time,
    end_time
from {{ ref('stg_classes') }}
where start_time >= end_time