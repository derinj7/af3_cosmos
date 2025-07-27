
  create or replace   view SAMPLE_DB.ANALYTICS.stg_orders
  
   as (
    -- models/staging/stg_orders.sql
select
    order_id                 as id,
    customer_id,
    order_amount::decimal(12,2),
    order_date::date,
    current_timestamp()      as loaded_at
from SAMPLE_DB.RAW.orders
  );

