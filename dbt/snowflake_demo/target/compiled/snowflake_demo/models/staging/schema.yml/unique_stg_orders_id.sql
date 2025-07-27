
    
    

select
    id as unique_field,
    count(*) as n_records

from SAMPLE_DB.ANALYTICS.stg_orders
where id is not null
group by id
having count(*) > 1


