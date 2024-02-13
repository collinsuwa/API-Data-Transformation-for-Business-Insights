-- */To determine the most Profitable Employee/
SELECT 
	sE."employeeId",
	sE."firstName",
	sE."lastName",
	sE."firstName" || ' ' || sE."lastName" AS EmployeeName,
	COUNT(DISTINCT o."orderId") AS TotalOrders, 
	ROUND(SUM(sP."unitPrice" * od.quantity)) AS TotalProfit
FROM 
	{{ ref('stgEmployees') }} sE
JOIN 
    {{ ref('stgOrders') }} o
ON 
	o."employeeId" = sE."employeeId"
JOIN 
	{{ ref('stgOrderDetails') }} od
ON
	o."orderId" = od."orderID"	
JOIN 
	{{ ref('stgProducts') }} sP
ON 
	sP."productId" = od."productID"	
GROUP BY 
	1, 2, 3, 4
ORDER BY 
	TotalProfit DESC