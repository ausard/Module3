yum install httpd-devel apr apr-devel apr-util apr-util-devel gcc make libtool autoconf wget -y
yum install mod_ssl -y
sudo setenforce 0

cd /home/vagrant



openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=BY/ST=ASab/L=Vitebsk/O=Dis/CN=module3" \
    -keyout /etc/pki/tls/private/module3.key \
    -out /etc/pki/tls/certs/module3.crt


sudo cp lb/vhost.conf /etc/httpd/conf.d/

sudo cp lb/mod_proxy.conf /etc/httpd/conf.modules.d/
sudo cp lb/vhost.conf /etc/httpd/conf.d/
sudo cp lb/module3-ssl.conf /etc/httpd/conf.d/

sudo systemctl restart httpd

sudo systemctl start httpd
sudo systemctl enable httpd
