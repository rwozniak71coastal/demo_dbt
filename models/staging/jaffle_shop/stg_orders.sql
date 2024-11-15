-- Get customer orders
WITH ORDERS AS (SELECT ID AS ORDER_ID,
USER_ID AS CUSTOMER_ID,
ORDER_DATE,
STATUS
FROM {{ source('jaffle_shop','orders')}}
WHERE STATUS = 'completed')

SELECT * 
FROM ORDERS