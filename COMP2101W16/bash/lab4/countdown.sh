countdown=${1:-$counttime}
w=${#countdown}

while [ "$1" == "" ]; do
    echo "Invalid value";
    exit $errormessage
done

while [ $countdown >= 0 ]; do
    sleep 1 &
    printf "IT'S THE FINAL COUNTDOWN!!  %${w}d\r" "$countdown" 
    countdown=$(( $countdown - 1 ))
    wait
done

echo "You enter wronge value!"
exit 1
# script is over 
