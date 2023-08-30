#!/bin/bash -x 
env ; ls /opt/configs


if [  ! -d  /opt/configs/easy-rsa  ]; then 
	mkdir -p /opt/configs/easy-rsa
    	cp -r  /usr/share/easy-rsa/ /opt/configs/
	cp /opt/temp/vars /opt/configs/easy-rsa/3

    	cd /opt/configs/easy-rsa/3
    	./easyrsa init-pki
	echo "ca" | ./easyrsa build-ca nopass
	./easyrsa build-server-full server nopass
	./easyrsa build-client-full client nopass
	./easyrsa gen-dh
	
fi

if [ ! -d /opt/configs/openvpn ]; then
	mkdir -p /opt/configs/openvpn/
	cp /opt/temp/server.conf /opt/configs/openvpn/
	cp /opt/temp/openvpn_verify.sh /opt/configs/openvpn/
	cp /opt/temp/clientonefile.sh /opt/configs/openvpn/
	ln -s /opt/configs/easy-rsa/3 /opt/configs/openvpn/easy-rsa
fi

if [ ! -d /opt/configs/secrets ]; then
	mkdir -p /opt/configs/secrets
	cp /opt/temp/passwd.example.txt /opt/configs/secrets/
	echo "READ FILE /opt/configs/secrets/ passwd.example.txt!"
fi

/usr/sbin/openvpn --config /opt/configs/openvpn/server.conf --server $OVPN_NET --port $OVPN_PORT --local $OVPN_BIND
