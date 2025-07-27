
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

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



  
  
      
    ) dbt_internal_test