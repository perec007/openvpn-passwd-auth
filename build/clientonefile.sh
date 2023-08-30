#!/bin/bash

(
echo "# $1-$PROJECTNAME"
echo "client" 
echo "dev tun" 
echo "proto tcp" 
echo "remote $OVPN_BIND $OVPN_PORT"
echo "resolv-retry infinite" 
echo "nobind" 
echo "persist-key" 
echo "persist-tun" 
echo "ns-cert-type server" 
echo "verb 2" 
echo "redirect-gateway"
echo "auth-user-pass"


echo "<ca>" 
cat /opt/configs/openvpn/easy-rsa/pki/ca.crt
echo "</ca>" 

echo "<cert>" 
cat "/opt/configs/openvpn/easy-rsa/pki/issued/$1.crt"
echo "</cert>" 

echo "<key>" 
cat /opt/configs/openvpn/easy-rsa/pki/private/$1.key
echo "</key>" 

#echo "<tls-auth>" 
#cat keys/ta.key
#echo "</tls-auth>" 

) > /tmp/$1-$PROJECTNAME.ovpn

cd /tmp
# echo 'echo << EOF'
tar cz $1-$PROJECTNAME.ovpn | base64 -w 160
# echo 'EOF | base64 -d | tar xvz --numeric-owner'



