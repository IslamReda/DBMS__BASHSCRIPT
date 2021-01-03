#!/bin/bash

isExist=0
dbList=( $(ls -l ./DBs | grep ^d | awk '{print $9}') )

while true 
do
	clear
	echo "DROP DATABASE"
	echo "_______________________________"
	echo "DATABASES : "
	for db in  ${dbList[*]}
	do
		echo ${db[*]}
	done
	echo "_______________________________"
	echo ""
	echo "DROP (Enter Database Name):"
	read DB_Name
	
	if [ "$DB_Name" = "" ]
	then
		echo "Empty value !!"
		continue
	fi

	for db in  ${dbList[*]}
	do
		if [ "$DB_Name" = "$db" ]; 
        then
			clear
			rm -rf ./DBs/$DB_Name
			echo ""
			echo "Database deleted successfuly..."
			echo ""
			((isExist++))
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; 
    then
		echo "No Such Database"
	fi

	
	echo ""
	echo "Press any key to get back for the Main Menu"
	read
	. ./main.sh
done
