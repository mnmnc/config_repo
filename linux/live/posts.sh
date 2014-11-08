#!/bin/bash
curl -c cookies.jar -s -k -d "username=user&password=passwd&login=Zaloguj&redirect=./index.php?" https://forum.pl/ucp.php?mode=login --location https://forum.pl/index.php >> /dev/null

check=`curl -k -s --cookie cookies.jar --cookie-jar newcookies.txt --location https://forum.pl/search.php?search_id=unreadposts | grep "nic nie znalaz\|najpierw" | wc -l`
curl -k -s --cookie cookies.jar --cookie-jar newcookies.txt --location https://forum.pl/search.php?search_id=unreadposts  > /var/log/infinz.posts

check2=$(curl -s https://register.jabber.org/ | grep "temporarily disabled account registration" | wc -l);
check3=$(curl -s -I https://register.jabber.org/ | grep "200 OK" | wc -l);

if [[ $check -lt 1 ]];
then
	echo "| FORUM POST |" | wall
fi

if [[ $check2 -lt 1 && $check3 -eq 1 ]];
then
	echo "| YOU MAY REGISTER AT JABBER.ORG NOW |" | wall ;
fi


rm cookies.jar
rm newcookies.txt

