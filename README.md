# FitTrack Analytics

dbt project for the FitTrack team sprint.

## Project structure

- `models/staging` → cleaned source data
- `models/intermediate` → joins, transformations, hierarchy logic
- `models/marts` → final fact and dimension tables
- `seeds` → seed data such as date dimension or lookup tables
- `tests` → singular tests
- `macros` → reusable logic and generic tests