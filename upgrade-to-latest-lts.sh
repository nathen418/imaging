#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/upgrade-to-latest.sh

echo -e "\e[31mTHIS SCRIPT REQUIRES YOU TO ANSWER PROMPTS, IT IS NOT UNATENDED!. Press any key to continue.\e[0m"
sleep 10
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt install update-manager-core
sudo do-release-upgrade -d
echo -e "\e[31mYOU NEED TO REBOOT YOUR SYSTEM FOR CHANGES TO TAKE EFFECT!\e[0m"
