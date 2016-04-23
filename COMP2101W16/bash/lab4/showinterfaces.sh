#!/bin/bash
#command reveals the two interfaces and IPV4 addresses
###
defaultroute=0 #command won't provide  default root

declare -A ip # declared the ip addresses

declare -a int # Array of interface names provide on the command line

declare -a interface # array of discovered interface names


help_function() {

	cat <<-EOF
	        This Scipt will print the IPv4 addresses
	        acoording to the given arguments
	        If interface name not given script will print info of all interfaces

	        optional arguments

	        ./filename -r or --route    # comman would produce default route
		    ./filename interfacename    # IP address of interface would be displayed by system
	EOF

}


error-message () {

	echo "error message $filename: $1 " >&2
	echo "use -h or --help option to get help"


}
# here we can get names of interfaces and -r|--route

while [ $# -gt 0 ]; do
    case "$1" in
    -h| --help )
        help_function
        exit 0
        ;;

    -r|--route )
        defaultroute=1 
        shift

        ;;

    *)
        if [ $? -eq 0 ]; then

                int+=("$1") 
        else
                exit 1
        fi

    ;;

    esac
    shift
done

interface=(`ifconfig |grep '^[A-Za-z]'|awk '{print $1}'`)

# here we can  get the IP addresses, save options is available in our system
for intf in ${interface[@]}; do
    ip[$intf]=`ifconfig $intf|grep "inet "|sed -e 's/.*inet addr://' -e 's/ .*//'`
done

# Default gateway available 
gwip=`route -n|grep '^0.0.0.0'|awk '{print $2}'`

# it provide basic information

if [ ${#int[@]} -gt 0 ]; then
    for intf in ${int[@]}; do
        if [ ${ip[$intf]} ]; then
            echo "$intf has address ${ip[$intf]}"
        else # incorrect interface user  
            error-message "$intf is not an interface on this host or has no ip address assigned"
        fi
    done
else
    for intf in ${interface[@]}; do
         echo "$intf has address ${ip[$intf]}"
    done 
fi

# display the default route gateway if we are given -r or --route on the command line
[ $defaultroute -eq 1 ] && echo "The default route is through $gwip"


