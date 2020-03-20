#!/bin/bash

# Install NGINX
dbuser='ghost'
dbpass='ghost1234'
dbname='ghost'
IPADDR=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

sudo apt install -y nginx
sudo ugw allow 80/tcp

sudo npm install ghost-cli@latest -g
sudo mkdir -p /var/www/ghost/
sudo setfacl -R -m u:ubuntu:rwx /var/www/ghost/
sudo chmod 775 /var/www/ghost

cd /var/www/ghost
ghost install --no-setup
ghost setup --url=http://$IPADDR --dbhost=localhost --dbuser=$dbuser --dbpass=$dbpass --dbname=$dbname --start --no-prompt
