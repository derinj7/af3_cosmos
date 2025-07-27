-- models/staging/stg_orders.sql
select
    order_id                 as id,
    customer_id,
    order_amount::decimal(12,2) as order_amount,
    order_date::date         as order_date,
    current_timestamp()      as loaded_at
from {{ source('raw', 'orders') }}