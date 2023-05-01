#!/bin/bash

# This script is acessable at this link: https://antaresnetwork.com/scripts/setup-stage-2.sh

echo "Hello, this script will configure a VM from a template."
echo "Updating"

# Update & Upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

echo "Setting the hostname"
read -p "What should the hostname be: " hostname
sudo hostnamectl set-hostname "$hostname"

echo "Setting up JumpCloud on this device"
read -p "What is the JumpCloud connection id (x-connect-key)?" key
header="x-connect-key: $key"

wget -q --header "$header" https://kickstart.jumpcloud.com/Kickstart
echo "Running the JumpCloud Install Script"
bash Kickstart

read -p "This machine needs to reboot. Is that OK? (y/n)"  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
sudo rm Kickstart
sudo reboot
