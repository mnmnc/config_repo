#!/bin/bash
combined="";
function mail() {
	atomlines=`wget -T 3 -t 1 -q --secure-protocol=TLSv1 \
	 --no-check-certificate \
	 --user=$1 --password=$2 \
	 https://mail.google.com/mail/feed/atom -O -`
	user=$(echo "$1" | cut -b -2);
	check=$(echo "$atomlines" | tr ">" "\n" | grep "</fullcount" | cut -d "<" -f 1);
	if [[ $check -ne 0 ]]; then
		combined="$combined$user";
	fi
}

mail "username" "passwd"

check=$(echo -en "$combined" | wc -c )


if [[ $check -gt 0 ]];
then
	echo -e "$combined" | wall
	/usr/bin/sendEmail -s smtp.gmail.com:587 -o tls=yes -f mail@gmail.com -t mail@outlook.com -u "$combined" -m " " -xu mail@gmail.com -xp "passwd"
fi

