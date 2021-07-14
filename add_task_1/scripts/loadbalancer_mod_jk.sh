#!/bin/bash
sudo yum install httpd httpd-devel apr apr-devel apr-util apr-util-devel gcc make libtool autoconf wget -y
setenforce 0
yum install mod_ssl -y
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo systemctl start httpd
sudo systemctl enable httpd

#install mod_jk.so
wget https://downloads.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
tar xf tomcat-connectors*.tar.gz
cd tomcat-connectors-1.2.48-src/native/
./configure --with-apxs=/usr/bin/apxs
make && make install
chmod 755 /usr/lib64/httpd/modules/mod_jk.so

openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=BY/ST=ASab/L=Vitebsk/O=Dis/CN=module3" \
    -keyout /etc/pki/tls/private/module3.key \
    -out /etc/pki/tls/certs/module3.crt

mkdir -p /www/module3

cd /home/vagrant
sudo cp lb/http-jk.conf /etc/httpd/conf.modules.d/
sudo cp lb/vhost_jk.conf /etc/httpd/conf.modules.d/
sudo cp workers.properties /etc/httpd/conf/

sudo systemctl start httpd
sudo systemctl restart httpd

