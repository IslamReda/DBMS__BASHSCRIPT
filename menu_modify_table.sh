#!/bin/bash

DBName=$1
tableName=$2

while true
do
	clear
	echo "$tableName from $DBName" 
	echo "Select Operation"
	echo "1. SHOW THE Table"
	echo "2. Insert New Record"
	echo "3. Update a Recoed"
	echo "4. Delete a Recoed"
	echo "5. $DBName Menu"
	echo "6. Main Menu"

	read
	case $REPLY in
		1)
			#. ./show_content_table.sh	$DBName $tableName
			. ./show_content_table.sh $DBName $tableName
			break ;;
		2)
			#. ./record_insert.sh $DBName $tableName
			. ./insert_record.sh $DBName $tableName
			break ;;
		3)
			. ./update_record.sh $DBName $tableName
			break ;;
		4)
			. ./delete_record.sh $DBName $tableName
			break ;;
		5)
			. ./menu_table.sh $DBName
			break ;;
		6)
			. ./main.sh 
			break ;;
		*)
            echo "Invalid input"
            ;;
	esac
done