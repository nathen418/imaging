#!/bin/bash
read -p "YOU ARE ABOUT TO UNINSTALL DOCKER AND REMOVE ALL DOCKER CONTAINERS AND THEIR DATA. DO YOU WANT TO DO THIS? (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
read -p "Are you sure? (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
read -p "Really? This is the last chance to quit. (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
sudo apt-get purge -y docker.io
sudo rm -rf /var/lib/docker /etc/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /usr/local/bin/docker-compose
sudo rm -rf /etc/docker
sudo rm -rf ~/.docker
ech0 "Docker removed"
