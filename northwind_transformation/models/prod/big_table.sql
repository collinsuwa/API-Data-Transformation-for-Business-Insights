SELECT
	o."orderId",
	o."orderDate",
	o."shippedDate",
	o."requiredDate",
	o."shipVia" AS shipperId,
	o.freight,
	o."shipName",
	o."shipCity",
	o."shipCountry",
	od."unitPrice",
	od.quantity,
	od.discount,
	sP."productName",
	sP."productId",
	sP."quantityPerUnit",
	sP."unitsInStock",
	sP."unitsOnOrder",
	sP."reorderLevel",
	sP.discontinued,
	sCa."categoryId",
	sCa."categoryName" AS productCategory,
	sSu."supplierId",
	sSu."companyName" AS supplierName,
	sSu."contactName" AS supplierContact,
	sSu."contactTitle" AS supplierTitle,
	sSu.city AS supplierCity,
	sSu.region AS supplierRegion,
	sSu.country AS supplierCountry,
	sC."customerId",
	sC."companyName" AS customerCompanyName,
	sC."contactName" AS customerContactName,
	sC."contactTitle" AS customerContactTitle,
	sC.city AS customerCity,
	sC.region AS customerRegion,
	sC."postalCode" AS customerPostalCode,
	sC.country AS customerCountry,
	sE."employeeId",
	sE."firstName" || ' ' || sE."lastName" AS EmployeeName,
	sE.title AS employeeTitle,
	sE."birthDate" AS employeeBirthDate,
	sE."hireDate" AS employeeHireDate,
	sE.city AS employeeCity,
	sE.region AS employeeRegion,
	sE.country AS employeeCountry,
	sE."postalCode" AS employeePostalCode,
	sE.photo AS employeePhoto,
	sE."photoPath" AS employeePhotoPath,
	sR."regionId",
	sR."regionDescription",
	sh."shipperId",
	sh."companyName" AS shippersCompanyName,
	sT."territoryId",
	sT."territoryDescription"
FROM
    {{ ref('stgOrders') }} o
LEFT JOIN
    {{ ref('stgOrderDetails') }} od
ON 
	o."orderId" = od."orderID"
LEFT JOIN
	{{ ref('stgProducts') }} sP
ON 
	od."productID" = sP."productId"
LEFT JOIN
	{{ ref('stgSuppliers') }} sSu
ON 
	sSu."supplierId" = sP."supplierId"
LEFT JOIN
	{{ ref('stgCustomers') }} sC
ON 
	sC."customerId" = o."customerId"	
LEFT JOIN
	{{ ref('stgCategories') }} sCa
ON 
	sCa."categoryId" = sP."categoryId"
LEFT JOIN
	{{ ref('stgEmployees') }} sE
ON 
	sE."employeeId" = o."employeeId"
FULL OUTER JOIN
	{{ ref('stgShippers') }} sh
ON 
	sh."shipperId" = o."shipVia"
FULL OUTER JOIN
	{{ ref('stgRegions') }} sR
ON 
	sR."regionId"::text = o."shipRegion"
FULL OUTER JOIN
	{{ ref('stgTerritories') }} sT
ON 
	sT."regionId" = sR."regionId"