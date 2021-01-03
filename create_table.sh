#!/bin/bash

DB_Name=$1
colArray=()
isExist=0
typeset -i flag=0

source ./check_data.sh

function checkRepeatedColumn()
{
    typeset -i n=0
    # this command to get all name of columns for check repeated 
    for data in `awk -F: 'BEGIN{OFS=":" } {for (i=2;i<=NF && NR ==1;i+=2){print $i}}' ./DBs/$DB_Name/$tableName`
	do  
        arr[n]=$data
        n=$n+1
    done

    for((in=0 ; in < ${#arr[*]} ; in++))
    do
        if [ "$colName" = ${arr[in]} ]
        then
            flag=1
        fi
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

    for((in=0 ; in < ${#arr[*]} ; in++))
    do
        if [ "$colName" = ${arrPKeys[in]} ]
        then
            flag=1
        fi
    done
}

while true
do
	clear
	echo "Create New Table in $DB_Name Database"
	echo "___________________________________"
	echo "CREATE TABLE " 
	read tableName 
	echo ""

	# validate table name
	checkColumnName $tableName
	checkFlag=$?
	if [ $checkFlag -eq 2 ]
	then
		continue
	fi

	tableList=( $(ls -p ./DBs/$DB_Name | grep -v /) )

	for tbl in  ${tableList[*]}
	do
		if [ "$tableName" = "$tbl" ];
		then
			echo "There is already a table with the same name"
			((isExist++))
			break
		fi
	done

	if [ "$isExist" -eq  0 ]; then
		touch ./DBs/$DB_Name/$tableName
		chmod 777 ./DBs/$DB_Name/$tableName
		read -p  "Number of columns :" colNum
		printf "$colNum"  >> ./DBs/$DB_Name/$tableName
		typeset -i i=0
		while [ $i -ne $colNum ]
		do
			if [ $i -eq 0 ]
			then
				echo "name of primary key :"
			else
	            echo "name of column $i :"
			fi
			read colName
			#check validate the name
			checkColumnName $colName
			checkFlag=$?
			if [ $checkFlag -eq 2 ]
			then
				continue
			fi
			checkRepeatedColumn
            if test $flag -eq 0
            then
				if [ $i -eq 0 ]
				then
					echo "Select primary key datatype :"
				else
                	echo "Select column $i datatype" 
				fi
				select col in "string"  "int"   
				do 
				case $REPLY in
					1) datatype="string"
						break
						;;
					2) datatype="int"
						break
						;;
					*) echo "wrong choice , please enter 1 or 2"
						;;
				esac
				done #end select type

				i=$i+1
				printf ":$colName:$datatype"  >> ./DBs/$DB_Name/$tableName
				
            else
                echo "you entered repeated column name"
                flag=0   
			fi
		done

		
		echo ""
		echo "Table is created successfully..."
		printf "\n" >> ./DBs/$DB_Name/$tableName

	fi


	echo ""
	echo "1) Create another table! "
	echo "2) $DB_Name Menu!"
	echo "3) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./create_table.sh $DBName
			break ;;
		2)
			. ./menu_table.sh $DBName
			break ;;
		3)
			. ./main.sh
			break ;;
		*)
            . ./main.sh
			break ;;
	esac
done