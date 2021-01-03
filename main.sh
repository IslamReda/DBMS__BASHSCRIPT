#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

function printMenu()
{
    clear
	echo "		Welcome To Our The Databae Engine"
	echo ""

	echo "	1. SHOW DATABASES"
	echo "	2. CREATE DATABASE"
	echo "	3. SELECT DATABASE"
	echo "	4. DROP A DATABASE"
	echo "	5. Exit "
}

clear
select db in "SHOW DATABASES"  "CREATE NEW DATABASE"  "SELECT DATABASE" "DROP A DATABASE" "Exit"
do	
	case $REPLY in
		1)
			. ./show_databases.sh
			break 
            ;;
		2)
			. ./create_database.sh 
			break 
            ;;
		3)
			. ./select_database.sh 
			break 
            ;;
		4)
			. ./delete_database.sh 
			break 
            ;;
		5)
			clear
			exit 0
            ;;
        *)
        echo "Invalid input"
        ;;

	esac
done
