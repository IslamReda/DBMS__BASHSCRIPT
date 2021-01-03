#!/bin/bash

DB_Name=$1

while true
do
	clear
	echo "$DB_Name Database Tables"
	echo ""

	#Using ls -p tells ls to append a slash to entries which are a directory
	#using grep -v / tells grep to return only lines not containing a slash
	tabelList=( $(ls -p ./DBs/$DB_Name | grep -v /) )

	if [ ${#tabelList[*]} -eq 0 ]; 
	then
		echo "Database has no tables"
	else
		for db in  ${tabelList[*]}
		do
			echo ${db[*]}
		done
	fi


	echo ""
	echo "1) $DB_Name Menu"
	echo "2) Main Menu! "

	read 

	case $REPLY in
		1)
			. ./menu_table.sh $DBName
			break ;;
		2)
			. ./main.sh
			break ;;
		*)
            . ./main.sh
			break ;;
	esac
done