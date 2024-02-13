-- */To determine the top most selling product/
with product_sales AS (
	SELECT
		sP."productId",
		sP."productName",
		ROUND(SUM(od."unitPrice" * od.quantity)) AS totalSales	
	FROM
    {{ ref('stgOrderDetails') }} od
	JOIN
		{{ ref('stgProducts') }} sP
	ON
		od."productID" = sP."productId"
	GROUP BY
		1, 2)
SELECT
	"productId",
	"productName"
	totalSales,
	RANK() OVER (ORDER BY totalSales DESC ) AS rankSales
FROM
	product_sales
WHERE 
	"productId" IS NOT NULL
ORDER BY 3 DESC
OFFSET 0 FETCH FIRST 10 ROW ONLY