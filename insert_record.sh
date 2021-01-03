#!/bin/bash

DBName=$1
tblName=$2
id=0
isExist=0
typeset -i flag=0

source ./check_data.sh

function getAllColumnNames()
{
    # this command to get all name of columns for check repeated 
    for data in `awk -F: 'BEGIN{OFS=":" } {for (i=2;i<=NF && NR ==1;i+=2){print $i}}' ./DBs/$DBName/$tblName`
	do  
        arrColName[$size]=$data
        size=$size+1
    done
}
function getAllColumnTypes()
{
    # this command to get all name of columns for check repeated 
    for data in `awk -F: 'BEGIN{OFS=":" } {for (i=3;i<=NF && NR ==1;i+=2){print $i}}' ./DBs/$DBName/$tblName`
	do  
        arrColType[$size1]=$data
        size1=$size1+1
    done
}
function checkRepeatedPKeys()
{
    # this command to get all PKeys for check repeated 
	typeset -i ind=0
    for pkey in `awk -F: '{if(NR != 1)print $1}' ./DBs/$DBName/$tblName`
    do
        arrPKeys[ind]=$pkey
        ind=$ind+1
    done

    for((index=0 ; index < ${#arrPKeys[*]} ; index++))
    do
        if [ "$value" = "${arrPKeys[index]}" ]
        then
            flag=1
        fi
    done
}


while true
do
	clear
	echo "Insert New Record into $tblName in $DBName Database"
	echo "___________________________________"
	echo ""
	
	typeset -i size=0
	typeset -i size1=0
	
	getAllColumnNames
	getAllColumnTypes

	typeset -i temp=$size-1
	for ((in=0 ; in < $size ; in++))
	do
		echo "${arrColName[$in]} : " 
		read value
		checkRepeatedPKeys
		if test $flag -eq 0
		then
			if [ "${arrColType[$in]}" == "sting" ]
			then
				checkDataSting $value
				checkFlag=$?
				if [ $checkFlag -eq 2 ]
				then
					continue 2
				fi
			elif [ "${arrColType[$in]}" == "int" ]
			then
				checkDataInt $value
				checkFlag=$?
				if [ $checkFlag -eq 2 ]
				then
					continue 2
				fi
			fi
		
			if [ $in -eq $temp ]
			then
				printf "$value"  >> ./DBs/$DBName/$tblName
			else
				printf "$value:"  >> ./DBs/$DBName/$tblName
			fi
		else
			echo "you entered repeated primary key"
            flag=0
			sleep 2
			continue 2
		fi
	done

	printf "\n" >> ./DBs/$DBName/$tblName

	echo ""
	echo "Data inserted successfully"
	
	echo ""
	echo "1) Inert new Record "
	echo "2) $tblName Menu"
	echo "3) $DBName Menu"
	echo "4) Main Menu!"

	read

	case $REPLY in
		1)
			. ./insert_record.sh $DBName $tblName
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