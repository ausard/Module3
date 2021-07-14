yum install httpd-devel apr apr-devel apr-util apr-util-devel gcc make libtool autoconf wget -y
sudo setenforce 0

cd /home/vagrant
sudo cp lb/vhost.conf /etc/httpd/conf.d/

sudo systemctl start httpd
sudo systemctl enable httpd
