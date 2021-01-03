#!/bin/bash

DB_Name=$1
isExist=0
tableList=( $(ls -p ./DBs/$DB_Name | grep -v /) )


while true
do 
	clear
	echo "Use Existing Table in $DB_Name Database"
	echo "_______________________________"
	echo "TABLES : "
	for table in  ${tableList[*]}
	do
		echo ${table[*]}
	done
	echo "_______________________________"
	echo ""
	echo "USE TABLE " 
	read tableName 


	

	for tbl in  ${tableList[*]}
	do
		if [ "$tableName" = "$tbl" ]; then
			((isExist++))
			. ./menu_modify_table.sh $DB_Name $tableName
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; 
	then
		echo ""
		echo "No Such Table..."
	fi

	echo ""
	echo "1) Try Again! "
	echo "2) $DB_Name Menu"
	echo "3) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./select_table.sh $DB_Name
			break ;;
		2)
			. ./menu_table.sh $DB_Name
			break ;;
		3)
			. ./main.sh
			break ;;
	esac
done