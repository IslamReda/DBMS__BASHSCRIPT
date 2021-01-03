#!/bin/bash



function checkColumnName()
{
    typeset -i flag
    input=$1
    if [ "$input" = "int" -o "$input" = "string" ]
    then
        echo "Input must not be int or string!"
        echo ""
        sleep 2
        clear
        return 2
    elif [ "$input" = "" ]
    then
        echo "Input must not be Empty!"
        echo ""
        sleep 2
        clear
        return 2
    elif [[ $input =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
    then
        # valid input
        return 1
    else
        echo "Syntax Error!"
        echo ""
        sleep 2
        clear
        return 2
    fi
}

function checkTableName()
{
    typeset -i flag
    input=$1
    if [ "$input" = "" ]
    then
        echo "Input must not be Empty!"
        echo ""
        sleep 2
        clear
        return 2
    elif [[ $input =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
    then
        # valid input
        return 1
    else
        echo "Syntax Error!"
        echo ""
        sleep 2
        clear
        return 2
    fi
}
function checkDataSting()
{
    input=$1
    if [[ $input =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
    then
        #valid String
        return 1
    else
        echo "Syntax Error!"
        echo ""
        sleep 2
        return 2
    fi
}
function checkDataInt()
{
    input=$1
    if [[ $input ]] && [ $input -eq $input 2>/dev/null ]
    then
        #valid String
        return 1    
    else
        echo "Input is not an integer or not defined!"
        echo ""
        sleep 2
        return 2
    fi
}

