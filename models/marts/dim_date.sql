{{
    config(
        materialized = "table"
    )
}}

## What dates to start and end from, can be adjusted easily ##

with parameters as (

    select
        date('2023-01-01') as start_date,
        date('2050-12-31') as end_date

),

## One row per day ##

date_spine as (

    select
        date_day
    from parameters,
    unnest(generate_date_array(start_date, end_date)) as date_day

)

select

## Day information ##
    date_day,
    extract(dayofweek from date_day) as day_of_week,
    format_date('%A', date_day) as day_of_week_name,
    case
        when extract(dayofweek from date_day) in (1, 7) then true
        else false
    end as is_weekend,
    extract(day from date_day) as day_of_month,
    extract(dayofyear from date_day) as day_of_year,

## Week information ##

    date_trunc(date_day, week(monday)) as week_start_date,
    date_add(date_trunc(date_day, week(monday)), interval 6 day) as week_end_date,
    extract(isoweek from date_day) as week_of_year,

    ## Month information ## 
    format_date('%B', date_day) as month_name,
    extract(month from date_day) as month_of_year,
    date_trunc(date_day, month) as month_start_date,
    date_sub(date_add(date_trunc(date_day, month), interval 1 month), interval 1 day) as month_end_date,

    ## Quarter information ##
    extract(quarter from date_day) as quarter_of_year,
    date_trunc(date_day, quarter) as quarter_start_date,
    date_sub(date_add(date_trunc(date_day, quarter), interval 3 month), interval 1 day) as quarter_end_date,

    ## Year information ##
    extract(year from date_day) as year_number,
    date_trunc(date_day, year) as year_start_date,
    date_sub(date_add(date_trunc(date_day, year), interval 1 year), interval 1 day) as year_end_date
from date_spine
order by date_day