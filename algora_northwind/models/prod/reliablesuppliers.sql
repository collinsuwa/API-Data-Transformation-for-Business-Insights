SELECT
    sSu."supplierId",
    sSu."companyName",
	sSu."city",
	sSu."country",
    COUNT(o."orderId") AS TotalOrders
FROM
	{{ ref('stgSuppliers') }} sSu
JOIN
	{{ ref('stgProducts') }} sP
ON
	sP."supplierId" = sSu."supplierId"
LEFT JOIN
	{{ ref('stgOrderDetails') }} od
ON
	od."productID" = sP."productId"
LEFT JOIN
	{{ ref('stgOrders') }} o
ON 
	o."orderId" = od."orderID"	
WHERE
    o."orderDate" IS NOT NULL -- Filter out orders that haven't been completed
GROUP BY
	sSu."supplierId", sSu."companyName", 3, 4
HAVING
	COUNT(o."orderId") > 10 -- Adjust the threshold based on your criteria for reliability
ORDER BY
	5 DESC
-- Note: This condition assumes that a supplier with more than 10 successful orders is considered reliable.
