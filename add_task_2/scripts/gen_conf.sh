#!/bin/bash
cat << EOF > /home/vagrant/module3.conf
<VirtualHost *:80>
<Proxy balancer://cluster>
EOF
for ((i = 1; i <= $1; i++ ))
do
echo "BalancerMember http://"$2"1"$i":8080/module3" >> /home/vagrant/module3.conf
done
cat << EOF >> /home/vagrant/module3.conf
</Proxy>
ProxyPreserveHost On
ProxyPass / balancer://cluster/
ProxyPassReverse / balancer://cluster/
</VirtualHost>
EOF

cat << EOF > /home/vagrant/module3_ssl.conf
LoadModule ssl_module modules/mod_ssl.so
<VirtualHost *:443>
ServerName localhost:443
SSLEngine on
SSLCertificateFile /etc/pki/tls/certs/module3.crt
SSLCertificateKeyFile /etc/pki/tls/private/module3.key
<Proxy balancer://cluster>
EOF
for ((i = 1; i <= $1; i++ ))
do
echo "BalancerMember http://$2"$i":8080/module3" >> /home/vagrant/module3_ssl.conf
done
cat << EOF >> /home/vagrant/module3_ssl.conf
</Proxy>
ProxyPreserveHost On
ProxyPass / balancer://cluster/
ProxyPassReverse / balancer://cluster/
</VirtualHost>
EOF
