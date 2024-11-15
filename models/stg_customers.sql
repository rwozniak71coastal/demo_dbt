-- Add a config block to materialize as a table
{{
    config(
        materialized="table"
    )
}}

-- Get our customers
WITH CUSTOMERS AS (SELECT ID AS CUSTOMER_ID,
FIRST_NAME,
LAST_NAME
FROM RAW.JAFFLE_SHOP.CUSTOMERS)

SELECT * FROM CUSTOMERS