-- */Total orders per week by Category/
SELECT 
	sC."categoryName",
    COUNT(o."orderId") AS TotalOrders,
	EXTRACT(WEEK FROM CAST(o."orderDate" AS DATE)) AS week,
	EXTRACT(DAY FROM CAST(o."orderDate" AS DATE)) AS day,
	EXTRACT(MONTH FROM CAST(o."orderDate" AS DATE)) AS month,
	EXTRACT(YEAR FROM CAST(o."orderDate" AS DATE)) AS Year
FROM 
	{{ ref('stgOrders') }} o
JOIN 
	{{ ref('stgOrderDetails') }} od
ON
	o."orderId" = od."orderID"
JOIN 
	{{ ref('stgProducts') }} sP
ON 
	od."productID" = sP."productId"
JOIN 
	{{ ref('stgCategories') }} sC
ON
	sC."categoryId" = sP."categoryId" 
GROUP BY 
	sC."categoryName", week, day, month, year
ORDER BY
	2 DESC
LIMIT 10