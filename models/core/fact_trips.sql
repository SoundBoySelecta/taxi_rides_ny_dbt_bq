-- Save as a Table
{{
    config(
        materialized='table'
    )
}}

-- Create multiple CTE statements 
with 

/*
Create two CTE(s) named green_tripdata and yellow_tripdata, from the view stg_green_tripdata and 
stg_yellow_tripdata created in BQ thus the use of {{ref('stg_green_tripdata')}} and {{ref('stg_yellow_tripdata')}}
add a column 'service type' with all values 'Green' on green_tripdata and "Yellow' on yellow_tripdata for the 
purpose of distinguishability when we union (concat in pandas - row wise join, with same sized matrix, no join on keys) 
*/

green_tripdata as (
    select *,
        'Green' as service_type
    from {{ref('stg_green_tripdata')}}
),

yellow_tripdata as (
    select *,
        'Yellow' as service_type
        from {{ref('stg_yellow_tripdata')}}
),


-- Create a CTE(s) named trips_unioned, from the the CTE(s) and combine them using union all.

trips_unioned as (
    select * from green_tripdata
    union all
    select * from yellow_tripdata
),

/*
Create a CTE named dim_zones, which we create from a table in BQ that we made from building out a csv in seeds 
folder. We created a file under seeds folder, copy and pasted raw csv data, then ran build 
(Note: it was a big file). We built a CTE with a bit of filtering (cleaned 'Unknown').
*/

dim_zones as (
    select * from {{ref('dim_zones')}}
    where borough != 'Unknown'
)


/*
Combine all the CTEs to make the table, pickup zones which is an alias for dim_zones CTE, which in turn was
made from a csv from seeds, column name is 'locationid', avoid confusion.
*/

select *
from trips_unioned
inner join dim_zones as pickup_zone
on trips_unioned.pickup_location_id = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips_unioned.pickup_location_id = dropoff_zone.locationid
