#!/bin/bash

#nodesource PPA
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
#update package database
sudo apt-get update
#install NodeJS
sudo apt-get install -y nodejs
#install PM2 to support NodeJS application run-as-service
sudo npm install -g pm2
#start TodoList app as a service
cd /vagrant
npm install --no-bin-links        #restore application dependencies
pm2 start ecosystem.config.js     #start the application with PM2
pm2 save                          #save the current config for restarts
pm2 startup                       #enable PM2 startup system
#add PM2 configuration to systemd to restart application on reboot
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
#wait for service start
while ! nc -z localhost 3000; do   
  sleep 0.1 # wait for 1/10 of the second before the next check
done
#seed tasks
curl -X POST \
  http://localhost:3000/tasks \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 02a2e24a-5e6e-7612-82a1-0e3d3338eb2c' \
  -d name=Finish%20Vagrant%20Videos