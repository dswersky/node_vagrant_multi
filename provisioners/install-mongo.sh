#!/bin/bash

#get GPG key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
#create a sources list file
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
#reload package database
sudo apt-get update
#install Mongo
sudo apt-get install -y mongodb-org
#copy custom mongo config
sudo mv mongod.conf /etc/mongod.conf
#start mongo
systemctl enable mongod.service
sudo service mongod start