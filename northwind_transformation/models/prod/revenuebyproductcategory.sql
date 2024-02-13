-- */Total Sales Revenue by Product Category/
SELECT 
	sCa."categoryName", 
	CEIL(SUM(od."unitPrice" * od.quantity * (1 - od.discount))) AS TotalRevenue
FROM 
    {{ ref('stgCategories') }} sCa
JOIN
	{{ ref('stgProducts') }} sP
ON 
	sP."categoryId" = sCa."categoryId"
JOIN
    {{ ref('stgOrderDetails') }} od
ON 
	od."productID" = sP."productId"
GROUP BY 
	sCa."categoryName"
ORDER BY
	2 DESC
