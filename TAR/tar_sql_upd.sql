/*!pass-through*/
BEGIN

UPDATE  vitaliy."APPROVED_SELFBILL"
SET     "USER_TAR" = 'edekua',
	"TAR_DATE" = sysdate
WHERE
"BOEKNR" IN 
(
select
"BOEKNR"
from 
(
select 
"BOEKNR",
min("ID") as "ID"
from vitaliy."TARIFF_BLOCK"
where
"TRANSF_ID" = 0
group by
"BOEKNR"
)
where
"ID" = 1
);

UPDATE  vitaliy."APPROVED_SELFBILL"
set 
"USER_PASSED" = 'edekua',
"DATE_PASS" = sysdate,
"ID" = 1,
"DATE_APPR" = sysdate,
"APPROVED" = 'Y',
"COMMENT" = null
where
"BOEKNR" in 
(
select
"BOEKNR"
from 
(
select 
"BOEKNR",
min("ID") as "ID"
from vitaliy."TARIFF_BLOCK"
where
"TRANSF_ID" = 0
group by
"BOEKNR"
)
where
"ID" = 1
)
and "USER_ROD" is not null
;

UPDATE vitaliy."APPROVED_SELFBILL"
set 
"COMMENT" = 'edekua ROD',
"DATE_COM" = sysdate
where
"BOEKNR" in 
(
select
"BOEKNR"
from 
(
select 
"BOEKNR",
min("ID") as "ID"
from vitaliy."TARIFF_BLOCK"
where
"TRANSF_ID" = 0
group by
"BOEKNR"
)
where
"ID" = 1
)
and "USER_ROD" is null
;

UPDATE  vitaliy."TARIFF_BLOCK"
SET     "TRANSF_ID" = 1
WHERE
"BOEKNR" IN 
(
select
"BOEKNR"
from 
(
select 
"BOEKNR",
min("ID") as "ID"
from vitaliy."TARIFF_BLOCK"
where
"TRANSF_ID" = 0
group by
"BOEKNR"
)
where
"ID" = 1
)
;

COMMIT;
END;
/
