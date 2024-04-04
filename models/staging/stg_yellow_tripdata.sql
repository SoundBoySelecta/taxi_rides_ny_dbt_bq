{{ config(materialized='view') }}
 
with tripdata as 
(
  select *,
    row_number() over(partition by VendorID, tpep_pickup_datetime) as rn
  from {{ source('staging','yellow_tripdata') }}
  where VendorID is not null 
)
select
   -- identifiers
    {{ dbt_utils.generate_surrogate_key(['VendorID', 'tpep_pickup_datetime']) }} as trip_id,    
    {{ dbt.safe_cast("VendorID", api.Column.translate_type("integer")) }} as vendor_id,
    {{ dbt.safe_cast("RatecodeID", api.Column.translate_type("integer")) }} as ratecode_id,
    {{ dbt.safe_cast("pickup_location_id", api.Column.translate_type("integer")) }} as pickup_location_id,
    {{ dbt.safe_cast("dropoff_location_id", api.Column.translate_type("integer")) }} as dropoff_location_id,

    -- timestamps
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    {{ dbt.safe_cast("passenger_count", api.Column.translate_type("integer")) }} as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    -- yellow cabs are always street-hail
    1 as trip_type,
    
    -- payment info
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
    cast(0 as numeric) as ehail_fee,
    cast(imp_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    coalesce({{ dbt.safe_cast("payment_type", api.Column.translate_type("integer")) }},0) as payment_type,
    {{ get_payment_type_description('payment_type') }} as payment_type_description
from tripdata
where rn = 1

-- dbt build --select <model.sql> --vars '{'is_test_run: false}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}


-- VendorID
-- tpep_pickup_datetime
-- tpep_dropoff_datetime
-- passenger_count
-- trip_distance
-- RatecodeID
-- store_and_fwd_flag
-- payment_type
-- fare_amount
-- extra
-- mta_tax
-- tip_amount
-- tolls_amount
-- imp_surcharge
-- airport_fee
-- total_amount
-- pickup_location_id
-- dropoff_location_id
-- data_file_year
-- data_file_month