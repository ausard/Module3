#!/bin/bash

sudo yum install java-1.8.0-openjdk-devel wget -y

# Add Tomcat user
sudo useradd -m -U -d /usr/share/tomcat/ -s /bin/false tomcat

# Download Tomcat
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.34/bin/apache-tomcat-9.0.34.tar.gz
tar xvf apache-tomcat-9*tar.gz -C /usr/share/tomcat --strip-components=1


# Assign ownership over target directory
cd /usr/share/tomcat
sudo chgrp -R tomcat /usr/share/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/


# Copy basic Tomcat configuration files
cd /home/vagrant
sudo cp webapps/config/context.xml /usr/share/tomcat/webapps/manager/META-INF/
sudo cp webapps/config/context.xml /usr/share/tomcat/webapps/host-manager/META-INF/
sudo cp webapps/config/tomcat-users.xml /usr/share/tomcat/conf/
sudo cp webapps/config/server.xml /usr/share/tomcat/conf/

# Create webapp in the source folder
mkdir /usr/share/tomcat/webapps/module3
cat << EOF > /usr/share/tomcat/webapps/module3/index.html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Module3</title>
    <meta name="description">
  </head>
  <body>
    <p>Hello from $(hostname)</p>
  </body>
</html>
EOF

# Copy service file and reload daemon
sudo cp webapps/config/tomcat.service /etc/systemd/system/
sudo systemctl daemon-reload

sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl restart tomcat
