#/bin/bash
. ./colors.txt

DBName=$1
tblName=$2

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

while true
do
	clear
	echo "$tblName from $DBName" 
	echo ""
	body=$(sed 1d ./DBs/$DBName/$tblName)

	if [ -z "$body" ]
	then 
		echo "Empty Table, no record added yet"
	else
		# loop over the first column   
		getAllColumnNames
		for namee in  ${arrColName[*]}
		do
			printf "${namee[*]}\t     "
		done
		printf "\n"
		echo "---------------------------------------------------------"
		# loop over the second                     
    	IFS=":"
		for row in $body
		do
        	for val in $row     
			do
				# and print values
            	printf "%s\t\t" $val
			done
		done
		unset IFS

		echo ""	
	fi

	
	echo ""
	echo "1) $tblName Menu"
	echo "2) $DBName Menu"
	echo "3) Main Menu!"

	read -s opt

	case $opt in
		1)
			. ./menu_modify_table.sh $DBName $tblName
			break ;;
		2)
			. ./menu_table.sh $DBName
			break ;;
		3)
			. ./main.sh
			break ;;
	esac
done
