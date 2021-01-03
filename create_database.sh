#!/bin/bash


isExist=0

source ./check_data.sh


while true
do
	clear
	echo "Create New Databae"
	echo "__________________"
	echo ""
	echo "CREATE DATABASE (Enter Database Name) : " 
	read DB_Name 

	# validate DB name
	checkColumnName $DB_Name
	checkFlag=$?
	if [ $checkFlag -eq 2 ]
	then
		continue
	fi


	#check if database alread exist
	dbList=( $(ls -l ./DBs | grep ^d | awk '{print $9}') )

	for db in  ${dbList[*]}
	do	
		if [ "$DB_Name" = "$db" ]; 
		then
			echo ""
			echo "Database with the same name already exist!.. ."
			((isExist++))
			sleep 0.5
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; then
		mkdir ./DBs/$DB_Name
		echo "Database Created Succefully"
		sleep 0.5
	fi

	echo "1) Main Menu! "
	echo "2) Create Another Database"
	read

	case $REPLY in
		1)
			. ./main.sh
			break ;;
		2)
			. ./create_database.sh
			break ;;
		*)
            . ./main.sh
			break ;;
	esac

done
