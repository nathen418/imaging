#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/up>
echo -e "\e[31mTHIS SCRIPT REQUIRES YOU TO ANSWER PROMPTS, IT IS NOT UNATENDED!. Press any key to continue.\e[0m"
read -n 1 -s
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt install update-manager-core
sudo do-release-upgrade -d
echo -e "\e[31mTHIS SCRIPT WILL REBOOT YOUR COMPUTER. PRESS ANY KEY TO CONTINUE!\e[0m"
read -n 1 -s
sudo reboot
