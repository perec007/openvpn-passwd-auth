#!/bin/bash
## format: username:password username:password ...
## you can even have same usernames with different passwords
# USERS='user1:pass1 user2:pass2 user3:pass3'
## you could put username:password in
## a separate file and read it like this

LOGFILE=/opt/configs/secrets/passwd_verify.log

rand="/tmp/auth${RANDOM}"

## $1 is file name which contains
## passed username and password
user=`cat $1 | head -1|sed "s/-//"`
pass1=`cat $1 | tail -n 1|md5sum | cut -f 1 -d ' ' | tr '[:upper:]' '[:lower:]'  `
pass2=`printf $pass1 | tr '[:lower:]' '[:upper:]'  `

#vpn_verify "$user:$pass"

egrep -q "$user:($pass1|$pass2)" /opt/configs/secrets/passwd.txt

if [ $? -eq 0 ]; then 
        echo `date` "ACCEPT: $user" >> $LOGFILE
        exit 0
else 
        cp $1 $rand
        echo `date` "DENY: $user $rand" >> $LOGFILE
        exit 1
fi

