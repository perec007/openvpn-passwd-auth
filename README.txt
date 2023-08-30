docker exec -it openvpn-cabadmin /opt/configs/openvpn/./clientonefile.sh client

Massive add users:
users="User1:pass123 User2:123 User3:123 User4:123 User5:Pass123 "
for i in $users; do 
echo "`echo $i|cut -d':' -f 1`:`echo $i|cut -d ":" -f 2 |md5sum|cut -d ' ' -f1`"; done


client soft:
Windows:
https://openvpn.net/community-downloads/
openvpn version 2.6.6

MacOS:
https://tunnelblick.net

