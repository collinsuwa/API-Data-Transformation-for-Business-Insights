-- */To determine the Shipping cost analysis/
SELECT
	sh."shipperId",
	sh."companyName" AS shippingCompanyName,
    ROUND(AVG(o.freight)) AS AverageShippingCost
FROM
    {{ ref('stgShippers') }} sh
JOIN
	{{ ref('stgOrders') }} o
ON
	o."shipVia" = sh."shipperId"	
GROUP BY
    1, 2
ORDER BY
    AverageShippingCost DESC