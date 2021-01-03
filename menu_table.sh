#!/bin/bash

DB_Name=$1
clear
echo "You are Now Using $DB_Name"
echo "______________________"
echo "Select Operation"
echo "_________________"
select db in "Show Tables"  "Create Table" "Use Table" "Drob Table"  "Back to main menu"
do
    
	case $REPLY in
		1)
			. ./show_tables.sh
			break 
            ;;
		2)
			. ./create_table.sh 
			break 
            ;;
		3)
			. ./select_table.sh 
			break 
            ;;
		4)
			. ./delete_table.sh 
			break 
            ;;
		5)
            clear
			. ./main.sh
			exit 0
            ;;
        *)
            . ./main.sh
			break ;;

	esac
done