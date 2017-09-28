geocode_query_template <- "
select
  ##entity_id##,
  nullif(prim_home_address_latitude, 0) as home_latitude,
  nullif(prim_home_address_longitude, 0) as home_longitude,
  nullif(business_address_latitude, 0) as business_latitude,
  nullif(business_address_longitude, 0) as business_longitude,
  nullif(primary_address_latitude, 0) as primary_latitude,
  nullif(primary_address_longitude, 0) as primary_longitude
from cdw.d_entity_mv
"
