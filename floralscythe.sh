#!/bin/bash

username=$1
minsleep=$2
dlfile=$3
maxsleep=$(($minsleep + $(( $RANDOM % 20 + 1 ))))
password=`cat ~/.pscred`

banner () {
    case $3 in 
        RED)COLOR='\033[0;31m'
        ;;CYAN)COLOR='\033[0;36m'
        ;;GREEN)COLOR='\033[0;32m'
        ;;LGREEN)COLOR='\033[1;32m'
        ;;PURPLE)COLOR='\033[0;35m'
        ;;BROWN)COLOR='\033[0;33m'
        ;;*)
        COLOR='\033[0m'
        ;;esac
    NC='\033[0m'
    message="$2 $1 $2"
    mlength=${#message}
    banner="$(printf "$2%.0s" $(seq 1 $mlength))"
    if [ ${#banner} -gt 0 ]
    then
        banner="\n$banner\n"
    fi
    printf "${COLOR}$banner$message$banner${NC}\n"
}

if [ "$minsleep" -lt 100 ] 
then
    banner "ERROR: You need at least 100 seconds of sleep or you will be Throttled." "" "RED"
    exit
fi
if ! youtube-dl --version COMMAND &> /dev/null
then
    banner "YOUTUBE-DL could not be found" "" "RED"
    exit
else
    banner "Youtube-DL Version: $(youtube-dl --version) : OK" "" "GREEN"
fi
if ! jq --version COMMAND &> /dev/null
then
    banner "JQ could not be found" "" "RED"
    exit
else
    banner "JQ Version: $(jq --version) : OK" "" "GREEN"
fi

if [ "$password" == "" ] 
then
    password=$PLURALPASS

    if [ "$password" == "" ] 
    then
        banner "ERROR: You need to put your Pluralsight password in ~/.pscred" "" "BROWN"
        banner "OR export it as PLURALPASS env variable (run 'export PLURALPASS=P@ssw0rd')\n" "" "RED"
        exit
    fi
fi

banner "I LOVE FLORAL SCYTHE" "#" "PURPLE"

jq -cr '.[][] | [.url, .start]' $dlfile | while read i; do
    course=$(echo $i | jq -r '.[0]')
    start=$(echo $i | jq -r '.[1]')
    sleep=$(( $RANDOM % $maxsleep + $minsleep ))

    banner "DOWNLOADING $course STARTING AT $start" "#" "LGREEN"

    youtube-dl -u $username -p $password -o "%(playlist)s/%(chapter_number)s - %(chapter)s/%(playlist_index)s - %(title)s.%(ext)s" --add-header Referer:"https://app.pluralsight.com/library/courses/" --add-header user-agent:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36" --min-sleep-interval $minsleep --max-sleep-interval $maxsleep "$course" --playlist-start $start

    banner "SLEEPING FOR $sleep sec IN BETWEEN COURSE DOWNLOAD TO PREVENT THROTTLING" "#" "CYAN"
    sleep $sleep
done


# This code looks like shit but it works lol