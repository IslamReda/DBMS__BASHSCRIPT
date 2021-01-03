#!/bin/bash

while true
do
	clear
	echo "Existing Databases on the System"
	echo "________________________________"


	dbList=( $(ls -l ./DBs | grep ^d | awk '{print $9}') )


	if [ ${#dbList[*]} -eq 0 ]; 
	then
		echo "No Database has created yet"
	else
		for db in  ${dbList[*]}
		do
			echo ${db[*]}
		done
	fi
	

    echo ""
	echo "Press any key to get back for the Main Menu"
	read
	. ./main.sh

done