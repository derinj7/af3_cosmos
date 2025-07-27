-- models/marts/fct_orders.sql
{{ config(materialized='incremental', unique_key='id') }}

select *
from {{ ref('stg_orders') }}

{% if is_incremental() %}
  where loaded_at > (select max(loaded_at) from {{ this }})
{% endif %}