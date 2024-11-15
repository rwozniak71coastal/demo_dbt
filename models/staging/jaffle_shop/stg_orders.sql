-- Add a config block to materialize as a table
{{
    config(
        materialized="table"
    )
}}

-- Get customer orders
WITH ORDERS AS (SELECT USER_ID AS CUSTOMER_ID,
ORDER_DATE,
STATUS
FROM RAW.JAFFLE_SHOP.ORDERS 
WHERE STATUS = 'completed')

SELECT * 
FROM ORDERS