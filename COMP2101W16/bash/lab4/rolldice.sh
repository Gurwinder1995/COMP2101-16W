#bin/bash
#This script adds a help function for use
function help
{
    echo "First enter a value for number of dice, then a value for number of sides. [#dice 1-6] [#sides 4-20]"
}

if [ "$1" != "" ]; then
    case $1 in
        -h | --help )           help
                                exit
                                ;;
    esac
fi

dice="$1"

#This will asks the user for pic a number 
#read -p "Pick a number of dice between 1-6: " dice

while [[ "$dice" -lt "1" || "$dice" -gt "6" ]]; do
    echo "Incorrect value. You must pick a number of dice between 1-6. Try again."
    read -p "Pick a number of dice between 1-6: " dice
        if [[ "$dice" -eq "" ]]; then
        echo "No input, try again."
        fi
done
#This will ask for choose a dice
echo "You chose $dice dice."

#it would describe sides of dice
sides="$2"

#read -p "Pick a number of sides between 4-20: " sides
#hence, after putting command, error announcements will comeup and ask for another input
while [[ "$sides" -lt "4" || "$sides" -gt "20" ]]; do
    echo "Incorrect entry. You must pick a number of dice between 4-20. Try again."
    read -p "Pick a number of sides between 4-20: " sides
        if [[ $sides -eq "" ]]; then
        echo "No input, try again."
        fi
done
#final results would be declared
echo "You chose $dice dice with $sides sides."

#The rotation of dice depends on user inputs
sum=0
while [ $dice -gt 0 ]; do
    roll=$(( $RANDOM % $sides +1 ))
    sum=$(( $sum + $roll ))
    echo "Rolled $roll"
    dice=$((dice - 1))
done
echo "You rolled a total of $sum"

