-- */To analyze sales performance across different regions/
SELECT
	sR."regionId",
	sR."regionDescription",
	sT."territoryDescription",
	COUNT(sT."territoryId") AS numberOfTerritory
FROM
	{{ ref('stgTerritories') }} sT
FULL JOIN
    {{ ref('stgRegions') }} sR
ON 
	sR."regionId" = sT."regionId"
GROUP BY
	1, 2, 3
ORDER BY
	4 DESC
LIMIT 10