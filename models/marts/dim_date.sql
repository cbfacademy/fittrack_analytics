{{
    config(
        materialized = "table"
    )
}}

## macro to generate the date_spine with columns already filled in. This model is intended to servce as a dim model providing date information which can then be joined to booking info where needed ##

with date_spine as (

    {{ dbt_date.get_date_dimension("2023-01-01", "2050-12-31") }}

)

select
    date_day,
    day_of_week,
    day_of_week_name,
        case 
        when day_of_week in (1, 7) then true
        else false
    end as is_weekend,
    day_of_month,
    day_of_year,
    week_start_date,
    week_end_date,
    week_of_year,
    month_name,
    month_of_year,
    month_start_date,
    month_end_date, 
    quarter_of_year,
    quarter_start_date,
    quarter_end_date,
    year_number,
    year_start_date,
    year_end_date


from date_spine

