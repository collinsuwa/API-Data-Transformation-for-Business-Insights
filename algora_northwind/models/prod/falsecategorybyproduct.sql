-- */To determine products by category where discontinued is FALSE/
SELECT
	sCa."categoryName",
	p."productName",
	p."quantityPerUnit",
	p."unitsInStock",
	p.discontinued
FROM
	{{ ref('stgCategories') }} AS sCa
INNER JOIN
	{{ ref('stgProducts') }} AS p
ON 
	p."categoryId" = sCa."categoryId"
WHERE
	p.discontinued = FALSE AND p."unitsInStock" IS NOT NULL
GROUP BY
	1, 2, 3, 4, 5
ORDER BY
	4 DESC
LIMIT
	10