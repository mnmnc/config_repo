#!/bin/bash
combined="";
function mail() {
        atomlines=`wget -T 3 -t 1 -q --secure-protocol=TLSv1 \
         --no-check-certificate \
         --user=$1 --password=$2 \
         https://mail.google.com/mail/feed/atom -O -`
        user=$(echo "$1" | cut -b -5);
        check=$(echo "$atomlines" | tr ">" "\n" | grep "</fullcount" | cut -d "<" -f 1);
        if [[ $check -ne 0 ]]; then
                combined="$combined\n *** @ *** $user ";
        fi
}

mail "email1@gmail.com" "password"
mail "email2@gmail.com" "password"

check=$(echo -e "$combined" | wc -c )

if [[ $check -gt 5 ]];
then
        echo -e "$combined" | wall
fi
