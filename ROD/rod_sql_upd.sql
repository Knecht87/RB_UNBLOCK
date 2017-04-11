/*!pass-through*/

BEGIN
update vitaliy."APPROVED_SELFBILL"
set "USER_ROD" = user,
"ROD_DATE" = sysdate
where
"BOEKNR" in (
select
"boeknr"
from
(
select distinct
"boeknr",
sum(nvl(substr(vitaliy.getroddebt("dosvlg"),1,
       INSTR(vitaliy.getroddebt("dosvlg"),'/')-1),0))
       as "returned",
sum(nvl(substr(vitaliy.getroddebt("dosvlg"),
       INSTR(vitaliy.getroddebt("dosvlg"),'/')+1,5),0))
       as "total"
from life."cef_dosmut"
where
"boeknr" in (
select distinct
"BOEKNR"
from vitaliy."APPROVED_SELFBILL"
where
"USER_ROD" is null
)
group by
"boeknr"
)
where
"returned" = "total"
);
update vitaliy."APPROVED_SELFBILL"
set "COMMENT" = null,
"APPROVED" = 'Y',
"DATE_APPR" = sysdate,
"DATE_PASS" = sysdate,
"USER_PASSED" = user,
"ID" = 1
where
"USER_ROD" is not null
and "USER_TAR" is not null
and "APPROVED" is null
;
update vitaliy."APPROVED_SELFBILL"
set "COMMENT" = 'edekua TAR/ROD',
"DATE_COM" = sysdate
where
"USER_TAR" is null
and "USER_ROD" is null
and "COMMENT" is not null
;
update vitaliy."APPROVED_SELFBILL"
set "COMMENT" = 'edekua TAR',
"DATE_COM" = sysdate
where
"USER_TAR" is null
and "USER_ROD" is not null
and "COMMENT" is not null
;
COMMIT;
END;
/
