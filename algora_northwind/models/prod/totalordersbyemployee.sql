-- */Total Orders by Employee/
SELECT
	sE."employeeId",
	sE."firstName",
	sE."lastName",
	sE."firstName" || ' ' || sE."lastName" AS EmployeeName,
	COUNT(o."orderId") AS TotalOrders
FROM 
	staging."stgEmployees" sE
FULL JOIN 
	staging."stgOrders" o
ON 
	o."employeeId" = sE."employeeId"
GROUP BY
	1, 2, 3, 4
ORDER BY
	5 DESC