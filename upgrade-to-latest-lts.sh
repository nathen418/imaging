#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/upgrade-to-latest-lts.sh

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt install update-manager-core
sudo do-release-upgrade -d
cat /etc/lsb-release
