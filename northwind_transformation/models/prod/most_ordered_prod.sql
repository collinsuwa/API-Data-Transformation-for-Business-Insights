-- */To determine the most ordered product/
SELECT 
	"productID",
	COUNT("orderID") AS NO_OF_TIMES_PRODUCT_ORDERED
FROM 
	{{ ref('stgOrderDetails') }}
GROUP BY 
	"productID"
ORDER BY
	2 DESC
