-- */To determine the number of times each shipper has shipped each product/
SELECT
    sP."productId",
	sP."productName",
	sh."shipperId",
    sh."companyName" AS shippingCompany,
    COUNT(*) AS NO_OF_TIMES_SHIPPED
FROM
	{{ ref('stgOrders') }} o
JOIN 
    {{ ref('stgOrderDetails') }} od
ON 
	o."orderId" = od."orderID"
JOIN 
    {{ ref('stgProducts') }} sP
ON 
	sP."productId" = od."productID"	
JOIN 
    {{ ref('stgShippers') }} sh
ON 
	sh."shipperId" = o."shipVia"	
GROUP BY 
	1, 2, 3, 4
ORDER BY 
	5 DESC