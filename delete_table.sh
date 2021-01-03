#!/bin/bash

DB_Name=$1
tableName=$2

isExist=0
# print all tables in this database
tableList=( $(ls -p ./DBs/$DB_Name | grep -v /) )

while true
do
	clear
	echo "Drop Table from $DB_Name Database"
	echo "_______________________________"
	echo "TABLES : "
	for table in  ${tableList[*]}
	do
		echo ${table}
	done
	echo "_______________________________"
	echo "DROP TABLE " 
	read tableName
	echo ""

	if [ "$tableName" = "" ]
	then
		echo "Empty value !!"
		continue
	fi

	for tbl in  ${tableList[*]}
	do
		if [ "$tableName" = "$tbl" ] 
		then
			rm  ./DBs/$DB_Name/$tableName
			echo ""
			echo "Table deleted successfuly..."
			echo ""
			((isExist++))
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; then
			echo ""
		echo "No Such Table"
	fi

	
	echo ""
	echo "1) Drop Another Table "
	echo "2) $DB_Name Menu"
	echo "3) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./delete_table.sh $DBName
			break ;;
		2)
			. ./menu_table.sh $DBName
			break ;;
		3)
			. ./main.sh
			break ;;
	esac
done
