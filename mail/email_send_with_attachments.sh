#!/bin/bash

for i in $(\ls directory_containing_files/);
do
        echo -e "\nUPLOADING FILE $i";
        sendEmail -f destination_account1@gmail.com -t destination_account2@gmail.com -t source_account@gmail.com -s smtp.gmail.com:587 -u "$i" -m "$i" -o tls=yes -xu source_account -xp source_account_password -a "directory_containing_files/$i";
done