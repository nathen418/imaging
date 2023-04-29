#!/bin/bash

read -p "This script will configure a VM from a template. Do you wish to continue? (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# Update & Upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

echo "Setting the hostname"
read -p "What should the hostname be: " hostname
sudo hostnamectl set-hostname "$hostname"

echo "Setting up JumpCloud on this device"
read -p "What is the jumpcoud connection id (x-connect-key)?" x-connect-key
curl --tlsv1.2 --silent --show-error --header 'x-connect-key: "$x-connect-key"' https://kickstart.jumpcloud.com/Kickstart | sudo bash

read -p "This machine needs to reboot. Is that OK? (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
sudo reboot
