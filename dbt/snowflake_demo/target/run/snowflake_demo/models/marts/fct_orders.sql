
  
    

        create or replace transient table SAMPLE_DB.ANALYTICS.fct_orders
         as
        (-- models/marts/fct_orders.sql


select *
from SAMPLE_DB.ANALYTICS.stg_orders


        );
      
  