#!/bin/bash
sudo -s

# Install nginx
sudo apt-get -y update
sudo apt-get -y install nginx
/etc/init.d/nginx start

# Install Thumbor
sudo apt-get -y install python-dev
sudo apt-get -y install python-pip
sudo add-apt-repository -y ppa:thumbor/ppa
sudo apt-get -y update
sudo apt-get -y install libjpeg-dev libpng-dev libtiff-dev libjasper-dev libgtk2.0-dev python-numpy python-pycurl webp python-opencv
sudo pip install thumbor
thumbor-config > /etc/thumbor.conf

# Install Supervisor
sudo pip install supervisor
sudo mkdir -p /home/ubuntu/logs/ # For Supervisor logs

sudo cp /vagrant/etc/thumbor.nginx /etc/nginx/conf.d/thumbor.conf
sudo cp /vagrant/etc/thumbor.supervisord /etc/supervisord.conf

# Start Supervisor
sudo supervisord -c /etc/supervisord.conf
# Restart nginx
sudo service nginx restart