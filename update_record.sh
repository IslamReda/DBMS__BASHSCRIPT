#!/bin/bash
# todo
# 1- check for pk 
# 2- validate
# 3- wrong column name

DBName=$1
tblName=$2
isExist=0

source ./check_data.sh

function getAllPKeys()
{
    typeset -i ind=0
    for pkey in `awk -F: '{if(NR != 1)print $1}' ./DBs/$DBName/$tblName`
    do
        arrPKeys[ind]=$pkey
        ind=$ind+1
    done
}

function getAllColumnNames()
{
    typeset -i n=0
    # this command to get all name of columns for check repeated 
    for data in `awk -F: 'BEGIN{OFS=":" } {for (i=2;i<=NF && NR ==1;i+=2){print $i}}' ./DBs/$DBName/$tblName`
	do  
        arrColName[n]=$data
        n=$n+1
    done
}

function getColumnNumber()
{
    for((in=0 ; in < ${#arrColName[*]} ; in++))
    do
        #echo "$colName = ${arrColName[in]}   ${#arrColName[*]}"  
        if [ "$colName" = ${arrColName[in]} ]
        then
            ((colNo=$in+1))
            #echo "$colNo"
        fi
    done
}
function getColumnType()
{
    typeset -i coltypeNo=$colNo+1
    for ((indee=0 ; indee < $colNo ; indee++))
    do
        coltypeNo=$coltypeNo+1
    done
    #echo "$coltypeNo  ----- $colNo"
    coltype=`awk -F: '{if(NR == 1){print $'$coltypeNo'}}' ./DBs/$DBName/$tblName`
    #echo "${coltype}"
}

while true
do
	clear
	echo "UPDATE a Record from $tblName in  $DBName Database"
	echo "___________________________________"
	echo ""
	echo "UPDATE RECORD FROM $tblName where id = " 
	read id 
	echo ""

    #get all pkeys to search 
    getAllPKeys



     #get all the names of columns
    getAllColumnNames

    echo "Choose Column that You want to update"
    
    while true
    do
        echo ${arrColName[*]}
        read colName
        for ((inde=0 ; inde < ${#arrColName[*]};inde++))
        do 
            if [ "$colName" = "${arrColName[inde]}" ]
            then
                getColumnNumber
                break 2
            fi
        done
    done
    getColumnType

    oldValue=`awk -F: '{if(NR != 1 && $1=='$id'){print $0;}}' ./DBs/$DBName/$tblName`

    echo "Enter updated value :"
    read upValue
    if [ "$coltype" == "sting" ]
	then
		checkDataSting $upValue
		checkFlag=$?
		if [ $checkFlag -eq 2 ]
		then
			continue
		fi
	elif [ "$coltype" == "int" ]
	then
		checkDataInt $upValue
		checkFlag=$?
		if [ $checkFlag -eq 2 ]
		then
			continue
		fi
	fi
    newValue=`awk -F: 'BEGIN{OFS=":"}{if(NR != 1 && $1=='$id'){$'$colNo'="'$upValue'"; print $0;}}' ./DBs/$DBName/$tblName`
    sed -i 's/'$oldValue'/'$newValue'/g' ./DBs/$DBName/$tblName 2>>errorFile
    if [ $? -eq 0 ]
    then
        echo "Record updated successfuly..."
    else
        echo "Error Please try again..."
    fi
	
	echo ""
	echo "Press any key to get back for the Current Database Menu"
	read
	. ./menu_modify_table.sh $DBName $tblName

done
