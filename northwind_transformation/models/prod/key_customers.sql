-- */To determine the Northwind traders Key Customers/
SELECT
	sC."customerId",
	sC."companyName",
    ROUND(SUM(od.quantity * od."unitPrice")) AS customersTotalSpent
FROM
    {{ ref('stgCustomers') }} sC
JOIN
	{{ ref('stgOrders') }} o
ON 
	o."customerId" = sC."customerId"
JOIN
	{{ ref('stgOrderDetails') }} od
ON
	o."orderId" = od."orderID"
GROUP BY
	1, 2
ORDER BY
    customersTotalSpent DESC
	