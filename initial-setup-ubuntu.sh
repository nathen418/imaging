#!/bin/bash

# This script is acessable at this link: https://playantares.com/scripts/initial-setup-ubuntu.sh

sudo apt update
sudo apt upgrade -y
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades
sudo passwd -l root
sudo apt install openssh-server -y
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]yes/c\PasswordAuthentication no" /etc/ssh/sshd_config
sudo service sshd restart
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
sudo timedatectl set-timezone America/Chicago
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
echo "y" | sudo ufw enable
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/fail2ban.{conf,local}
sudo cp /etc/fail2ban/jail.{conf,local}
sudo sed -i "/^[^#]*backend = auto/c\backend = systemd" /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
sudo apt install git speedtest-cli glances -y
sudo snap install bashtop
