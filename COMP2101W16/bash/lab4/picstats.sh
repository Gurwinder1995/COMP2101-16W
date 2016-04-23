#!/bin/bash
#after applying, we will get main three biggest files in our directory. it also provide basic info about these files.
# for instance: name,space useage, size.
#default directory
dir=~/Pictures
#defult number
temp=3
#help function for the user
help_function() {
	
	cat <<-EOF
		        Script will count the pictures in Directory
		        And size of the Directory 
		        also print name and size of number of largest files in the directory
                
                Option Arguments
                
                -c and --count  to count the Number of files 
                 
                Example:
                ./filename -c 4 lib # print the 4 largest Pictures
	EOF
}



#error message 
error-message () {
	
	echo "error message $filename: $1 " >&2

	
}

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help )  # to execute help function
            help_function
            exit 0
            ;;
    -c | --count )
            
            temp=$2
            shift
            
            ;;
    * )
            
            dir=~/$1
        ;;
    esac
    shift
done 


# command for count the number of files in a directory
            number=$( find $dir -type f | wc -l)
            echo "Number of Pictures in $dir are $number"

if [ $number -gt 0 ]; then

    echo "The $dir directory uses:"
    du -sh $dir
    echo "The $temp largest Pictures in the ~/$dir directory are:"
    cd $dir
    #for 3 largest files
    find . -type f -exec du -h {} \; | sort -h | tail -$temp

else

    error-message " Wrong Arguments"
    echo "type -h or --help to get help"

fi
