-- */To determine the product performance/
SELECT
    sP."productId",
    sP."productName",
    SUM(od.quantity) AS TotalQuantitySold,
    ROUND(SUM(od.quantity * od."unitPrice")) AS TotalRevenue
FROM
    {{ ref('stgProducts') }} sP
JOIN
	{{ ref('stgOrderDetails') }} od
ON 
	sP."productId" = od."productID"
GROUP BY
    1, 2
ORDER BY
    TotalRevenue DESC