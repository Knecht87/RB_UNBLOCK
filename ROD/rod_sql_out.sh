usql -h -n -t\; -e "
/*!pass-through*/
select
\"boeknr\"
from
(
select distinct
\"boeknr\",
sum(nvl(substr(vitaliy.getroddebt(\"dosvlg\"),1,
       INSTR(vitaliy.getroddebt(\"dosvlg\"),'/')-1),0))
       as \"returned\",
sum(nvl(substr(vitaliy.getroddebt(\"dosvlg\"),
       INSTR(vitaliy.getroddebt(\"dosvlg\"),'/')+1,5),0))
       as \"total\"
from life.\"cef_dosmut\"
where
\"boeknr\" in (
select distinct
\"BOEKNR\"
from vitaliy.\"APPROVED_SELFBILL\"
where
\"USER_ROD\" is null
)
group by
\"boeknr\"
)
where
\"returned\" = \"total\"
;
"
