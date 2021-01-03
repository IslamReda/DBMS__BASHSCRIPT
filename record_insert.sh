#!/bin/bash

DBName=$1
tblName=$2
id=0
isExist=0

while 
	clear
	echo ""
	echo ""
	printf "${BWhite}"
	echo "		Insrt New Record into $tblName in  $DBName Database"
	echo "		___________________________________"
	echo ""
	echo ""
	echo ""
	

	header=$(sed -n 1p ./DBs/$DBName/$tblName)
	id=( $(wc -l ./DBs/$DBName/$tblName) )
	((id=id+1))
	printf "\n $id"  >> ./DBs/$DBName/$tblName

	IFS=$','
	for col in $header
	do
		#skip id as we specified it as autoincrement
		if [[ $col = id ]]
		then
			continue
		fi

		printf "${BPurple}"
		echo -ne "	$col : " 
		printf "${BGreen}" 
		read value
		printf ", $value"  >> ./DBs/$DBName/$tblName
	done
	unset IFS

	printf "${BBlue}"
	echo ""
	echo ""
	echo "	Data inserted successfully"
	
	echo ""
	echo ""
	printf "${BCyan}"
	echo "	1) Inert new Record "
	echo "	2) $tblName Menu"
	echo "	3) $DBName Menu"
	echo "	4) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./record_insert.sh $DBName $tblName
			break ;;
		2)
			. ./tbl_menu.sh $DBName $tblName
			break ;;
		3)
			. ./DB_menu.sh $DBName
			break ;;
		4)
			. ./main.sh
			break ;;
	esac
	printf "${cf}" 

do
	:
done
