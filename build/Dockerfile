FROM centos:7


RUN yum update -y && yum install epel-release -y && \
 yum install openvpn vim  nano net-tools easy-rsa -y 

ADD server.conf openvpn_verify.sh vars passwd.example.txt  clientonefile.sh /opt/temp/
ADD start.sh /

WORKDIR /opt/configs/

CMD /start.sh 

