#!/bin/bash

# Purpose: a script to demo basic calculator functions with two integers

echo -e "Welcome to the most basic calculator you will ever use in your life, human.\n\n"


echo "Enter your first integer: "
read FIRST_INTEGER

echo "Enter your second integer: "
read SECOND_INTEGER

echo "What do you want to do with these integers? (+ - / *): "
read OPERATOR

case $OPERATOR in
    +)
        RESULT=$(($FIRST_INTEGER + $SECOND_INTEGER))
        echo -e "The sum is: $RESULT\n"
        ;;
    -)
        RESULT=$(($FIRST_INTEGER - $SECOND_INTEGER))
        echo -e "The difference is: $RESULT\n"
        ;;
    \*)
        RESULT=$(($FIRST_INTEGER * $SECOND_INTEGER))
        echo -e "The product is: $RESULT\n"
        ;;
    /)
        if [ $SECOND_INTEGER -ne 0 ]; then
            RESULT=$(($FIRST_INTEGER / $SECOND_INTEGER))
            echo -e "The quotient is: $RESULT\n"
        else 
            echo "No can do. Can't divide by zero. Try again."
        fi
        ;;
    *)
        echo "Invalid operation. Please choose +, -, *, or /."
        ;;       
esac

echo -e "\n\n"


echo "Thanks for using the best calculator in the world (not really)!"