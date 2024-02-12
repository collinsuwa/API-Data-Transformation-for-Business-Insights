SELECT	* FROM {{ ref('truecategorybyproduct') }}
	UNION ALL
SELECT * FROM {{ ref('falsecategorybyproduct') }}