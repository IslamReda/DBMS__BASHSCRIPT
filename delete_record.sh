#!/bin/bash
# todo
# work with error in flag

DBName=$1
tblName=$2
isExist=0
d="d"
size=0
typeset -i flagNotFound=0

function getAllPKeys()
{
    typeset -i ind=0
    for pkey in `awk -F: '{if(NR != 1)print $1}' ./DBs/$DBName/$tblName`
    do
        arrPKeys[ind]=$pkey
        ind=$ind+1
    done
}

while true
do
	clear
	echo "Delete a Record from $tblName in  $DBName Database"
	echo "___________________________________"
	echo ""
	echo "DELETE RECORD FROM $tblName where id = " 
	read id 
	echo ""

	if [ "$id" = "" ]
	then
		echo "Empty value !!"
		continue
	fi
	
    #get all pkeys to search 
    getAllPKeys

	size=`awk 'END{print NR}' ./DBs/$DBName/$tblName`
	size=$size-1
    for ((inde=0 ; inde < $size ; inde++ ))
    do
        if [ "$id" = "${arrPKeys[inde]}" ];
        then
			temp=`awk -F: '{if(NR != 1 && $1 =='$id')print NR}' ./DBs/$DBName/$tblName`
			echo "$temp"
            sed -i "${temp}"d ./DBs/$DBName/$tblName > /dev/null 2>&1
            echo "Record deleted successfuly..."
			flagNotFound=1
			break
        fi
    done
    if [ $flagNotFound -eq 0 ]
    then
        echo "ID not founded"
    fi
	
	echo ""
	echo "1) Delete new Record from $tblName"
	echo "2) $tblName Menu"
	echo "3) $DBName Menu"
	echo "4) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./delete_record.sh $DBName $tblName
			break ;;
		2)
			. ./menu_modify_table.sh $DBName $tblName
			break ;;
		3)
			. ./menu_table.sh $DBName
			break ;;
		4)
			. ./main.sh
			break ;;
        *)
            . ./main.sh
			break ;;
	esac
done
