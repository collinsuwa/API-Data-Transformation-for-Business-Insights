SELECT
	sc."contactName" AS customerName,
	COUNT(o."orderId") AS numberOfPurchase
FROM
	{{ ref('stgOrders') }} o	
LEFT JOIN
	{{ ref('stgCustomers') }} sC
ON 
	sC."customerId" = o."customerId"
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT
	10