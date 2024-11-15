-- Develop SQL to build a customer summary table for analysis.

-- Add a config block to materialize as a table
{{
    config(
        materialized="table"
    )
}}

-- Get our customers
WITH CUSTOMERS AS (SELECT * 
FROM {{ ref("stg_customers")}}
),

-- Get customer orders
ORDERS AS (SELECT * 
FROM {{ ref("stg_orders")}}
),

-- Summarize orders by cutomer
CUSTOMER_ORDERS AS (SELECT CUSTOMER_ID,
MIN(ORDER_DATE) AS FIRST_ORDER,
MAX(ORDER_DATE) AS MOST_RECENT_ORDER,
COUNT(*) AS ORDER_COUNT
FROM ORDERS
GROUP BY 1),

-- Return final model
FINAL AS (SELECT CUSTOMERS.CUSTOMER_ID, 
CUSTOMERS.FIRST_NAME,
CUSTOMERS.LAST_NAME,
CUSTOMER_ORDERS.FIRST_ORDER,
CUSTOMER_ORDERS.MOST_RECENT_ORDER,
COALESCE(CUSTOMER_ORDERS.ORDER_COUNT,0) AS ORDER_COUNT
FROM CUSTOMERS 
LEFT JOIN CUSTOMER_ORDERS USING(CUSTOMER_ID) 
)

SELECT * 
FROM FINAL