-- */To determine Top 10 Product Sales Performance Over Time/
SELECT 
	sP."productName", 
	EXTRACT(YEAR FROM CAST(o."orderDate" AS DATE)) AS OrderYear, 
	SUM(od.quantity) AS TotalQuantity
FROM 
    {{ ref('stgProducts') }} sP
FULL JOIN 
    {{ ref('stgOrderDetails') }} od
ON 
	sP."productId" = od."productID"
FULL JOIN 
	{{ ref('stgOrders') }} o
ON
	od."orderID" = o."orderId"
GROUP BY 
	1, 2
ORDER BY
	3 DESC
LIMIT 
	10