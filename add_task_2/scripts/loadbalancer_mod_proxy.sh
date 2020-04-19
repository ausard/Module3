yum install httpd-devel apr apr-devel apr-util apr-util-devel gcc make libtool autoconf wget -y
yum install mod_ssl -y
sudo setenforce 0

openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=BY/ST=ASab/L=Vitebsk/O=Dis/CN=module3" \
    -keyout /etc/pki/tls/private/module3.key \
    -out /etc/pki/tls/certs/module3.crt

cd /home/vagrant


sudo systemctl restart httpd

sudo systemctl start httpd
sudo systemctl enable httpd
