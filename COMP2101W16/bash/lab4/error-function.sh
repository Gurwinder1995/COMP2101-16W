#!/bin/bash
#it show error on every single resuls
#such as if you give any command or value it always shows error message 

read -p "Write a number between 1 to 10? " errormessage

function error-message
{
    PROGNAME=$(basename $0)
	echo "${PROGNAME}: $errormessage" >&1 | tee | head -1
	exit 1
}

while [ $errormessage != "" ]; do
    echo "Error message"
    echo "$errormessage" | tee /dev/stderr | wc
    exit 1
done
