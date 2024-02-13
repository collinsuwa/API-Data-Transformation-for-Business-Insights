-- */Total Freight/
SELECT 
	ROUND(SUM(freight)) AS total_freight 
FROM 
	{{ ref('stgOrders') }}
    