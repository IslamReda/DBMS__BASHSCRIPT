#!/bin/bash

isExist=0
dbList=( $(ls -l ./DBs | grep ^d | awk '{print $9}') )

while true
do
	clear
	echo "Use Existing Databae"
	echo "_______________________________"
	echo "DATABASES : "
	for db in  ${dbList[*]}
	do
		echo ${db[*]}
	done
	echo "_______________________________"
	echo ""
	echo "USE DATABASE (Enter Database Name) :" 
	read DB_Name 



	for db in  ${dbList[*]}
	do
		if [ "$DB_Name" = "$db" ]; then
			clear
			echo ""
			echo "You are now using $DB_Name Database"
			((isExist++))
			. ./menu_table.sh $DB_Name
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; 
	then
		echo ""
		echo "	No Such database"
	fi

	echo ""
	
	echo "1) Main Menu! "
	echo "2) Try Again"
	read

	case $REPLY in
		1)
			. ./main.sh
			break ;;
		2)
			. ./select_database.sh
			break ;;
		*)
            . ./main.sh
			break ;;
	esac
done
