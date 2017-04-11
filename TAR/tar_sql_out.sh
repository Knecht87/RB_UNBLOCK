usql -h -n -t\; -e "
/*!pass-through*/
SELECT
\"BOEKNR\"
FROM 
(
	SELECT
	\"BOEKNR\",
	MIN(\"ID\") as \"ID\"
	FROM
	VITALIY.\"TARIFF_BLOCK\"
	WHERE
	\"TRANSF_ID\" = 0
	GROUP BY
	\"BOEKNR\"
)
WHERE
\"ID\" = 1
;
"
