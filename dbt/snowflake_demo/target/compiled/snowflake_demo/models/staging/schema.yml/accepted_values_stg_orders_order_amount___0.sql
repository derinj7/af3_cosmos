
    
    

with all_values as (

    select
        order_amount as value_field,
        count(*) as n_records

    from SAMPLE_DB.ANALYTICS.stg_orders
    group by order_amount

)

select *
from all_values
where value_field not in (
    '>=0'
)


