#!/bin/bash

#implemented since 31.01.2016

echo "Started unblocking ROD script"

cd /ua13app/lifeua/ecom/scripts/Unblocking/ROD/

path_scr=/ua13app/lifeua/ecom/scripts/Unblocking/ROD
path_out=/ua13app/lifeua/ecom/scripts/Unblocking/OUT
path_sav=/ua13app/lifeua/ecom/scripts/Unblocking/SAVE
file_log=/ua13app/lifeua/ecom/scripts/Unblocking/LOG/rod.log

. /ua13app/lifeua/.unims

file_name=unblock_rod_`date +'%d%m%Y%H%M'`

echo "Script start ${file_name}" >> ${file_log}

echo "Create file ${file_name}" >> ${file_log}

echo "Creating file"
echo "Starting rod_sql_out.sh"
usu edekua rod_sql_out.sh >> ${path_out}/${file_name}.txt
sleep 5
echo "File ${file_name} created" >> ${file_log}

echo "Data sql updating"
echo "Starting rod_sql_upd_start.sql"

/ua13app/lifeua/ecom/scripts/Unblocking/ROD/rod_sql_upd_start.sql

echo "Data from ${file_name} updated" >> ${file_log}

echo "${file_name} converting"
iconv -f utf8 -t cp1251 ${path_out}/${file_name}.txt > ${path_out}/${file_name}.csv
echo "File ${file_name} converted" >> ${file_log}

echo "Transferring to SAVE"
mv -f ${path_out}/${file_name}.csv ${path_sav}
rm ${path_out}/${file_name}.txt
echo "File transferred to SAVE" >> ${file_log}

echo "End script" >> ${file_log}
echo "End script"
