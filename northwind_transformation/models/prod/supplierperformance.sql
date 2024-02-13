-- */To determine the Supplier Performance by Product Category/
SELECT
	sCa."categoryName",
	sSu."companyName",
	COUNT(sP."productId") AS TotalProductsSupplied
FROM 
    {{ ref('stgCategories') }} sCa
JOIN 
    {{ ref('stgProducts') }} sP
ON 
	sP."categoryId" = sCa."categoryId"
JOIN 
	{{ ref('stgSuppliers') }} sSu
ON 
	sSu."supplierId" = sP."supplierId"
GROUP BY 
	1, 2
ORDER BY
	3 DESC