-- */To determine Sales Trend over time/
SELECT
	EXTRACT(YEAR FROM CAST(o."orderDate" AS DATE)) AS orderYear,
	EXTRACT(MONTH FROM CAST(o."orderDate" AS DATE)) AS orderMonth,
    ROUND(SUM(od."unitPrice" * od.quantity)) AS TotalSales
FROM
    {{ ref('stgOrders') }} o
JOIN
	{{ ref('stgOrderDetails') }} od
ON
	o."orderId" = od."orderID"
GROUP BY
    1, 2
ORDER BY
    3 DESC