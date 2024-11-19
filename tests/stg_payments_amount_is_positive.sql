with payments as ( SELECT * FROM {{ref("stg_payments")}}
)

SELECT orderid, 
SUM(amount) as total_amount
FROM payments 
GROUP BY orderid
HAVING total_amount < 0