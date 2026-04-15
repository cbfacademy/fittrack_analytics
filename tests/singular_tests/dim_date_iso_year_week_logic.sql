select *
from {{ ref('dim_date') }}
where
    (
        date_day = '2021-01-01'
        and not (iso_year = 2020 and iso_week_of_year = 53 and year_number = 2021)
    )
    or
    (
        date_day = '2021-01-04'
        and not (iso_year = 2021 and iso_week_of_year = 1 and year_number = 2021)
    )
    or
    (
        date_day = '2020-12-31'
        and not (iso_year = 2020 and iso_week_of_year = 53 and year_number = 2020)
    )